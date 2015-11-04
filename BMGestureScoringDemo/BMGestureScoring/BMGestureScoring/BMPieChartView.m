//
//  BMPieChartView.m
//  BMGestureScoring
//
//  Created by BM on 15/11/4.
//  Copyright © 2015年 BM. All rights reserved.
//

#import "BMPieChartView.h"
#import <QuartzCore/QuartzCore.h>

#pragma mark PieChart


#define kRadiusPortion 1.44


// Declare private methods.
@interface BMPieChart ()
- (void)initInstance;
- (void)drawSlice;
@end



@implementation BMPieChart
{
    UIImageView *shadowView;
    UIImageView *pin ;
}


- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initInstance];
        self.frame = frame;
        
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self initInstance];
    }
    return self;
}



- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    
    fontSize = frame.size.width / 20;
    if (fontSize < 9) fontSize = 9;
    
    // Compute the center & radius of the circle.
    centerX = frame.size.width/2 ;
    centerY = frame.size.height/2;
    radius = centerX < centerY ? centerX : centerY;
    radius *= kRadiusPortion;
    [self setNeedsDisplay];
}

//绘制区块
- (void)drawRect:(CGRect)rect
{
    [self drawSlice];
}


#pragma mark private methods
- (void)initInstance
{
    // Initialization code
    self.backgroundColor = [UIColor clearColor];
    self.opaque = NO;
}


- (void)setPinImage:(NSString *)pinImage
{
    _pinImage = pinImage;
    if (pin) {
        [shadowView setImage:[UIImage imageNamed:pinImage]];
    }
}

- (void)drawSlice{
    
    //指针
    NSString *pinName = @"pin";
    if (self.pinImage) {
        pinName = self.pinImage;
    }
    if (!pin)
        pin = [[UIImageView alloc]initWithFrame:CGRectMake(144/2-72, 144/2-72, 144, 144)];
    [pin setImage:[UIImage imageNamed:pinName]];
    pin.layer.anchorPoint = CGPointMake(0.5, 0.5);
    if(!shadowView)
        shadowView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 144, 144)];
    shadowView.alpha = 0.5;
    [self addSubview:shadowView];
    [self addSubview:pin];
    
}


@end

#pragma mark ------------ Piechart-----------------------

#define RADIANS_TO_DEGREES(radians) ((radians) * (180.0 / M_PI))
#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)


static float deltaAngle;
@implementation BMPieChartView

@synthesize startTransform, container, wheelCenter ,clove;

- (id) initWithFrame:(CGRect)frame startRad:(float)startRad endRad:(float)endRad {
    
    if ((self = [super initWithFrame:frame])) {
        self.startRad = startRad;
        self.endRad = endRad;
        [self initWheel];
        
    }
    return self;
}
/**
 *	@brief	初始布局
 */
- (void) initWheel {
    
    container = [[UIView alloc] initWithFrame:self.frame];
    CGRect frame = self.frame;
    float deltas = 144; // ?
    frame.size.height = deltas;
    frame.size.width  = deltas;
    self.chart = [[BMPieChart alloc] initWithFrame:frame];
    
    self.chart.layer.anchorPoint = CGPointMake(0.5f, 0.5f);
    self.chart.layer.position = CGPointMake(container.bounds.size.width/2.0,container.bounds.size.height/2.0);
    [container addSubview:self.chart];
    container.userInteractionEnabled = NO;
    [self addSubview:container];
    [self buildClovesOdd];
    container.transform = CGAffineTransformIdentity;
    CGAffineTransform newTrans = CGAffineTransformRotate(container.transform, self.startRad);
    container.transform = newTrans;
}


/**
 *	@brief	建立操作块
 */
- (void) buildClovesOdd {
    CGFloat min = 0;
    float fanWidth = M_PI*2;
    clove = [[BMClove alloc] init];
    clove.minValue = min;
    clove.midValue = min + fanWidth /2;
    clove.maxValue = min + fanWidth;
    min += fanWidth;
}

#pragma mark - 用户交互
-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    CGPoint delta = [touch locationInView:self];
    startTransform = container.transform;
    float dx = delta.x  - container.center.x;
    float dy = delta.y  - container.center.y;
    deltaAngle = atan2(dy,dx);
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    
    CGPoint pt = [touch locationInView:self];
    
    float dx = pt.x  - container.center.x;
    float dy = pt.y  - container.center.y;
    float ang = atan2(dy,dx);
    float angleDif = deltaAngle - ang;
    CGFloat radians = atan2f(container.transform.b, container.transform.a);
    CGFloat newVal = 0.0;
    
    
    radians = radians > 0 ? radians : 2*M_PI + radians;
    radians = 2 * M_PI - radians;
    
    newVal = clove.midValue -radians;
    
    


        CGAffineTransform newTrans = CGAffineTransformRotate(startTransform, -angleDif);
        if (self.isStopTransform == NO) {
            container.transform = newTrans;
        }
        
         radians = atan2f(newTrans.b, newTrans.a);
         newVal = 0.0;
        
        radians = atan2f(newTrans.b, newTrans.a);
        radians = radians > 0 ? radians : 2*M_PI + radians;
        radians = 2 * M_PI - radians;
        
        
        newVal = clove.midValue -radians;
        
        float value =  round((newVal - self.startRad) / (self.endRad - self.startRad) * 100);
        if(value <0) value = 0;
        if (value > 100) {
            value = 100;
        }
        self.chart.value =  (int)(round(value/10));
        [self.pinDelegate Pie:self TouchProcessingWithValue:value andNewTransform:newTrans];
    
    
}

/**
 *	@brief	设置指针位置
 *
 *	@param 	value 	给定值
 */
- (void) setPinValue:(float)value
{
    float tempt = value;
    
    float trueValue = tempt *10 * (self.endRad - self.startRad) / 100 +self.startRad;
    container.transform = CGAffineTransformIdentity;
    CGAffineTransform newTrans = CGAffineTransformRotate(container.transform,trueValue - M_PI);
    container.transform = newTrans;
    self.chart.value = (int)value;
}


@end
