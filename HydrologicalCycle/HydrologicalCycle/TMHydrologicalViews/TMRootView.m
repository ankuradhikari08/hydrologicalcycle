//
//  TMRootView.m
//  HydrologicalCycle
//
//  Created by Apple on 01/03/14.
//  Copyright (c) 2014 HydrologicalCycle. All rights reserved.
//

#import "TMRootView.h"

@interface TMRootView (){
    
    CAShapeLayer    *   pathLayer1;
    CAShapeLayer    *   pathLayer2;
    CAShapeLayer    *   pathLayer3;
    CAShapeLayer    *   pathLayer4;
    CAShapeLayer    *   pathLayer5;
    CALayer         *   layer1;
    CGColorRef          strokeColor;
}
@end

@implementation TMRootView


-(CAShapeLayer*)getShapeLayerWithPath:(UIBezierPath*)path WithLayer:(CALayer*)layer
{
    CAShapeLayer *pathLayer = [CAShapeLayer layer];
    pathLayer.frame = layer.bounds;
    //pathLayer.bounds = pathRect;
    pathLayer.geometryFlipped = YES;
    pathLayer.path = path.CGPath;
    pathLayer.strokeColor = strokeColor;
    pathLayer.fillColor = nil;
    pathLayer.lineWidth = 2.0f;
    pathLayer.lineJoin = kCALineJoinRound;
    return pathLayer;
}
- (void)setUp:(ROOT_TYPE)type
{
    if (type == ROOT_TYPE_DEFAULT) {
        strokeColor = [[UIColor colorWithRed:72/255.0 green:40/255.0 blue:21/255.0 alpha:1.0] CGColor];
    }
    else{
        strokeColor = [UIColor darkGrayColor].CGColor;
    }
    
    self.layer.backgroundColor=[[UIColor clearColor] CGColor];
    CGRect frame=self.layer.bounds;
    //-----------------------------------------------------------
    layer1=[CALayer layer];
    layer1.frame = frame;
    [self.layer addSublayer:layer1];
    
    int startPointX=frame.size.width/2;
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(startPointX-20,frame.size.height)];
    [path addLineToPoint:CGPointMake(startPointX-40,frame.size.height-20)];
    
    [path addCurveToPoint:CGPointMake(startPointX-50,frame.size.height-40) controlPoint1:CGPointMake(startPointX-40,frame.size.height-20) controlPoint2:CGPointMake(startPointX-60,frame.size.height-30)];
    
    [path addCurveToPoint:CGPointMake(startPointX-70,frame.size.height-70) controlPoint1:CGPointMake(startPointX-50,frame.size.height-40) controlPoint2:CGPointMake(startPointX-70,frame.size.height-45)];
    
    pathLayer1=[self getShapeLayerWithPath:path WithLayer:layer1];
    [layer1 addSublayer:pathLayer1];
    
    
    
    //-----------------------------------------------------------
    CALayer *layer2=[CALayer layer];
    layer2.frame = frame;
    [self.layer addSublayer:layer2];
    
    UIBezierPath *path2 = [UIBezierPath bezierPath];
    [path2 moveToPoint:CGPointMake(startPointX-12,frame.size.height)];
    [path2 addLineToPoint:CGPointMake(startPointX-8,frame.size.height-10)];
    
    [path2 addCurveToPoint:CGPointMake(startPointX-25,frame.size.height-40) controlPoint1:CGPointMake(startPointX-8,frame.size.height-10) controlPoint2:CGPointMake(startPointX-5,frame.size.height-20)];
    
    [path2 addCurveToPoint:CGPointMake(startPointX-40,frame.size.height-100) controlPoint1:CGPointMake(startPointX-25,frame.size.height-40) controlPoint2:CGPointMake(startPointX-5,frame.size.height-45)];
    
    pathLayer2 =[self getShapeLayerWithPath:path2 WithLayer:layer2];
    [layer2 addSublayer:pathLayer2];
    
    //-----------------------------------------------------------
    CALayer *layer3=[CALayer layer];
    layer3.frame = frame;
    [self.layer addSublayer:layer3];
    
    UIBezierPath *path3 = [UIBezierPath bezierPath];
    [path3 moveToPoint:CGPointMake(startPointX+5,frame.size.height-10)];
    [path3 addLineToPoint:CGPointMake(startPointX-2,frame.size.height-20)];
    
    [path3 addCurveToPoint:CGPointMake(startPointX+10,frame.size.height-60) controlPoint1:CGPointMake(startPointX-2,frame.size.height-20) controlPoint2:CGPointMake(startPointX-15,frame.size.height-30)];
    
    [path3 addLineToPoint:CGPointMake(startPointX+10,frame.size.height-110)];
    
    pathLayer3 =[self getShapeLayerWithPath:path3 WithLayer:layer3];
    [layer3 addSublayer:pathLayer3];
    //-----------------------------------------------------------
    CALayer *layer4=[CALayer layer];
    layer4.frame = frame;
    [self.layer addSublayer:layer4];
    
    UIBezierPath *path4 = [UIBezierPath bezierPath];
    [path4 moveToPoint:CGPointMake(startPointX+5,frame.size.height-10)];
    [path4 addLineToPoint:CGPointMake(startPointX+20,frame.size.height-25)];
    
    [path4 addCurveToPoint:CGPointMake(startPointX+60,frame.size.height-70) controlPoint1:CGPointMake(startPointX+20,frame.size.height-25) controlPoint2:CGPointMake(startPointX-2,frame.size.height-35)];
    
    [path4 addLineToPoint:CGPointMake(startPointX+55,frame.size.height-80)];
    
    pathLayer4 =[self getShapeLayerWithPath:path4 WithLayer:layer4];
    [layer4 addSublayer:pathLayer4];
    
    
    //-----------------------------------------------------------
    CALayer *layer5=[CALayer layer];
    layer5.frame = frame;
    [self.layer addSublayer:layer5];
    
    UIBezierPath *path5 = [UIBezierPath bezierPath];
    [path5 moveToPoint:CGPointMake(startPointX,frame.size.height)];
    [path5 addLineToPoint:CGPointMake(startPointX+30,frame.size.height-10)];
    [path5 addCurveToPoint:CGPointMake(startPointX+80,frame.size.height-60) controlPoint1:CGPointMake(startPointX+30,frame.size.height-10) controlPoint2:CGPointMake(startPointX+40,frame.size.height-45)];
    
    [path5 addLineToPoint:CGPointMake(startPointX+90,frame.size.height-80)];
    
    pathLayer5 =[self getShapeLayerWithPath:path5 WithLayer:layer5];
    [layer5 addSublayer:pathLayer5];
    
}

- (void) startAnimation
{
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = 2.0;
    pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
    
    [pathLayer1 addAnimation:pathAnimation forKey:@"strokeEnd"];
    [pathLayer2 addAnimation:pathAnimation forKey:@"strokeEnd"];
    [pathLayer3 addAnimation:pathAnimation forKey:@"strokeEnd"];
    [pathLayer4 addAnimation:pathAnimation forKey:@"strokeEnd"];
    [pathLayer5 addAnimation:pathAnimation forKey:@"strokeEnd"];
    
}


@end
