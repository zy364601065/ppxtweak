
#import <UIKit/UIKit.h>

@interface BDSADInfoEntity : NSObject

@end

@interface BDSFeedDataModel : NSObject

@property(retain, nonatomic) BDSADInfoEntity *adInfo;

@end

@interface BDASplashView : UIView

- (void)skipButtonClicked;

@end

@interface BDASplashControllerView : UIView

@property(retain, nonatomic) BDASplashView *splashView;

@end


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

%hook BDASplashControllerView

- (void)splashViewReadyToShow {

    // BDASplashView *splashView = MSHookIvar<BDASplashView *>(self, "_splashView");
    BDASplashView *splashView = [self splashView];
    [splashView skipButtonClicked];
}

%end
