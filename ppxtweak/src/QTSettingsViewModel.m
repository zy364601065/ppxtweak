//
//  QTSettingsViewModel.m
//  Cherish
//
//  Created by zy on 2023/4/11.
//

#import "QTSettingsViewModel.h"
#import "QTPPXHeader.h"

@interface QTSettingsViewModel ()

@property (nonatomic, strong) BDSSettingsCellStyleModel *rateModel;

@end

@implementation QTSettingsViewModel

- (instancetype)init {
    self = [super init];
    if (self) {
        [self addArray];
    }
    return self;
}

- (NSMutableArray *)settingsModelArray {
    
    if (!_settingsModelArray) {
        _settingsModelArray = [NSMutableArray array];
    }
    return _settingsModelArray;
}

- (BDSSettingsCellStyleModel *)rateModel {
    
    if (!_rateModel) {
        _rateModel = [[objc_getClass("BDSSettingsCellStyleModel") alloc] init];
        _rateModel.title = @"当前速率";
        _rateModel.subTitle = @"1.0";
        _rateModel.modelType = 101;
        _rateModel.cellStyleType = 0;
    }
    return _rateModel;
}

- (void)addArray {
    
    BDSSettingsCellStyleModel *openRateModel = [[objc_getClass("BDSSettingsCellStyleModel") alloc] init];
    openRateModel.title = @"开启视频速率播放";
    openRateModel.modelType = 102;
    openRateModel.cellStyleType = 1;
    openRateModel.actionURL = @"click_open_rate";
    [self.settingsModelArray addObject:openRateModel];
    
    NSString *rate = [[NSUserDefaults standardUserDefaults] objectForKey:kBDSVideoRatePlay];
    if (!rate || [rate isEqualToString:@"1.0"]) {
        openRateModel.switchOn = NO;
    } else {
        openRateModel.switchOn = YES;
        self.rateModel.subTitle = rate;
        [self.settingsModelArray addObject:self.rateModel];
    }

    BDSSettingsCellStyleModel *authorModel = [[objc_getClass("BDSSettingsCellStyleModel") alloc] init];
    authorModel.title = @"作者";
    authorModel.subTitle = @"问题反馈";
    authorModel.modelType = 103;
    authorModel.cellStyleType = 0;
    authorModel.enableSelected = YES;
    [self.settingsModelArray addObject:authorModel];
}

- (void)showRateModel:(BOOL)isShow {
    
    if (isShow) {
        if (![self.settingsModelArray containsObject:self.rateModel]) {
            [self.settingsModelArray insertObject:self.rateModel atIndex:1];
        }
    } else {
        if ([self.settingsModelArray containsObject:self.rateModel]) {
            [self.settingsModelArray removeObject:self.rateModel];
        }
    }
}

@end
