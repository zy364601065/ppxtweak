//
//  QTSettingsViewModel.m
//  Cherish
//
//  Created by zy on 2023/4/11.
//

#import "QTSettingsViewModel.h"
#import "QTPPXHeader.h"

@implementation QTSettingsViewModel

- (instancetype)init {
    self = [super init];
    if (self) {
        [self addArray];
    }
    return self;
}

- (void)addArray {
    
    BDSSettingsCellStyleModel *coinModel = [[objc_getClass("BDSSettingsCellStyleModel") alloc] init];
    coinModel.title = @"我的-隐藏金币板块";
    coinModel.switchOn = YES;
    coinModel.modelType = 1;

    BDSSettingsCellStyleModel *carouselModel = [[objc_getClass("BDSSettingsCellStyleModel") alloc] init];
    carouselModel.title = @"我的-隐藏轮播";
    carouselModel.switchOn = YES;
    carouselModel.modelType = 2;

    BDSSettingsCellStyleModel *authorModel = [[objc_getClass("BDSSettingsCellStyleModel") alloc] init];
    authorModel.title = @"作者";
    authorModel.subTitle = @"有问题可以反馈";
    authorModel.modelType = 3;

    self.settingsModelArray = @[coinModel, carouselModel, authorModel];
}

@end
