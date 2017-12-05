//
//  ViewController.m
//  pan
//
//  Created by 于海涛 on 2017/11/28.
//  Copyright © 2017年 KennyHito. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView * tableView;
@property (nonatomic,strong) NSMutableArray * dataArr;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.title = @"首页";
    
    NSLog(@"状态栏的高度:%.f,安全区域的高度:%d,底部高度:%d",HitoStatusHeight,HitoSafeAreaHeight,HitoBottomHeight);

    self.tableView = [[UITableView alloc]init];
    [self.tableView registerNib:[UINib nibWithNibName:@"viewTableViewCell" bundle:nil] forCellReuseIdentifier:@"CellID"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    
    //为了适配横竖屏
    float padding1 = HitoSafeAreaHeight;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view);
        make.left.mas_equalTo(self.view);
        make.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view).offset(-padding1);
    }];

    [self addDropUpRefresh];
    [self addDropDownRefresh];
    
    [self HttpRequest];
}

#pragma mark --下拉刷新
- (void)addDropDownRefresh{
    MJRefreshNormalHeader * header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //下拉刷新
        [self.tableView. mj_header endRefreshing];
    }];
    [header setTitle:@"正在刷新" forState:MJRefreshStateRefreshing];
    [header setTitle:@"松开刷新" forState:MJRefreshStatePulling];
    self.tableView. mj_header = header;
}

#pragma mark -- 上拉加载
- (void)addDropUpRefresh{
    MJRefreshBackNormalFooter * footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        //加载更多方法调用
        [self.tableView. mj_footer endRefreshing];
    }];
    [footer setTitle:@"正在加载" forState:MJRefreshStateRefreshing ];
    [footer setTitle:@"松开加载" forState:MJRefreshStatePulling];
    self.tableView. mj_footer = footer;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    viewTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CellID"];
    if (!cell) {
        cell = [[viewTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CellID"];
    }
    cell.selectionStyle = 0;
    if (self.dataArr.count>0) {
        [cell sendMessage:self.dataArr[0]];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    firstViewController * v1 = [[firstViewController alloc]init];
    v1.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:v1 animated:YES];
}

- (void)HttpRequest{
    AFHTTPSessionManager * manager = [[AFHTTPSessionManager alloc]init];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json",@"text/javascript", nil];
    [manager POST:[NSString stringWithFormat:@"%@%@",Base_Url,@"Mycenter/center"] parameters:@{@"uid":@"6601"} progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@",dic);
        viewModel * model = [[viewModel alloc]init];
        [model setValuesForKeysWithDictionary:dic];
        [self.dataArr addObject:model];
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error---%@",error.localizedDescription);
    }];
}

-(NSArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [[NSMutableArray alloc]init];
    }
    return _dataArr;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
