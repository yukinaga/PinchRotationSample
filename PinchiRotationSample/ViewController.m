//
//  ViewController.m
//  PinchiRotationSample
//
//  Created by Yukinaga Azuma on 2014/02/01.
//  Copyright (c) 2014年 Yukinaga Azuma. All rights reserved.
//

#import "ViewController.h"
#import "TransformableView.h"

@interface ViewController (){
    TransformableView *tView;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //Multiple touch
    self.view.multipleTouchEnabled = YES;
    
    //New Transformable View
    tView = [TransformableView new];
    tView.backgroundColor = [UIColor redColor];
    tView.isTransformable = YES;
    tView.frame = CGRectMake(0, 0, 100, 100);
    tView.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2);
    [self.view addSubview:tView];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {

    if ([touches count] == 2) {
        
        //Touches
        NSArray *touchesArray = [touches allObjects];
        UITouch *touch1 = touchesArray[0];
        UITouch *touch2 = touchesArray[1];
        
        //Point 1
        CGPoint prePoint1 = [touch1 previousLocationInView:self.view];
        CGPoint locationPoint1 = [touch1 locationInView:self.view];
        
        //Point2
        CGPoint prePoint2 = [touch2 previousLocationInView:self.view];
        CGPoint locationPoint2 = [touch2 locationInView:self.view];
        
        //Distance
        CGFloat preDistance = sqrtf(powf(prePoint2.x-prePoint1.x, 2)+
                                    powf(prePoint2.y-prePoint1.y, 2));
        CGFloat locationDistance = sqrtf(powf(locationPoint2.x-locationPoint1.x, 2)+
                                         powf(locationPoint2.y-locationPoint1.y, 2));
        
        //Scale increment
        tView.scale *= locationDistance/preDistance;
        
        //Angle increment
        CGFloat angleIncrement = angleBetweenLinesInRadians([touch1 previousLocationInView:self.view],
                                                            [touch2 previousLocationInView:self.view],
                                                            [touch1 locationInView:self.view],
                                                            [touch2 locationInView:self.view]);
        tView.angle += angleIncrement;
    }
}

static inline CGFloat angleBetweenLinesInRadians(CGPoint line1Start, CGPoint line1End, CGPoint line2Start, CGPoint line2End) {
    CGFloat a = line1End.x - line1Start.x;
    CGFloat b = line1End.y - line1Start.y;
    CGFloat c = line2End.x - line2Start.x;
    CGFloat d = line2End.y - line2Start.y;
    
    CGFloat line1Slope = (line1End.y - line1Start.y) / (line1End.x - line1Start.x);
    CGFloat line2Slope = (line2End.y - line2Start.y) / (line2End.x - line2Start.x);
    
    CGFloat degs = acosf(((a*c) + (b*d)) / ((sqrt(a*a + b*b)) * (sqrt(c*c + d*d))));
    
    return (line2Slope > line1Slope) ? degs : -degs;
}

@end