//
//  QTSettingViewController.m
//  Cherish
//
//  Created by zy on 2023/4/11.
//

#import "QTSettingViewController.h"
#import "QTSettingsViewModel.h"
#import "QTPPXHeader.h"

#define kBDSUserBaseCell @"BDSUserBaseCell"
@interface QTSettingViewController () <UITableViewDelegate, UITableViewDataSource, BDSUserBaseCellDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) QTSettingsViewModel *viewModel;
@property (retain, nonatomic) BDSNavigationBar *navigationBar; 


@end

@implementation QTSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.navigationBar];
    self.navigationBar.title = @"插件设置";
    [self.view addSubview:self.tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.settingsModelArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BDSSettingsCellStyleModel *model = self.viewModel.settingsModelArray[indexPath.row];
    BDSUserBaseCell *cell = [tableView dequeueReusableCellWithIdentifier:kBDSUserBaseCell forIndexPath:indexPath];
    cell.delegate = self;
    [cell configCellWithModel:model];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    BDSSettingsCellStyleModel *model = self.viewModel.settingsModelArray[indexPath.row];
    if (model.modelType == 101) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"选择后所有的视频使用当前速率播放" preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction *slowAction = [UIAlertAction actionWithTitle:@"0.75" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            model.subTitle = @"0.75";
            [[NSUserDefaults standardUserDefaults] setValue:@"0.75" forKey:kBDSVideoRatePlay];
            [[NSUserDefaults standardUserDefaults] synchronize];
            [tableView reloadData];
        }];
        UIAlertAction *normalAction = [UIAlertAction actionWithTitle:@"1.0(正常)" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            model.subTitle = @"1.0";
            [[NSUserDefaults standardUserDefaults] setValue:@"1.0" forKey:kBDSVideoRatePlay];
            [[NSUserDefaults standardUserDefaults] synchronize];
            [tableView reloadData];
        }];
        UIAlertAction *quickAction = [UIAlertAction actionWithTitle:@"1.25" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            model.subTitle = @"1.25";
            [[NSUserDefaults standardUserDefaults] setValue:@"1.25" forKey:kBDSVideoRatePlay];
            [[NSUserDefaults standardUserDefaults] synchronize];
            [tableView reloadData];
        }];
        UIAlertAction *mediumQuickAction = [UIAlertAction actionWithTitle:@"1.5" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            model.subTitle = @"1.5";
            [[NSUserDefaults standardUserDefaults] setValue:@"1.5" forKey:kBDSVideoRatePlay];
            [[NSUserDefaults standardUserDefaults] synchronize];
            [tableView reloadData];
        }];
        UIAlertAction *fastAction = [UIAlertAction actionWithTitle:@"2.0" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            model.subTitle = @"2.0";
            [[NSUserDefaults standardUserDefaults] setValue:@"2.0" forKey:kBDSVideoRatePlay];
            [[NSUserDefaults standardUserDefaults] synchronize];
            [tableView reloadData];
        }];
        [alert addAction:cancel];
        [alert addAction:slowAction];
        [alert addAction:normalAction];
        [alert addAction:quickAction];
        [alert addAction:mediumQuickAction];
        [alert addAction:fastAction];
        [self presentViewController:alert animated:YES completion:nil];
    } else if (model.modelType == 103) {
        NSString *userId = @"2132708183770584"; 
        NSString *customURLString = [NSString stringWithFormat:@"snssdk1128://user/profile/%@", userId];
        NSURL *customURL = [NSURL URLWithString:customURLString];
        if ([[UIApplication sharedApplication] canOpenURL:customURL]) {
            [[UIApplication sharedApplication] openURL:customURL options:@{} completionHandler:nil];
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.0;
}

#pragma mark -- set
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, [UIApplication sharedApplication].statusBarFrame.size.height + 44.0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - ([UIApplication sharedApplication].statusBarFrame.size.height + 44.0)) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[objc_getClass("BDSUserBaseCell") class] forCellReuseIdentifier:kBDSUserBaseCell];
    }
    return _tableView;
}

- (BDSNavigationBar *)navigationBar {
    if (!_navigationBar) {
        _navigationBar = [[objc_getClass("BDSNavigationBar") alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIApplication sharedApplication].statusBarFrame.size.height + 44.0)];
        BDSNavigationBarItem *leftItem = [[objc_getClass("BDSNavigationBarItem") alloc] initWithBarItemStyle:2];
        BDSNavigationBarItem *rightItem = [[objc_getClass("BDSNavigationBarItem") alloc] initWithBarItemStyle:0];
        _navigationBar.leftItem = leftItem;
        _navigationBar.rightItem = rightItem;
    }
    return _navigationBar;
}

- (QTSettingsViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[QTSettingsViewModel alloc] init];
    }
    return _viewModel;
}

- (void)didSwitchChangedWithSwitch:(UISwitch *)arg1 model:(BDSUserCellStyleModel *)arg2 {
    
    if ([arg2.actionURL isEqualToString:@"click_open_rate"]) {
        [self.viewModel showRateModel:arg1.isOn];
        arg2.switchOn = arg1.isOn;
        [self.tableView reloadData];
    }
    
}


@end
