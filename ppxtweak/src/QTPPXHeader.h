//
//  QTPPXHeader.h
//  Cherish
//
//  Created by zy on 2023/4/11.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>

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

@interface BDSNavigationBar : UIControl

@property(retain, nonatomic) NSString *title; // @synthesize title=_title;

@end




