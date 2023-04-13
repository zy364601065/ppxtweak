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
    
    BDSUserHomeCellStyleModel *model = [[objc_getClass("BDSUserHomeCellStyleModel") alloc] init];
    model.title = @"插件设置";
    self.settingsModelArray = @[model];
}

@end
