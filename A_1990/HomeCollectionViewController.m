//
//  HomeViewController.m
//  A_1990
//
//  Created by lanouhn on 15/6/25.
//  Copyright (c) 2015年 1990. All rights reserved.
//

#import "HomeCollectionViewController.h"
#import "DetailsViewController.h"




@interface HomeCollectionViewController ()<NetworkEngineDelegate>

@property (nonatomic , retain) NSString *lastTime;
@property (nonatomic , retain) NSMutableArray *homeModels; //存放model
@property (nonatomic , retain) NSMutableArray *banners; //存放轮播图model

@end

@implementation HomeCollectionViewController

-(instancetype)initWithFrame:(CGRect)frame
{
    //创建collectionView布局
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    CGFloat viewWidth = CGRectGetWidth(frame);
//    CGFloat viewHeight = CGRectGetHeight(self.view.frame);
    CGFloat itemWidth = (viewWidth - kMinimumInteritemSpacing) / 2;
    CGFloat itemHeight = itemWidth * kImageHeight / kImageWidth;
    //设置item大小
    layout.itemSize = CGSizeMake(itemWidth , itemHeight + kTitleLabelHeight);
    //item之间最小间距
    layout.minimumInteritemSpacing = kMinimumInteritemSpacing;
    //item行之间最小间距
    layout.minimumLineSpacing = kMinimumLineSpacing;
    
    return [self initWithCollectionViewLayout:layout];
}

-(void)viewDidAppear:(BOOL)animated
{
    self.view.frame = CGRectMake(0 , kTopBtnHeight , self.view.frame.size.width, self.view.frame.size.height - kTopBtnHeight);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.view.backgroundColor = [UIColor yellowColor];
    
//    self.view.frame = CGRectMake(0 , 60 , self.view.frame.size.width, self.view.frame.size.height);
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    NSLog(@"***************%f", self.collectionView.frame.origin.y);
    self.lastTime = @"0";
    
    //请求数据
    [self getDataFromUrl];
    
    
    //注册item
    [self.collectionView registerClass:[HomeCell class] forCellWithReuseIdentifier:kHomeCellID];
    
}

#pragma mark - UICollectionView Delegate
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
#warning 此处暂时写为1个分区(计划 轮播图 , 集合视图 两个section)
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.homeModels count];
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HomeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kHomeCellID forIndexPath:indexPath];
    
#warning 显示cell时 待优化 ("这个设计了不起" 板块需要 剔除 ; cell 需要双数显示)
    PostModel *model = [self.homeModels objectAtIndex:indexPath.row];
    cell.homeImage.imageURL = [NSURL URLWithString:model.imageViewURL];
    cell.titleLabel.text = model.title;
    return cell;
    
}

#pragma mark - 跳转详情界面
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    DetailsViewController *detailVC = [[DetailsViewController alloc]init];
    PostModel *model = [self.homeModels objectAtIndex:indexPath.row];
    detailVC.webHtml = model.appview;
    [self presentViewController:detailVC animated:YES completion:nil];
}


#pragma mark - homeModels数组懒加载
-(NSMutableArray *)homeModels
{
    if (!_homeModels) {
        self.homeModels = [NSMutableArray array];
    }
    return _homeModels;
}

#pragma mark - 请求数据
-(void)getDataFromUrl
{
    //网络请求
    NSString *url = [NSString stringWithFormat:@"http://app.qdaily.com/app/homes/index/%@.json?" , self.lastTime];
    NetworkEngine *engine = [NetworkEngine networkEngineWithURL:[NSURL URLWithString:url] params:nil delegate:self];
    //启动网络请求
    [engine start];
    
    //结束刷新
    [self.collectionView.footer endRefreshing];
}

#pragma mark - 数据请求成功后,解析数据,封装model
-(void)networkDidFinishLoading:(NetworkEngine *)engine withInfo:(NSData *)data
{
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    //获取 collection需要展示的数据数组list(内存放每次得到的n个model)
    NSArray *arr = [[[dic objectForKey:@"response"]objectForKey:@"feeds"]objectForKey:@"list"];
    self.lastTime = [[[dic objectForKey:@"response"]objectForKey:@"feeds"]objectForKey:@"last_time"];
    
    //获取 轮播图 需要展示的数据数组list
    NSArray *views = [[[dic objectForKey:@"response"]objectForKey:@"banners"]objectForKey:@"list"];
    for (int i = 0 ; i < views.count ; i++) {
        NSDictionary *dict = [[views objectAtIndex:i]objectForKey:@"post"];
        PostModel *item = [[PostModel alloc]init];
        NSString *imageUrl = [[views objectAtIndex:i]objectForKey:@"image"];
        item.id90 = dict[@"id"];
        item.title = dict[@"title"];
        item.description90 = dict[@"description"];
        item.appview = dict[@"appview"];
        item.imageViewURL = imageUrl;
        item.category.image_smallURL = [dict[@"category"] objectForKey:@"image_small"];
        [self.banners addObject:item];
        
        [item release];
    }
    
    //上拉刷新列表时,不断获取model,array用于存放刷新后的model
    for (int i = 0 ; i < arr.count ; i++) {
        NSDictionary *dict = [[arr objectAtIndex:i] objectForKey:@"post"];
        PostModel *item = [[PostModel alloc]init];
        NSString *imageUrl = [[arr objectAtIndex:i]objectForKey:@"image"];
        item.id90 = dict[@"id"];
        item.title = dict[@"title"];
        item.description90 = dict[@"description"];
        item.appview = dict[@"appview"];
        item.imageViewURL = imageUrl;
        item.category.image_smallURL = [dict[@"category"] objectForKey:@"image_small"];
        [self.homeModels addObject:item];
        
        [item release];
    }
    
    //上拉刷新
    MyDownLoadGitFooter *footer = [MyDownLoadGitFooter footerWithRefreshingTarget:self refreshingAction:@selector(getDataFromUrl)];
    footer.refreshingTitleHidden = YES;
    self.collectionView.footer = footer;
    
    //拿到数据后刷新collectionView
    [self.collectionView reloadData];
}



-(void)dealloc
{
    _lastTime = nil;
    [_homeModels release];
    [_banners release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
