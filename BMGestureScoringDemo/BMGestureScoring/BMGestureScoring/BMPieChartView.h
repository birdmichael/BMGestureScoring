//
//  BMPieChartView.h
//  BMGestureScoring
//
//  Created by BM on 15/11/4.
//  Copyright © 2015年 BM. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "BMClove.h"

@interface BMPieChart : UIView {
    
@private
    
    CGFloat centerX;
    CGFloat centerY;
    CGFloat radius;
    
    int fontSize;
}

@property (nonatomic,strong) NSString *pinImage;
@property (nonatomic,strong) UIColor *color;

@property int value;



@end

@class BMPieChartView;
@protocol PieChartDelegate <NSObject>
@optional
-(void)Pie:(BMPieChartView *)pie TouchProcessingWithValue:(float)value andNewTransform:(CGAffineTransform)newTrans;
@end

@interface BMPieChartView : UIView

@property (nonatomic, strong) UIView *container;
@property (nonatomic, strong) BMClove *clove;
@property CGAffineTransform startTransform;
@property CGAffineTransform zeroTransform;
@property CGPoint wheelCenter;

//  是否停止指针自动偏移
@property (nonatomic ,assign) BOOL isStopTransform;

@property float startRad;//开始弧度
@property float endRad;//结束弧度
@property (nonatomic, strong) id<PieChartDelegate> pinDelegate;
@property (nonatomic, strong) BMPieChart* chart;

- (void) setPinValue:(float)value;//设置指针位置
- (id) initWithFrame:(CGRect)frame startRad:(float)startRad endRad:(float)endRad;
- (void) initWheel;
- (void) buildClovesOdd;
@end
