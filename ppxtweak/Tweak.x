
#import <UIKit/UIKit.h>

@interface BDSADInfoEntity : NSObject

@end

@interface BDSFeedDataModel : NSObject

@property(retain, nonatomic) BDSADInfoEntity *adInfo;

@end

@interface BDASplashSkipButton : UIButton

@end

@interface BDASplashView : UIView

@property(retain, nonatomic) BDASplashSkipButton *skipButton; // @synthesize skipButton=_skipButton;
- (void)skipButtonClicked:(id)arg1;

@end

@interface BDASplashControllerView : UIView

@property(retain, nonatomic) BDASplashView *splashView;

@end

@interface BDSCommentADCellViewModel : NSObject

@end

@interface BDSCommentCellViewModel : NSObject

@property(retain, nonatomic) id contentData; // @synthesize contentData=_contentData;

@end

@interface BDSVideoUrlEntity : NSObject

@property(copy, nonatomic) NSString *url; // @synthesize url=_url;

@end

@interface BDSBaseBusinessModel : NSObject

@end

@interface BDSFeedBaseEntity : BDSBaseBusinessModel

@end

@interface BDSShareEntity : BDSBaseBusinessModel

@property(retain, nonatomic) NSArray *videoUrls; // @synthesize videoUrls=_videoUrls;
@property(copy, nonatomic) NSArray *godCommentUrlList; // @synthesize godCommentUrlList=_godCommentUrlList;

@end

@interface BDSVideoEntity : BDSBaseBusinessModel

@property(retain, nonatomic) NSArray *urlList; // @synthesize urlList=_urlList;
@property(retain, nonatomic) NSArray *godCommentUrlList; // @synthesize godCommentUrlList=_godCommentUrlList;

@end

@interface BDSItemVideoEntity : BDSBaseBusinessModel

@property(retain, nonatomic) BDSVideoEntity *videoDownload; // @synthesize videoDownload=_videoDownload;

@end

@interface BDSHeavyItemEntity : BDSFeedBaseEntity

@property(retain, nonatomic) BDSItemVideoEntity *video; // @synthesize video=_video;
@property(retain, nonatomic) BDSShareEntity *share; // @synthesize share=_share;
@property(retain, nonatomic) BDSVideoEntity *originVideoDownload; // @synthesize originVideoDownload=_originVideoDownload;

@end

@interface BDSDetailNativeViewModel : NSObject

@property(readonly, nonatomic) BDSHeavyItemEntity *heavyItem; // @synthesize heavyItem=_heavyItem;

@end

@interface BDSCommentEntity : BDSBaseBusinessModel

@property(nonatomic) long long type; // @synthesize type=_type;
@property(copy, nonatomic) NSArray *images; // @synthesize images=_images;
@property(retain, nonatomic) BDSVideoEntity *video; // @synthesize video=_video;
@property(retain, nonatomic) BDSVideoEntity *videoDownload; // @synthesize videoDownload=_videoDownload;
@property(retain, nonatomic) BDSShareEntity *share; // @synthesize share=_share;

@end

@interface BDSImageInfosModel : BDSBaseBusinessModel

@property(copy, nonatomic) NSArray *urlList; // @synthesize urlList=_urlList;
@property(copy, nonatomic) NSArray *downloadURLList; // @synthesize downloadURLList=_downloadURLList;

@end

@interface BDSUserCellStyleModel : NSObject

@property(copy, nonatomic) NSString *actionURL; // @synthesize actionURL=_actionURL;
@property(copy, nonatomic) NSString *iconURL; // @synthesize iconURL=_iconURL;
@property(copy, nonatomic) NSString *title; // @synthesize title=_title;

@end

@interface BDSUserHomeCellStyleModel : BDSUserCellStyleModel

@property(copy, nonatomic) NSString *eventName; // @synthesize eventName=_eventName;
@property(copy, nonatomic) NSDictionary *eventParams; // @synthesize eventParams=_eventParams;

@end

@interface BDSUserHomeFooterCell : UITableViewCell

- (void)configCellWithModels:(NSArray *)arg1;

@end


@interface BDSUserHomeViewController : UIViewController

- (void)openURLWithModel:(BDSUserHomeCellStyleModel *)arg1 tableView:(id)arg2 IndexPath:(id)arg3;

@end

@interface BDSUserBaseCell : UITableViewCell

- (void)configCellWithModel:(BDSUserHomeCellStyleModel *)arg1;

@end

/*
我的界面新增插件按钮
*/

%hook BDSUserHomeViewController

- (void)openURLWithModel:(BDSUserHomeCellStyleModel *)arg1 tableView:(id)arg2 IndexPath:(id)arg3 {

    if ([arg1.actionURL == @"ppx.quatrro.setting"]) {
        QTSettingViewController *settingViewController = [[QTSettingViewController alloc] init];
        [self.navigationController PushViewController:settingViewController animated:YES];
        retain;
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
