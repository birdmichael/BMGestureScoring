//
//  BMPostScoreView.m
//  BMGestureScoring
//
//  Created by BM on 15/11/4.
//  Copyright © 2015年 BM. All rights reserved.
//

#import "BMPostScoreView.h"
#import "BMPieChartView.h"



#define PI 3.14

@interface BMPostScoreView()

@property (nonatomic ,assign) float lastValue;

@end
@implementation BMPostScoreView
{
    BMPieChartView *pieview;
}
- (void)initTurntableViewwithProgressColor:(UIColor *)color
{
    //    float width = 100;//打分响应区的宽度
    self.frame = CGRectMake(0, 0, 144, 144); // 144?
    
    self.progressView = [[PICircularProgressView alloc]initWithFrame:CGRectMake(0, 0, 144, 144)]; // 144?
    self.progressView.center = self.center;
    [self addSubview:self.progressView];
    self.progressView.thicknessRatio = 0.4;
    self.progressView.roundedHead = 0;
    self.progressView.showShadow = 0;
    self.progressView.progressFillColor  = color;
    self.progressView.progress = 0/100;
    
    //打分拨针功能区
    [self addDrawPieView];
    
}

- (void)addDrawPieView
{
    if (pieview && [pieview superview] ) {
        [pieview removeFromSuperview];
    }
    //打分功能扫行区
    pieview = [[BMPieChartView alloc] initWithFrame:CGRectMake(0, 0, 144,144) startRad:-M_PI  endRad:M_PI]; // ?
    pieview.isStopTransform = YES;
    [self addSubview:pieview];
    pieview.pinDelegate = self;
    [pieview setPinValue:0]; //?
    [pieview.chart setPinImage:@"scoring_bei"];
    
}

#pragma mark - PieChartDelegate

- (void)Pie:(BMPieChartView *)pie TouchProcessingWithValue:(float)value andNewTransform:(CGAffineTransform)newTrans
{
    if (value == _lastValue) {
        [self drawPie:pie WithValue:value andTransform:newTrans];
    }
    
    if ((value < 40)&(_lastValue >60)) { // 左回退 满分
        [self drawPie:pie WithValue:100 andTransform:CGAffineTransformIdentity];
        _lastValue = 100;
        return;
    }
    
    if ((value > 60) & (_lastValue < 40 )) { // 右越界 清零
        [self drawPie:pie WithValue:0 andTransform:CGAffineTransformIdentity];
        _lastValue = 0;
        return;
    }
    
    if ((_lastValue == 100) & (value > 70)) {
        [self drawPie:pie WithValue:value andTransform:newTrans];
    }
    
    [self drawPie:pie WithValue:value andTransform:newTrans];
    _lastValue = value;
}

#pragma Private
- (void)drawPie:(BMPieChartView *)pie WithValue:(float)value andTransform:(CGAffineTransform)transform
{
    self.progressView.progress = value/100;
    _changeProgressValue(value/100);
    self.index = value/100;
    pie.container.transform = transform;
}

@end
