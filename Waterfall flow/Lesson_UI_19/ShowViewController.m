//
//  ShowViewController.m
//  Lesson_UI_19
//
//  Created by admin on 16/3/15.
//  Copyright © 2016年 Duke. All rights reserved.
//

#import "ShowViewController.h"
#import "UIImageView+WebCache.h"


@interface ShowViewController ()

@end

@implementation ShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *imagev = [[UIImageView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:imagev];
    [imagev sd_setImageWithURL:_url placeholderImage:nil];
    
    //向左轻扫手势
    UISwipeGestureRecognizer *recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                                                                    action:@selector(handleSwipe)];
    recognizer.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:recognizer];
  //  [recognizer requireGestureRecognizerToFail:_customGestureRecognizer]; //设置以自定义挠痒手势优先识别
    
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)handleSwipe
{
    [self dismissViewControllerAnimated:NO completion:nil];

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self dismissViewControllerAnimated:NO completion:nil];
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
