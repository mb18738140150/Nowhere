//
//  LeftSideViewController.m
//  A_1990
//
//  Created by lanouhn on 15/6/25.
//  Copyright (c) 2015年 1990. All rights reserved.
//

#import "LeftSideViewController.h"
#import "ListViewController.h"
#import "MainViewController.h"
#import "CollectViewController.h"
#import "CenterViewController.h"



@interface LeftSideViewController ()<UIAlertViewDelegate>

@property (nonatomic , assign) int listId;
@property (nonatomic , assign) BOOL isLogin;

@property (nonatomic , assign) CGFloat totalCount; //记录点击总次数
@property (nonatomic , assign) CGFloat count1;
@property (nonatomic , assign) CGFloat count2;
@property (nonatomic , assign) CGFloat count3;
@property (nonatomic , assign) CGFloat count4;
@property (nonatomic , assign) CGFloat count5;
@property (nonatomic , assign) CGFloat value1;
@property (nonatomic , assign) CGFloat value2;
@property (nonatomic , assign) CGFloat value3;
@property (nonatomic , assign) CGFloat value4;
@property (nonatomic , assign) CGFloat value5;

@property (nonatomic , retain) NSArray *listArr; //分类列表

@end

@implementation LeftSideViewController

- (void)loadView
{
    [super loadView];
    self.leftSideView = [[LeftSideView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.view = self.leftSideView;
    [self.leftSideView release];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _totalCount = 1;
    

#pragma mark - 读取NSUserDefaulter数据  保存用户信息
    NSUserDefaults *account = [NSUserDefaults standardUserDefaults];
    NSDictionary *accountDic = [account valueForKey:@"account"];
    NSLog(@"%@" , accountDic);
    if ([[accountDic objectForKey:@"isLogin"] isEqualToString:@"YES"]) {
        NSLog(@"%@" , [accountDic objectForKey:@"iconURL"]);
        self.leftSideView.headImageView.imageURL = [NSURL URLWithString:[accountDic objectForKey:@"iconURL"]];
        
        AppDelegate *appDelegate = [UIApplication sharedApplication].delegate ;
        appDelegate.uid = [accountDic objectForKey:@"usid"];
    }

    //添加轻拍登录
    UITapGestureRecognizer *tapLogin = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(loginBtnAction:)];
    [self.leftSideView.spiderView addGestureRecognizer:tapLogin];
    [tapLogin release];
    
    
    
    // 给Button添加点击事件
    [self.leftSideView.centerButton addTarget:self action:@selector(centerButtonAction:) forControlEvents:UIControlEventTouchUpInside];
//    [self.leftSideView.loginBtn addTarget:self action:@selector(loginBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.leftSideView.firstPageButton addTarget:self action:@selector(firstPageButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.leftSideView.collectButton addTarget:self action:@selector(collectButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.leftSideView.commerceButton addTarget:self action:@selector(listButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.leftSideView.intelligentButton addTarget:self action:@selector(listButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.leftSideView.desginButton addTarget:self action:@selector(listButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.leftSideView.fashionButton addTarget:self action:@selector(listButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.leftSideView.entertainButton addTarget:self action:@selector(listButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.leftSideView.cityButton addTarget:self action:@selector(listButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.leftSideView.gameButton addTarget:self action:@selector(listButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.leftSideView.mvButton addTarget:self action:@selector(mvButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.leftSideView.setButton addTarget:self action:@selector(setButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.leftSideView.searchButton addTarget:self action:@selector(searchButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeAction:)];
    swipe.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:swipe];
    [swipe release];
    
}

#pragma mark - 轻扫手势,收回菜单栏
-(void)swipeAction:(UISwipeGestureRecognizer *)sender
{
    [self.sideMenuViewController closeMenuAnimated:YES completion:nil];
}

-(NSArray *)listArr
{
    if (!_listArr) {
        self.listArr = [NSArray array];
    }
    return _listArr;
}

#pragma mark - 友盟第三方登录
-(void)loginBtnAction:(UITapGestureRecognizer *)sender
{
    NSLog(@"tap");
    
    if (self.leftSideView.headImageView.imageURL == nil) {
        UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToSina];
        
        snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
            
            //获取微博用户名、uid、token等
            
            if (response.responseCode == UMSResponseCodeSuccess) {
                
                UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:UMShareToSina];
                
                NSLog(@" ************ username is %@, uid is %@, token is %@ url is %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL);
                
                self.leftSideView.headImageView.imageURL = [NSURL URLWithString:snsAccount.iconURL];
                
                AppDelegate *appDelegate = [UIApplication sharedApplication].delegate ;
                appDelegate.uid = snsAccount.usid;
                
#pragma mark -- NSUserDefaulter保存用户名和密码
                NSUserDefaults *account = [NSUserDefaults standardUserDefaults];
                NSDictionary *dic = @{@"usid":snsAccount.usid , @"userName":snsAccount.userName , @"iconURL":snsAccount.iconURL , @"accessToken":snsAccount.accessToken , @"isLogin":@"YES"};
                
                [account setObject:dic forKey:@"account"];
                //同步到磁盘中
                [account synchronize];
  
            }});
        
        //获取accestoken以及新浪用户信息，得到的数据在回调Block对象形参respone的data属性
        [[UMSocialDataService defaultDataService] requestSnsInformation:UMShareToSina  completion:^(UMSocialResponseEntity *response){
            //NSLog(@"SnsInformation is %@",response.data);
            
            NSLog(@"授权成功");
            
        }];
        
        [[UMSocialDataService defaultDataService] requestSnsFriends:UMShareToSina  completion:^(UMSocialResponseEntity *response){
            //NSLog(@"SnsFriends is %@",response.data);
            NSLog(@"获得好友信息");
        }];
    }else {


        
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"是否要注销登录?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alertView show];
        
//        NSDictionary *dic = [[NSUserDefaults standardUserDefaults] valueForKey:@"account"];
//        [dic setValue:@"NO" forKey: @"isLogin"];
//        NSLog(@"%@" , dic);
//        self.leftSideView.headImageView.imageURL = nil;
//        //同步磁盘
//        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}


#pragma mark - alertView Delegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        NSDictionary *dic = [[NSUserDefaults standardUserDefaults] valueForKey:@"account"];
        [dic setValue:@"NO" forKey: @"isLogin"];
        NSLog(@"%@" , dic);
        self.leftSideView.headImageView.imageURL = nil;
        //同步磁盘
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

#pragma mark - 个人中心
-(void)centerButtonAction:(UIButton *)sender
{
    CenterViewController *centerVC = [[CenterViewController alloc]init];
    MainViewController *mainVC = [[MainViewController alloc]init];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:mainVC];
    [self.sideMenuViewController setMainViewController:nav animated:YES closeMenu:YES];
    
    [nav pushViewController:centerVC animated:YES];
    [centerVC release];
    [mainVC release];
    [nav release];
}


#pragma mark - 跳转 随机分类
- (void)firstPageButtonAction:(UIButton *)sender
{
    NSLog(@"firstPage");
    
    MainViewController *mainVC = [[MainViewController alloc]init];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:mainVC];
    [self.sideMenuViewController setMainViewController:nav animated:YES closeMenu:YES];
    
#pragma mark - 随机传listID
    _listArr = @[@18 , @17 , @3 , @4 , @19 , @5 , @54 , @11 , @71];
    int index = arc4random() % 9;
    NSLog(@"%d" , index);
    
    if ([_listArr[index] longValue] != 71) {
        ListViewController *listVC = [[ListViewController alloc] init];
        listVC.listID = [_listArr[index] longValue];
        NSLog(@"%ld" , listVC.listID);
        [nav pushViewController:listVC animated:YES];
        [listVC release];
    }else {
        MTVTableViewController *mtvVC = [[MTVTableViewController alloc]init];
        [nav pushViewController:mtvVC animated:YES];
        [mtvVC release];
    }
   
//    self.leftSideView.hidden = YES;
    [mainVC release];
    [nav release];
    
}

#pragma mark - 收藏界面
- (void)collectButtonAction:(UIButton *)sender
{
    NSLog(@"collect");
    CollectViewController *myVC = [[CollectViewController alloc] init];
    MainViewController *mainVC = [[MainViewController alloc]init];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:mainVC];
    [self.sideMenuViewController setMainViewController:nav animated:YES closeMenu:YES];
    [nav pushViewController:myVC animated:YES];
    
    [myVC release];
    [mainVC release];
    [nav release];
    
}

#pragma mark - 跳转MV界面
-(void)mvButtonAction:(UIButton *)sender
{
    NSLog(@"click");
    _totalCount++;
    [self calculate:(long)sender.tag];
    
    MTVTableViewController *mtvVC = [[MTVTableViewController alloc]init];
    MainViewController *mainVC = [[MainViewController alloc]init];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:mainVC];
    [self.sideMenuViewController setMainViewController:nav animated:YES closeMenu:YES];
    
    [nav pushViewController:mtvVC animated:YES];
    self.leftSideView.hidden = YES;
    
    [mtvVC release];
    [mainVC release];
    [nav release];
    
    
}

#pragma mark - 侧边栏(导航)
- (void)listButtonAction:(UIButton *)sender
{
    NSLog(@"click");
    _totalCount++;
    [self calculate:(long)sender.tag];
    
    ListViewController *listVC = [[ListViewController alloc] init];
    MainViewController *mainVC = [[MainViewController alloc]init];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:mainVC];
    
    [self.sideMenuViewController setMainViewController:nav animated:YES closeMenu:YES];
    listVC.listID = sender.tag - 100;
    [nav pushViewController:listVC animated:YES];
    self.leftSideView.hidden = YES;
    [listVC release];
    [mainVC release];
    [nav release];

}

-(void)calculate:(long)index
{
#pragma mark - 五芒星计算  每个角的图片
    switch (index) {
        case kBusiness:
            _count1+=0.01;
            break;
        case kIntelligent:
            _count2+=0.01;
            break;
        case kDesign:
            _count3+=0.01;
            break;
        case kFashion:
            _count4+=0.01;
            break;
        case kCity:
            _count5+=0.01;
            break;
        default:
            break;
    }
    
    _value1 = _count1 / _totalCount + 0.5;
    _value2 = _count2 / _totalCount + 0.5;
    _value3 = _count3 / _totalCount + 0.5;
    _value4 = _count4 / _totalCount + 0.5;
    _value5 = _count5 / _totalCount + 0.5;
    
     NSDictionary *valueDic = @{@"shangye":@(_value1).stringValue, @"zhineng":@(_value2).stringValue , @"sheji":@(_value3).stringValue , @"shishang":@(_value4).stringValue , @"yule":@(_value5).stringValue};
    
    [self.leftSideView.spiderView animateWithDuration:.3 valueDictionary:valueDic];
}

- (void)setButtonAction:(UIButton *)sender
{
    NSLog(@"set");
    SetViewController *setVC = [[SetViewController alloc]init];
    MainViewController *mainVC = [[MainViewController alloc]init];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:mainVC];
    [self.sideMenuViewController setMainViewController:nav animated:YES closeMenu:YES];
    [nav pushViewController:setVC animated:YES];
    
    [setVC release];
    [mainVC release];
    [nav release];

}

- (void)searchButtonAction:(UIButton *)sender
{
    NSLog(@"search");
    SearchViewController *searchVC = [[SearchViewController alloc]init];
    MainViewController *mainVC = [[MainViewController alloc]init];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:mainVC];
    [self.sideMenuViewController setMainViewController:nav animated:YES closeMenu:YES];
    [nav pushViewController:searchVC animated:YES];
    
    [searchVC release];
    [mainVC release];
    [nav release];
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)dealloc
{
    [self.leftSideView release];
    [_listArr release];
    [super dealloc];
}


@end
