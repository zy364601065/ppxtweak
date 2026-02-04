//
//  QTSettingsViewModel.h
//  Cherish
//
//  Created by zy on 2023/4/11.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface QTSettingsViewModel : NSObject

@property (nonatomic, strong) NSMutableArray *settingsModelArray;
- (void)showRateModel:(BOOL)isShow;

@end

NS_ASSUME_NONNULL_END