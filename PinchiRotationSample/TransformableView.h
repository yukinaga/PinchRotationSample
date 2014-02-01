//
//  TransformableView.h
//  PinchiRotationSample
//
//  Created by Yukinaga Azuma on 2014/02/01.
//  Copyright (c) 2014年 Yukinaga Azuma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TransformableView : UIView

@property(nonatomic) CGFloat scale;
@property(nonatomic) CGFloat angle;
@property(nonatomic) BOOL isTransformable;

@end
