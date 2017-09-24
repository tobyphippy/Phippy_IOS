//
//  FoodDetailViewController.m
//  Phippy
//
//  Created by toby on 12/07/2017.
//  Copyright © 2017 kg.self.edu. All rights reserved.
//

#import "FoodDetailViewController.h"
#import "PhippyHeaderView.h"
#import "FoodDetailCollectionCell.h"
#import "OrderViewController.h"


#import "PHIRequest.h"
@interface FoodDetailViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UIActionSheetDelegate>{
    
}

@property (nonatomic,strong) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) NSArray *dataArray;
@property (nonatomic,strong) NSMutableArray *checkedArray;
@property (nonatomic,strong) UIButton *navRightBtn;

@end

@implementation FoodDetailViewController


#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.phippyNavigationController addBackButton];
    [self.phippyNavigationController addRightButtonWithButton:self.navRightBtn];
    
    [self.view addSubview:self.collectionView];
    
    [PHIRequest goodsWithParameters:@{@"store_id":self.store_id} success:^(NSURLSessionDataTask *task, id responseObject) {
        self.dataArray = responseObject[@"data"];
        
        if(self.dataArray.count != 0){
        
            [self.collectionView reloadData];
        }else{
            NSLog(@"暂无菜单");
        }
       
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
   
}

#pragma mark - 内部方法


/**
 检查是否已经有选择的餐品
控制 右上角 提交订单按钮 是否可以点击
 @return bool
 */
- (BOOL)isHaveCheckFood{
    BOOL flog = NO;
    for(int i=0;i<self.checkedArray.count;i++){
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        NSMutableDictionary *checkDict = self.checkedArray[i];
        NSNumber *number = checkDict[indexPath];
        if([number boolValue]){
            return YES;
        }
    }
    
    return flog;
}

#pragma mark - button action

//提交菜单按钮
- (void)contactMerchant{

    if(self.dataArray.count == self.checkedArray.count){
        NSMutableArray *marr = [[NSMutableArray alloc]initWithCapacity:0];
        for(int i=0;i<self.dataArray.count;i++){
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
            NSMutableDictionary *checkDict = self.checkedArray[i];
            NSNumber *number = checkDict[indexPath];
            
            if([number boolValue]){
                NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:self.dataArray[i]];
                [dict setObject:@"1" forKey:@"count"];
                [marr addObject:dict];
            }
        }
    
        OrderViewController *orderController = [[OrderViewController alloc]init];
        orderController.dataArray = @[marr];
        [self.phippyNavigationController pushViewController:orderController animated:YES];
    }else{
        NSLog(@"内部数据错误");
    }
   
    
   
//    NSString *wechat = [NSString stringWithFormat:@"微信:%@",self.wechat];
//    NSString *phoneNumber = [NSString stringWithFormat:@"电话:%@",self.phoneNumber];
//    
//    UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:@"亲！phippy下单系统正在测试中，敬请期待哦，么么哒" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:wechat,phoneNumber, nil];
//    //actionSheet样式
//    sheet.actionSheetStyle = UIActionSheetStyleDefault;
//    //显示
//    [sheet showInView:self.view];
//    sheet.delegate = self;
}



- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        //微信联系
        
        
        //    7-04 更新微信相关：
        //    weixin://dl/scan 扫一扫
        //    weixin://dl/feedback 反馈
        //    weixin://dl/moments 朋友圈
        //    weixin://dl/settings 设置
        //    weixin://dl/notifications 消息通知设置
        //    weixin://dl/chat 聊天设置
        //    weixin://dl/general 通用设置
        //    weixin://dl/officialaccounts 公众号
        //    weixin://dl/games 游戏
        //    weixin://dl/help 帮助
        //    weixin://dl/feedback 反馈
        //    weixin://dl/profile 个人信息
        //    weixin://dl/features 功能插件
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"weixin://dl/chat"] options:@{} completionHandler:nil];
        
    }else if (buttonIndex == 1){
        //电话联系
        NSMutableString* str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",self.phoneNumber];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
        
    }
}

#pragma mark - collectionViewDelegate
//  collectionView段数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}
//  collectionView每段的item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    
    return self.dataArray.count;
}
//  collectionView的item
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *dict = self.dataArray[indexPath.row];
    //  获取自定义的cell
    FoodDetailCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FoodDetailCollectionCell" forIndexPath:indexPath];
    cell.title.text = dict[MSKEY_FOODDETAILS_Name];
    cell.price.text = dict[MSKEY_FOODDETAILS_Price];
    
    return cell;
}

//这个方法是返回 Header的大小 size
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(self.collectionView.frame.size.width, 150);
}

//这个也是最重要的方法 获取Header的 方法。
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *headerView = nil;
    if([kind isEqualToString:UICollectionElementKindSectionHeader]){
        if(indexPath.section == 0){
            headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"MerchantLogoReusableView" forIndexPath:indexPath];
        }
    }
    
    return headerView;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    FoodDetailCollectionCell *cell = (FoodDetailCollectionCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.checkImg.hidden = !cell.checkImg.isHidden;
    
    NSMutableDictionary *mdict = self.checkedArray[indexPath.row];
    [mdict setObject:[NSNumber numberWithBool:!cell.checkImg.isHidden] forKey:indexPath];
    
    
    if([self isHaveCheckFood]) {
        self.navRightBtn.enabled = YES;
        [self.navRightBtn setTitleColor:COLOR(70, 70, 70, 1) forState:UIControlStateNormal];
    }else{
        self.navRightBtn.enabled = NO;
        [self.navRightBtn setTitleColor:COLOR(238, 238, 238, 1) forState:UIControlStateNormal];
    }
}

#pragma mark - set get

- (UIButton *)navRightBtn{
    if(!_navRightBtn){
        _navRightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _navRightBtn.frame = CGRectMake(0, 3, 65, 44);
        _navRightBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        
        [_navRightBtn setTitle:@"提交订单" forState:UIControlStateNormal];
        [_navRightBtn addTarget:self action:@selector(contactMerchant) forControlEvents:UIControlEventTouchUpInside];
        
        self.navRightBtn.enabled = NO;
        [self.navRightBtn setTitleColor:COLOR(238, 238, 238, 1) forState:UIControlStateNormal];
    }
    return _navRightBtn;
}

- (NSMutableArray *)checkedArray{
    if(!_checkedArray){
        _checkedArray = [[NSMutableArray alloc]initWithCapacity:self.dataArray.count];
        for(int i=0;i<self.dataArray.count;i++){
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
            
            NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithCapacity:0];
            [dict setObject:[NSNumber numberWithBool:0] forKey:indexPath];
            [_checkedArray addObject:dict];
        }
    }
    return _checkedArray;
}

- (UICollectionViewFlowLayout *)flowLayout{
    if(!_flowLayout){
        _flowLayout = [UICollectionViewFlowLayout new];
        //  collectionView的item大小
        _flowLayout.itemSize = CGSizeMake((SCREEN_WIDTH-1)/2, 150);
        
        //  collectionView的item行间距
        _flowLayout.minimumLineSpacing = 1;
        
        //  collectionView的item列间距
        _flowLayout.minimumInteritemSpacing = 1;
        
        //  collectionView的sectionHeaderView大小
        //        _flowLayout.headerReferenceSize = CGSizeMake(SCREEN_WIDTH, 41);
    }
    return _flowLayout;
}

- (UICollectionView *)collectionView{
    if(!_collectionView){
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT) collectionViewLayout:self.flowLayout];
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        
        //  注册item
        [_collectionView registerNib:[UINib nibWithNibName:@"FoodDetailCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"FoodDetailCollectionCell"];
        //  注册sectionHeaderView
        //    [collectionView registerClass:[XSectionHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerview"];
        
        //注册商家headerview
        [_collectionView registerNib:[UINib nibWithNibName:@"MerchantLogoReusableView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"MerchantLogoReusableView"];
        
    }
    return _collectionView;
}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
