//
//  ViewController.m
//  BMGestureScoring
//
//  Created by BM on 15/11/4.
//  Copyright © 2015年 BM. All rights reserved.
//

#import "ViewController.h"
#import "BMPostScoreView.h"

#define ColorRGB(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];

}

- (void)setUI
{
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake((self.view.frame.size.width-227)/2, 77, 227, 182)];
    imageView.image = [UIImage imageNamed:@"scoring_bg.jpg"];
    imageView.userInteractionEnabled =YES;
    [self.view addSubview:imageView];
    
    UIImageView *annulusView = [[UIImageView alloc]initWithFrame:CGRectMake((imageView.frame.size.width-158)/2, 7, 158, 158)];
    annulusView.image = [UIImage imageNamed:@"scoring_pan"];
    annulusView.userInteractionEnabled =YES;
    [imageView addSubview:annulusView];
    
    UIImageView *reminderView =[[UIImageView alloc]initWithFrame:CGRectMake(100, 47, 150, 80)];
    reminderView.backgroundColor =[UIColor clearColor];
    [reminderView setImage:[UIImage imageNamed:@"scoring_tips"]];
    [self.view addSubview:reminderView];
    
    BMPostScoreView *turntableView = [[BMPostScoreView alloc] init];
    [turntableView initTurntableViewwithProgressColor:ColorRGB(103, 180, 38)];
    turntableView.center = CGPointMake(158/2, 158/2);
    [annulusView addSubview:turntableView];
    
    //显示数字
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(turntableView.frame.size.width/2-40, turntableView.frame.size.height/2-40, 80, 80)];
    view.layer.cornerRadius =40;
    view.backgroundColor =[UIColor colorWithRed:242/255.0 green:250/255.0 blue:237/255.0 alpha:1];
    [turntableView addSubview:view];
    
    UILabel *labelNumber = [[UILabel alloc]initWithFrame:CGRectMake(10,10, 60, 60)];
    labelNumber.backgroundColor = [UIColor clearColor];
    labelNumber.font = [UIFont systemFontOfSize:31.0f];
    labelNumber.textAlignment = NSTextAlignmentCenter;
    labelNumber.textColor = [UIColor colorWithRed:103/255.0 green:180/255.0 blue:38/255.0 alpha:1.0];
    labelNumber.text = [NSString stringWithFormat:@"%d",self.value];
    [view addSubview:labelNumber];
    
    UILabel *markTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(65,40, 12, 12)];
    markTitleLabel.backgroundColor = [UIColor clearColor];
    markTitleLabel.textAlignment = NSTextAlignmentCenter;
    markTitleLabel.textColor = [UIColor colorWithRed:103/255.0 green:180/255.0 blue:38/255.0 alpha:1.0];
    markTitleLabel.text = @"分";
    markTitleLabel.font = [UIFont systemFontOfSize:10.5];
    [view addSubview:markTitleLabel];
    
    __weak ViewController *vc = self;
    __weak UILabel *label = labelNumber;
    
    turntableView.changeProgressValue = ^(float value){
        vc.value = value*100;
        label.text = [NSString stringWithFormat:@"%d",vc.value];
        
        // 关闭提示
        if (vc.value >0 && vc.value <30) {
            [UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                reminderView.layer.opacity = 0;
            } completion:^(BOOL finished) {
            }];
        };
        
    };


    


}


@end
