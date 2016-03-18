//
//  MainViewController.m
//  Lesson_UI_19
//
//  Created by MouXiangyang on 14/10/15.
//  Copyright (c) 2014年 Duke. All rights reserved.
//

#import "MainViewController.h"
#import "QiushiRequestManager.h"
#import "ItemModel.h"
#import "CollectionImageCell.h"
#import "UIImageView+WebCache.h"
#import "UICollectionViewWaterFlowLayout.h"

#import "ShowViewController.h"



//如果工程时mrc而引入的某些类是arc模式，需要在编译源文件处添加-fobjc-arc标示，相反工程是arc而某些类是mrc模式，则为mrc的类添加-fno-objc-arc标示

@interface MainViewController ()<UICollectionViewDataSource, QiushiRequestManagerDelegate, UICollectionViewDelegateWaterFlowLayout>//视图控制器遵守dataSource协议，为collectionView提供显示数据

@property (nonatomic, retain) UICollectionView *collectionView;//声明集合视图

@property (nonatomic, retain) NSMutableArray *datasource;//用于保存需要展示的数据

@end

@implementation MainViewController

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewWaterFlowLayout *layout = [[UICollectionViewWaterFlowLayout alloc] init];
        layout.delegate = self;
//        layout.minimumLineSpacing = 10;//最小行间距
//        layout.minimumInteritemSpacing = 10;//最小列间距
//        layout.itemSize = CGSizeMake(145, 200);//设置item的大小
        layout.itemWidth = 145;
        layout.sectionInsets = UIEdgeInsetsMake(10, 10, 10, 10);
        
        
        //创建collectionView对象时必须为其指定layout参数，否则会出现crash
        self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        
        //预留位置
        
    }
    return _collectionView;
}

- (NSMutableArray *)datasource{
    if (!_datasource) {
        self.datasource = [NSMutableArray array];
    }
    return _datasource;
}

- (void)dealloc{
    
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)loadView{
    [super loadView];
    [self.view addSubview:self.collectionView];
    self.collectionView.backgroundColor = [UIColor blackColor];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlackTranslucent];
    
    [self.collectionView registerClass:[CollectionImageCell class] forCellWithReuseIdentifier:@"Cell"];
    
    QiushiRequestManager *request = [QiushiRequestManager sharedManager];
    request.destinationURLString = @"http://115.28.227.1/teacher/duke/getAndPostRequest.php?param=imageResource.json";
    request.delegate = self;
    [request startRequest];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.datasource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CollectionImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
//    cell.backgroundColor = [UIColor colorWithRed:arc4random() % 256 / 255.0 green:arc4random() % 256 / 255.0 blue:arc4random() % 256 / 255.0 alpha:1];
    cell.backgroundColor = [UIColor clearColor];
    //从数组中拿到itemModel对象让cell展示图片
    ItemModel *item = [self.datasource objectAtIndex:indexPath.row];
    NSURL *url = [NSURL URLWithString:item.thumbURLstring];
    
    [cell.imageView sd_setImageWithURL:url placeholderImage:[UIImage new]];
    
    return cell;
}

//
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@" indexPat %lu  ", (long)indexPath.row);
    
    NSLog(@" collectionView  %@ ", collectionView );
    NSLog(@" collectionView  %@ ", collectionView.subviews);

    
  //  [self localImageShow:indexPath.row];
    
    ItemModel *item = [self.datasource objectAtIndex:indexPath.row];

    NSString *urlStr = item.thumbURLstring;
    
    ShowViewController *vc = [[ShowViewController alloc] init];
    
    vc.url = [NSURL URLWithString:urlStr];
    
    [self presentViewController:vc animated:NO completion:nil];
     
    
    
}


/*
 *  本地图片展示
 */
/*
-(void)localImageShow:(NSUInteger)index{
    
    __weak typeof(self) weakSelf=self;
    
    [PhotoBroswerVC  show:self type:3 index:index photoModelBlock:^NSArray *{
        
 
       // NSArray *localImages = weakSelf.images;
        
        NSMutableArray *modelsM = [NSMutableArray arrayWithCapacity:localImages.count];
        
        for (NSUInteger i = 0; i< localImages.count; i++) {
            
            PhotoModel *pbModel=[[PhotoModel alloc] init];
            pbModel.mid = i + 1;
            pbModel.title = [NSString stringWithFormat:@"这是标题%@",@(i+1)];
            pbModel.desc = [NSString stringWithFormat:@"我是一段描述文字%@",@(i+1)];
            pbModel.image = localImages[i];
            
            //源frame
          //  UIImageView *imageV = (UIImageView *) weakSelf.contentView.subviews[i];
            pbModel.sourceImageView = imageV;
            
            [modelsM addObject:pbModel];
        }
        
        return modelsM;
 
    }];
}

*/



- (void)request:(QiushiRequestManager *)request didFaildWithError:(NSError *)error{
    NSLog(@"%@", error);
}
- (void)request:(QiushiRequestManager *)request didFinshiLoadingWithData:(NSData *)data{
    NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@ ", jsonArray);
    
    for (NSDictionary *dict in jsonArray) {
        ItemModel *item = [ItemModel itemWithDictionary:dict];
        [self.datasource addObject:item];
    }
    
    
    
    //数据解析完成让集合视图重新加载数据
    [self.collectionView reloadData];
}




#pragma mark - UICollectionViewDelegateWaterFlowLayout

// 固定宽度 返回cell 的高度
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewWaterFlowLayout *)collectionViewLayout heightForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ItemModel *item = [self.datasource objectAtIndex:indexPath.row];
    CGFloat width = 145.0;
    CGFloat height = width * item.imageHeight / item.imageWidth;
    return height;
}


@end
