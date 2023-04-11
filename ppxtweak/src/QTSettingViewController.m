//
//  QTSettingViewController.m
//  Cherish
//
//  Created by zy on 2023/4/11.
//

#import "QTSettingViewController.h"
#import "QTSettingsViewModel.h"
#import "BDSUserBaseCell.h"

#define kBDSUserBaseCell @"BDSUserBaseCell"
@interface QTSettingViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) QTSettingsViewModel *viewModel;

@end

@implementation QTSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"插件设置";
    [self.view addSubview:self.tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.settingsModelArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BDSUserCellStyleModel *model = self.viewModel.settingsModelArray.count[indexPath.row];
    BDSUserBaseCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(CEReportDynamicCell.class) forIndexPath:indexPath];
    [cell configCellWithModel:model];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.0;
}

#pragma mark -- set
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[BDSUserBaseCell class] forCellReuseIdentifier:kBDSUserBaseCell];
    }
    return _tableView;
}

- (QTSettingsViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[QTSettingsViewModel alloc] init];
    }
    return _viewModel;
}

@end
