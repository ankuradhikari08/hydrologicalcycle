//
//  customrender.m
//  outlineDEMO
//
//  Created by Petros Douvantzis on 9/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TMRiverLayer.h"

//#define _appleImplementation 1



@interface TMRiverLayer (){
}

@end

@implementation TMRiverLayer



@synthesize angle,tension;//this is the property that we will animate


CGMutablePathRef createMutablePath(CGRect frame, CGFloat angle)
{
    CGMutablePathRef mutablePath = CGPathCreateMutable();
    CGPathMoveToPoint(mutablePath, nil, frame.origin.x+10, 28 - 5 * sinf(angle));
    CGPathAddLineToPoint(mutablePath, nil,frame.origin.x +35, 28 - 5 * sinf(angle + M_PI_2));
    CGPathAddLineToPoint(mutablePath, nil, frame.origin.x+50, 28 - 5 * sinf(angle + M_PI));
    CGPathAddLineToPoint(mutablePath, nil, frame.origin.x+75, 28 - 5 * sinf(angle + 3 * M_PI_2));
    CGPathAddLineToPoint(mutablePath, nil, frame.origin.x+100, 28 - 5 * sinf(angle + 3 * M_PI));
    return mutablePath;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super init];
    if (self) {
        
        // Initialization code
        self.frame = frame;
        self.backgroundColor = [UIColor clearColor].CGColor;
        self.opaque = NO;
        
        self.angle = [NSNumber numberWithFloat:10];
        
        self.tension=2;
       
    }
    return self;
}

//we overide drawInContext to perfom our custom rendering
- (void)drawInContext:(CGContextRef)ctx
{
//    CGFloat _tension = self.tension;
//    
//    CGPathRef path = createMutablePath(self.frame, [self.angle floatValue]);
//    
//    UIBezierPath* uipath4 = [UIBezierPath bezierPathWithCGPath:path];
//    
//    //make 1st and 4th path "smoothed"
//    UIBezierPath* smoothedPath4 = [uipath4 smoothedBezierPathWithTension:2*_tension];
//    // Draw  the paths
//    CGContextSetStrokeColorWithColor(ctx, [UIColor colorWithRed:201.0/255.0 green:233/255.0 blue:244/255.0 alpha:0.8].CGColor);
//    CGContextSetLineWidth(ctx, 2.5);
////    CGContextSetLineDash(ctx, 0, NULL, 2);
//    CGContextSetLineCap(ctx, kCGLineCapRound);
//    CGContextSetLineJoin(ctx, kCGLineJoinRound);
//
//    CGContextAddPath(ctx, smoothedPath4.CGPath);
//      
//    CGContextDrawPath(ctx,kCGPathStroke);
//    
//    CGPathRelease(path);
}

//we overide this class function of CAlayer so that changing the value of "linewidth" triggers the use of "drawInContext" to show the changes in the view
+ (BOOL) needsDisplayForKey:(NSString*)key{
    if([key isEqualToString:@"linewidth"] || [key isEqualToString:@"angle"])
        return YES;
    else{
        return [super needsDisplayForKey:key];
    }
}


- (void)dealloc
{
    self.angle = nil;
}

@end
