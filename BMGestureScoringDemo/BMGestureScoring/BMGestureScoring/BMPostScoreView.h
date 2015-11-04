//
//  BMPostScoreView.h
//  BMGestureScoring
//
//  Created by BM on 15/11/4.
//  Copyright © 2015年 BM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMPieChartView.h"
#import "PICircularProgressView.h"
@interface BMPostScoreView : UIView<PieChartDelegate>



@property (strong, nonatomic) PICircularProgressView *progressView;

@property(nonatomic,copy)void(^changeProgressValue)(float); // ??

@property(nonatomic,assign)float index;

- (void)initTurntableViewwithProgressColor:(UIColor *)color;


@end
