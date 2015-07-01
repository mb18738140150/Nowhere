//
//  ShowViewController.m
//  A_1990
//
//  Created by lanouhn on 15/6/25.
//  Copyright (c) 2015年 1990. All rights reserved.
//
#define kListCellID @"ListCellID"
#import "ListViewController.h"
#import "ListCell.h"
@interface ListViewController ()<NetworkEngineDelegate>

@end

@implementation ListViewController : UIViewController

- (void)loadView
{
    [super loadView];
    self.listView = [[ListView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.view = self.listView;
    [self.listView release];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIButton *btn1 = (UIButton *)[self.navigationController.view viewWithTag:101];
    btn1.hidden = YES;
    
    
    self.listView.myCollectionView.delegate = self;
    self.listView.myCollectionView.dataSource = self;
    // 注册item
    [self.listView.myCollectionView registerClass:[ListCell class] forCellWithReuseIdentifier:kListCellID];
   
    // 请求数据
    [self getDataFromUrl];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
   
    
}

- (void)getDataFromUrl
{
    NetworkEngine *engine = [NetworkEngine networkEngineWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://app.qdaily.com/app/categories/index/18/0.json?"]] params:nil delegate:self];
    [engine start];
}

#pragma mark - 请求数据成功的dailifangfa

-(void)networkDidFinishLoading:(NetworkEngine *)engine withInfo:(NSData *)data
{
    // 初始化存放model的数组
    self.listModelArray = [NSMutableArray array];
    
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSArray *array = [[[dic objectForKey:@"response"] objectForKey:@"feeds"] objectForKey:@"list"];
    
    for (int i = 0; i < array.count; i++) {
        NSDictionary *dic = [array objectAtIndex:i];
        ListModel *model = [[ListModel alloc] init];
        model.title = [[dic objectForKey:@"post"] objectForKey:@"title"];
        model.bigImageName = [dic objectForKey:@"image"];
        
        
        [self.listModelArray addObject:model];
        
        
    }
    [self.listView.myCollectionView reloadData];
    
}


#pragma mark - collectionView 代理方法

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return self.listModelArray.count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kListCellID forIndexPath:indexPath];
    ListModel *model = [self.listModelArray objectAtIndex:indexPath.row];
    cell.titleLabel.text = model.title;
    cell.photoImageView.imageURL = [NSURL URLWithString:model.bigImageName];
    
    return cell;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)dealloc
{
    [_bigImageViewArray release];
    [_listModelArray release];
    [_listView release];
    [super dealloc];
}
@end
