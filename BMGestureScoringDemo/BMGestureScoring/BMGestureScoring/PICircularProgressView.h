//
//  PICircularProgressView.h
//  BMGestureScoring
//
//  Created by BM on 15/11/4.
//  Copyright © 2015年 BM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PICircularProgressView : UIView
@property (nonatomic) double progress;
@property (nonatomic) NSInteger roundedHead UI_APPEARANCE_SELECTOR;
@property (nonatomic) NSInteger showShadow UI_APPEARANCE_SELECTOR;
//厚度
@property (nonatomic) CGFloat thicknessRatio UI_APPEARANCE_SELECTOR;
//环内颜色
@property (nonatomic, strong) UIColor *outerBackgroundColor UI_APPEARANCE_SELECTOR;
//环颜色
@property (nonatomic, strong) UIColor *progressFillColor UI_APPEARANCE_SELECTOR;
//上部颜色
@property (nonatomic, strong) UIColor *progressTopGradientColor UI_APPEARANCE_SELECTOR;
//下部颜色
@property (nonatomic, strong) UIColor *progressBottomGradientColor UI_APPEARANCE_SELECTOR;
@end
