#import "QTPPXHeader.h"
#import "QTSettingViewController.h"

/*
更新功能提示
*/
%hook BDSTabBarController

- (void)viewDidLoad {
    
    %orig;
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"QuattroUpdateTipKey"] == NO) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            BDSStyledAlertController *alertVC = [%c(BDSStyledAlertController) alertControllerWithTitle:@"更新提示" message:@"1.播放视频支持自定义倍数播放，可前往插件设置里开启"];
            BDSStyledAlertAction *okAction = [%c(BDSStyledAlertAction) actionWithTitle:@"立即前往" handler:^(BDSStyledAlertAction * _Nonnull action) {

                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"QuattroUpdateTipKey"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                QTSettingViewController *settingViewController = [[QTSettingViewController alloc] init];
                [self.navigationController pushViewController:settingViewController animated:YES];
            }];
            [alertVC addAction:okAction];
            [self presentViewController:alertVC animated:YES completion:nil];
        });
    }
}

%end

/*
新增默认倍速播放
*/
%hook BDSPlayerView

// arg1 == 1 准备播放， 2 -- 播放中， 3 -- 暂停播放 5 --- 结束播放
- (void)callbackPlayStatusDidChanged:(long long)arg1 {
    
    if (arg1 == 2) {
        NSString *rate = [[NSUserDefaults standardUserDefaults] objectForKey:@"BDSVideoRatePlay"];
        if ([rate isEqualToString:@"0.75"]) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self changePlaySpeedTemporarilyTo:0.75];
            });
            BDSPlayerGestureController* gestureController = MSHookIvar<BDSPlayerGestureController*>(self,"_gestureController");
            [self bds_gestureController:gestureController longPressIsBegin:YES longPressIsChanging:NO longPressDidEnd:NO];
        } else if ([rate isEqualToString:@"1.25"]) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self changePlaySpeedTemporarilyTo:1.25];
            });
            BDSPlayerGestureController* gestureController = MSHookIvar<BDSPlayerGestureController*>(self,"_gestureController");
            [self bds_gestureController:gestureController longPressIsBegin:YES longPressIsChanging:NO longPressDidEnd:NO];
        } else if ([rate isEqualToString:@"1.5"]) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self changePlaySpeedTemporarilyTo:1.5];
            });
            BDSPlayerGestureController* gestureController = MSHookIvar<BDSPlayerGestureController*>(self,"_gestureController");
            [self bds_gestureController:gestureController longPressIsBegin:YES longPressIsChanging:NO longPressDidEnd:NO];
        } else if ([rate isEqualToString:@"2.0"]) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self changePlaySpeedTemporarilyTo:2.0];
            });
            BDSPlayerGestureController* gestureController = MSHookIvar<BDSPlayerGestureController*>(self,"_gestureController");
            [self bds_gestureController:gestureController longPressIsBegin:YES longPressIsChanging:NO longPressDidEnd:NO];
        }
    }
    %orig;
}

%end

%hook BDSPlayerMaxSpeedForwardView

- (id)descriptionString {
    
    NSString *rate = [[NSUserDefaults standardUserDefaults] objectForKey:@"BDSVideoRatePlay"];
    if (!rate) {
        return %orig;
    }
    if ([rate isEqualToString:@"2.0"]) {
        return %orig;
    }
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@X快进中", rate]];
    UIFont *regularFont = [UIFont fontWithName:@"PingFangSC-Regular" size:10.0];
    [attributedString addAttribute:NSFontAttributeName value:regularFont range:NSMakeRange(0, attributedString.length)];
    UIColor *foregroundColor = [UIColor whiteColor];
    [attributedString addAttribute:NSForegroundColorAttributeName value:foregroundColor range:NSMakeRange(0, attributedString.length)];
    UIColor *customColor = [UIColor colorWithRed:1.0 green:0.4078 blue:0.5019 alpha:1.0];
    [attributedString addAttribute:NSForegroundColorAttributeName value:customColor range:NSMakeRange(0, rate.length+1)];
    UIFont *mediumFont = [UIFont fontWithName:@"PingFangSC-Medium" size:10.0];
    [attributedString addAttribute:NSFontAttributeName value:mediumFont range:NSMakeRange(0, rate.length+1)];
    return attributedString;
}

%end

/*
设置界面新增插件按钮
*/

%hook BDSSettingsViewController

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    BDSSettingsViewModel* viewModel = MSHookIvar<BDSSettingsViewModel*>(self,"_viewModel");
    NSArray *array = [viewModel settingsModelArray];
    if (array.count > 0) {
        BDSSettingsCellStyleModel *model = array[indexPath.section];
        if (model.modelType == 998) {
            QTSettingViewController *settingViewController = [[QTSettingViewController alloc] init];
            [self.navigationController pushViewController:settingViewController animated:YES];
            return;
        }
    }
    %orig;
}

%end

%hook BDSSettingsViewModel

- (NSArray *)noLoginSettingsModelArray {

    NSMutableArray *origArr = [NSMutableArray arrayWithArray:%orig];
    if (origArr.count > 0) {
        BDSSettingsCellStyleModel *model = [[%c(BDSSettingsCellStyleModel) alloc] init];
        model.title = @"插件设置";
        model.modelType = 998;
        model.enableSelected = YES;
        model.cellStyleType = 0;
        [origArr insertObject:model atIndex:0];
    }
    return origArr;
}

- (NSArray *)loginSettingsModelArray {

    NSMutableArray *origArr = [NSMutableArray arrayWithArray:%orig];
    if (origArr.count > 0) {
        BDSSettingsCellStyleModel *model = [[%c(BDSSettingsCellStyleModel) alloc] init];
        model.title = @"插件设置";
        model.modelType = 998;
        model.enableSelected = YES;
        model.cellStyleType = 0;
        [origArr insertObject:model atIndex:0];
    }
    return origArr;
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