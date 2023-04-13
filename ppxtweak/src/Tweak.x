#import "QTPPXHeader.h"
#import "QTSettingViewController.h"

/*
我的界面新增插件按钮
*/

%hook BDSUserHomeViewController

- (void)openURLWithModel:(BDSUserHomeCellStyleModel *)arg1 tableView:(id)arg2 IndexPath:(id)arg3 {

    if ([[arg1 actionURL] isEqual:@"ppx.quatrro.setting"]) {
        QTSettingViewController *settingViewController = [[QTSettingViewController alloc] init];
        [self.navigationController pushViewController:settingViewController animated:YES];
        return;
    }
    %orig;
}

%end

%hook BDSUserHomeFooterCell

- (void)configCellWithModels:(NSArray *)arg1 {
    if (arg1.count > 0) {
        NSMutableArray *itemArray = [NSMutableArray arrayWithArray:arg1];
        BDSUserHomeCellStyleModel *model = [[%c(BDSUserHomeCellStyleModel) alloc] init];
        model.title = @"插件设置";
        model.iconURL = @"home_setting_icon";
        model.actionURL = @"ppx.quatrro.setting";
        model.eventName = @"my_profile_cell_click";
        model.eventParams = @{@"event_module": @"option"};
        [itemArray addObject:model];
        arg1 = itemArray;
    }
    %orig;
}

%end


// 列表去广告
%hook BDSMixedListBusinessBaseViewModel

- (NSArray *)allItems {

    NSMutableArray *origArr = [NSMutableArray arrayWithArray:%orig];;
    NSMutableArray *adArr = [NSMutableArray array];
    if (origArr.count > 0) {
        for (BDSFeedDataModel *model in origArr) {
            // BDSADInfoEntity *adInfo = MSHookIvar<BDSADInfoEntity *>(model, "_adInfo");
            BDSADInfoEntity *adInfo =[model adInfo];
            if (adInfo) {
                [adArr addObject:model];
            }
        }
    }
    if (adArr.count > 0) {
        [origArr removeObjectsInArray:adArr];
    }
    return origArr;
}

%end

// 详情去广告
%hook IGListBindingSectionController

- (NSArray *)viewModels {

    NSMutableArray *origArr = [NSMutableArray arrayWithArray:%orig];;
    NSMutableArray *adArr = [NSMutableArray array];
    if (origArr.count > 0) {
        for (id model in origArr) {
            if ([model isKindOfClass:%c(BDSCommentADCellViewModel)]) {
                [adArr addObject:model];
            }
        }
    }
    if (adArr.count > 0) {
        [origArr removeObjectsInArray:adArr];
    }
    // 下载无水印视频图片
    for (id model in origArr) {
        if ([model isKindOfClass:%c(BDSCommentCellViewModel)]) {
            BDSCommentCellViewModel *commentModel = (BDSCommentCellViewModel *)model;
            id contentData = [commentModel contentData];
            if ([contentData isKindOfClass:%c(BDSCommentEntity)]) {
                BDSCommentEntity *contentModel = (BDSCommentEntity *)contentData;
                if ([contentModel type] == 2) { // 图文动态
                    NSArray *images = [contentModel images];
                    if (images.count > 0) {
                        for (id imageModel in images) {
                            if ([imageModel isKindOfClass:%c(BDSImageInfosModel)]) {
                                BDSImageInfosModel *imageInfosModel = (BDSImageInfosModel *)imageModel;
                                if (imageInfosModel.urlList.count > 0 && imageInfosModel.downloadURLList.count > 0) {
                                    imageInfosModel.downloadURLList = imageInfosModel.urlList;
                                }
                            }
                        }
                    }
                } else if ([contentModel type] == 3) { // 视频动态
                    BDSVideoEntity *video = [contentModel video]; // 原视频
                    BDSVideoEntity *videoDownload = [contentModel videoDownload]; // 下载视频
                    BDSShareEntity *share = [contentModel share]; // 分享模型
                    NSMutableArray *originUrlList = [NSMutableArray array];
                    if (video) {
                        NSArray *urlList = [video urlList];
                        if (urlList.count > 0) {
                            for (BDSVideoUrlEntity *entity in urlList) {
                                [originUrlList addObject:[entity url]];
                            }
                        }
                        if (originUrlList.count > 0) {
                            if (share) {
                                share.videoUrls = originUrlList;
                                share.godCommentUrlList = originUrlList;
                            }
                            if (videoDownload) {
                                videoDownload.urlList = urlList;
                                videoDownload.godCommentUrlList = originUrlList;
                            }
                        }
                    }
                }
            }
        }
    }
    return origArr;
}

%end 

// 启动页
%hook BDASplashControllerView

- (void)splashViewReadyToShow {

    // BDASplashView *splashView = MSHookIvar<BDASplashView *>(self, "_splashView");
    BDASplashView *splashView = [self splashView];
    [splashView skipButtonClicked:[splashView skipButton]];
}

%end

// 下载无水印视频
%hook BDSDetailNativeContentViewController

- (BDSDetailNativeViewModel *)viewModel {
    
    BDSDetailNativeViewModel *newViewModel = %orig;
    BDSHeavyItemEntity *itemEntity = [newViewModel heavyItem];
    
    // 无水印视频
    BDSVideoEntity *originVideoDownload = [itemEntity originVideoDownload];
    if (originVideoDownload) {
        NSArray *urlList = [originVideoDownload urlList];
        NSMutableArray *originUrlList = [NSMutableArray array];
        if (urlList.count > 0) {
            for (BDSVideoUrlEntity *entity in urlList) {
                [originUrlList addObject:[entity url]];
            }
        }
        if (originUrlList.count > 0) {
            // 分享
            BDSShareEntity *share = [itemEntity share];
            if (share) {
                share.videoUrls = originUrlList;
                share.godCommentUrlList = originUrlList;
            }
            // 下载视频
            BDSItemVideoEntity *video = [itemEntity video];
            if (video) {
                BDSVideoEntity *videoDownload = [video videoDownload];
                if (videoDownload) {
                    videoDownload.urlList = urlList;
                    videoDownload.godCommentUrlList = originUrlList;
                }
            }
        }
    }
    return newViewModel;
}

%end
