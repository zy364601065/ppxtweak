//
//  QTPPXHeader.h
//  Cherish
//
//  Created by zy on 2023/4/11.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>

#pragma clang assume_nonnull begin

#define kBDSVideoRatePlay @"BDSVideoRatePlay"
#define QTFile(path) @"/Library/PreferenceLoader/Preferences/ZY_PPX/" #path

/// ---------------------- 工具类 -------------------
@interface BDSPlayerSpeedItemConfig : NSObject

+ (id)speedTextWithSpeed:(double)arg1;

@end

@interface BDSPlayerSettingsManager : NSObject

+ (long long)videoMaxSpeedRatio;

@end

@interface BDSPlayerTipsHelper : NSObject

+ (id)tipStringForSpeedChangedToSpeed:(double)arg1;

@end

@interface BDSPlayerLoggerHelper : NSObject

- (void)sendLongPressSpeedEvent;
- (void)sendPlaySpeedShowEvent;

@end

@interface BDSPlayerGestureController : NSObject

@property(nonatomic) double currentSpeed; // @synthesize currentSpeed=_currentSpeed;
@property(retain, nonatomic) UILongPressGestureRecognizer *longPressGesture; // @synthesize longPressGesture=_longPressGesture;
- (void)longPress:(id)arg1;

@end

/// ----------------------- 模型 ----------------------
@interface BDSADInfoEntity : NSObject

@end

@interface BDSFeedDataModel : NSObject

@property(retain, nonatomic) BDSADInfoEntity *adInfo;

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
@property(nonatomic) long long cellStyleType; // @synthesize cellStyleType=_cellStyleType;
@property(copy, nonatomic) NSString *detailDescrib; // @synthesize detailDescrib=_detailDescrib;
@property(copy, nonatomic) NSString *subTitle; // @synthesize subTitle=_subTitle;
@property(nonatomic) _Bool switchOn; // @synthesize switchOn=_switchOn;
@property(nonatomic) _Bool enableSelected; // @synthesize enableSelected=_enableSelected;

@end

@interface BDSUserHomeCellStyleModel : BDSUserCellStyleModel

@property(copy, nonatomic) NSString *eventName; // @synthesize eventName=_eventName;
@property(copy, nonatomic) NSDictionary *eventParams; // @synthesize eventParams=_eventParams;

@end

@interface BDSSettingsCellStyleModel : BDSUserCellStyleModel

@property(nonatomic) long long modelType; // @synthesize modelType=_modelType;

@end

@interface BDSSettingsViewModel : NSObject

@property(copy, nonatomic) NSArray *loginSettingsModelArray; // @synthesize loginSettingsModelArray=_loginSettingsModelArray;
@property(copy, nonatomic) NSArray *noLoginSettingsModelArray; // @synthesize noLoginSettingsModelArray=_noLoginSettingsModelArray;
- (NSArray *)settingsModelArray;

@end

/// ---------------------- UIView ---------------------
@interface BDASplashSkipButton : UIButton

@end

@interface BDASplashView : UIView

@property(retain, nonatomic) BDASplashSkipButton *skipButton; // @synthesize skipButton=_skipButton;
- (void)skipButtonClicked:(id)arg1;

@end

@interface BDASplashControllerView : UIView

@property(retain, nonatomic) BDASplashView *splashView;

@end

@interface BDSPlayerMaxSpeedForwardView : UIView

- (id)descriptionString;

@end

@interface BDSUserHomeFooterCell : UITableViewCell

- (void)configCellWithModels:(NSArray *)arg1;

@end

@protocol BDSUserBaseCellDelegate <NSObject>

@optional
- (void)didSwitchChangedWithSwitch:(UISwitch *)arg1 model:(BDSUserCellStyleModel *)arg2;
@end

@interface BDSUserBaseCell : UITableViewCell

- (void)configCellWithModel:(BDSSettingsCellStyleModel *)arg1;
@property(nonatomic, weak) id <BDSUserBaseCellDelegate> delegate; // @synthesize delegate=_delegate;

@end

@interface BDSNavigationBarItem : UIControl

- (id)initWithBarItemStyle:(unsigned long long)arg1;

@end

@interface BDSNavigationBar : UIControl

@property(retain, nonatomic) BDSNavigationBarItem *leftItem; // @synthesize leftItem=_leftItem;
@property(retain, nonatomic) BDSNavigationBarItem *rightItem; // @synthesize rightItem=_rightItem;
@property(retain, nonatomic) NSString *title; // @synthesize title=_title;

@end

@interface BDSPlayerView : UIView

@property(readonly, nonatomic) long long status;
@property(readonly, nonatomic) double playbackSpeed;
@property(retain, nonatomic) BDSPlayerGestureController *gestureController; // @synthesize gestureController=_gestureController;
- (void)changePlaySpeedTemporarilyTo:(double)arg1;
- (void)bds_gestureController:(id)arg1 longPressIsBegin:(_Bool)arg2 longPressIsChanging:(_Bool)arg3 longPressDidEnd:(_Bool)arg4;

@end

@interface BDSVideoPlayer : UIView

@property(retain, nonatomic) BDSPlayerLoggerHelper *loggerHelper; // @synthesize loggerHelper=_loggerHelper;
@property(retain, nonatomic) BDSPlayerView *playerView; // @synthesize playerView=_playerView;
@property(retain, nonatomic) UIButton *speedSelector; // @synthesize speedSelector=_speedSelector;

- (void)bdsPlayerView:(id)arg1 speedChangeFrom:(double)arg2 to:(double)arg3 byGesture:(_Bool)arg4;
- (void)bdsPlayerView:(id)arg1 longPressIsBegin:(_Bool)arg2 longPressIsChanging:(_Bool)arg3 longPressDidEnd:(_Bool)arg4;

@end

/// ---------------------- UIViewController ---------------------
@interface BDSUserHomeViewController : UIViewController

- (void)openURLWithModel:(BDSUserHomeCellStyleModel *)arg1 tableView:(id)arg2 IndexPath:(id)arg3;

@end

@interface TTTabBarController : UITabBarController

@end

@interface BDSTabBarController : TTTabBarController

@end

@interface BDSStyledAlertAction : UIControl

+ (id)actionWithTitle:(id)arg1 UIMode:(unsigned long long)arg2 handler:(id)arg3;
+ (id)actionWithTitle:(id)arg1 UIMode:(unsigned long long)arg2 touchDismiss:(_Bool)arg3 handler:(id)arg4;
+ (id)actionWithTitle:(id)arg1 handler:(void (^ __nullable)(BDSStyledAlertAction *action))arg2;

@end

@interface BDSAlertTransitionController : UIViewController

@end

@interface BDSStyledAlertController : BDSAlertTransitionController

+ (id)alertControllerWithTitle:(id)arg1 message:(id)arg2;
+ (id)alertControllerWithTitle:(id)arg1 message:(id)arg2 image:(id)arg3;
- (void)addAction:(id)arg1;

@end

@interface BDSSettingsViewController : UIViewController

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
@property(retain, nonatomic) BDSSettingsViewModel *viewModel; // @synthesize viewModel=_viewModel;

@end

#pragma clang assume_nonnull end