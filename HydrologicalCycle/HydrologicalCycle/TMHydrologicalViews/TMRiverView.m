//
//  TMRiverView.m
//  HydrologicalCycle
//
//  Created by Ankur Adhikari on 02/03/14.
//  Copyright (c) 2014 HydrologicalCycle. All rights reserved.
//

#import "TMRiverView.h"
#import "TMRiverLayer.h"
#import "TMViewTagConstants.h"

@interface TMRiverView (){
    UIBezierPath *riverPath;
    NSMutableArray *paths;
    
    __weak IBOutlet UIImageView *industryWaterFlow;
    __weak IBOutlet UIImageView *houseWaterFlow;
    __weak IBOutlet UIImageView *factoryFlow;
}

@end

#define UIImage(imageName) [UIImage imageNamed:imageName]

@implementation TMRiverView

/*
 "{-127, 304.5}","{-126, 304.5}","{-126, 304.5}","{-125, 304.5}","{-125, 306}","{-123.5, 306}","{-122.5, 306}","{-121.5, 306}","{-121, 306}","{-120, 306}","{-120, 307}","{-119, 307}","{-116, 307}","{-116, 308}","{-114, 308}","{-113.5, 308}","{-112.5, 308}","{-112.5, 309}","{-111.5, 309}","{-111, 309}","{-110, 309}","{-107, 310}","{-106, 311}","{-104.5, 311}","{-103.5, 312}","{-103, 312}","{-102.5, 312}","{-101.5, 313}","{-101.5, 314}","{-100, 314}","{-100, 314.5}","{-99, 314.5}","{-99, 315.5}","{-98, 315.5}","{-98, 316.5}","{-98, 317.5}","{-98, 318.5}","{-98, 319.5}","{-98, 320}","{-98, 321}","{-100, 322}","{-101, 322}","{-101, 323}","{-102, 323}","{-104, 324}","{-108, 325}","{-112.5, 325.5}","{-116, 325.5}","{-119, 326.5}","{-119.5, 327.5}","{-120.5, 327.5}","{-123, 328.5}","{-128.5, 329.5}","{-136, 330}","{-142, 331}","{-150, 332}","{-158, 332}","{-167, 332}","{-174, 333}","{-182.5, 334}","{-190.5, 334.5}","{-196, 335.5}","{-201, 338}","{-202.5, 338}","{-203.5, 338}","{-204, 338}","{-206.5, 339}","{-207.5, 339}","{-207.5, 340}","{-208.5, 341}","{-209.5, 341}","{-209.5, 342}","{-209.5, 343}","{-209.5, 343.5}","{-206, 346}","{-200, 348}","{-192, 350}","{-186, 350.5}","{-177, 351.5}","{-173, 352.5}","{-168.5, 353.5}","{-160, 353.5}","{-155, 355}","{-144.5, 356}","{-133, 357}","{-119.5, 358.5}","{-108, 359.5}","{-100, 359.5}","{-90.5, 360.5}","{-80, 361.5}","{-73, 364}","{-61.5, 366}","{-56, 368}","{-48, 371}","{-44, 373}","{-36.5, 376.5}","{-33, 379}","{-29.5, 384}","{-25, 390.5}","{-22, 393.5}","{-22, 396.5}","{-24, 401.5}","{-28, 403.5}","{-31, 404.5}","{-34.5, 406}","{-39, 406}","{-44.5, 407}","{-50, 407}","{-52, 407}","{-56, 409}","{-57, 410}","{-63, 413}","{-72.5, 418}","{-74.5, 419}","{-80.5, 421}","{-90.5, 425}","{-102.5, 428.5}","{-117, 429.5}","{-134.5, 429.5}","{-161.5, 429.5}","{-173, 429.5}","{-184.5, 429.5}","{-193, 429.5}","{-199.5, 429.5}","{-206.5, 430.5}","{-207.5, 432}","{-207.5, 432}","{-209.5, 428.5}","{-213, 428.5}","{-213, 428.5}","{-215, 428.5}","{-225.5, 428.5}","{-230, 428.5}","{-232.5, 428.5}","{-235.5, 428.5}","{-236, 428.5}","{-241, 428.5}","{-242.5, 428.5}","{-250, 429.5}","{-257, 429.5}","{-262.5, 429.5}","{-268.5, 429.5}","{-279, 429.5}","{-294.5, 429.5}","{-305, 430.5}","{-327, 432}","{-344.5, 432}","{-346.5, 432}","{-353.5, 432}","{-355, 431.5}","{-369.5, 430.5}","{-383, 427.5}","{-397, 422}","","{-417.5, 418}","{-426.5, 413.5}","{-436.5, 409.5}","{-441, 407}","{-441.5, 407}","{-444.5, 404}","{-447.5, 403.5}","{-453.5, 401.5}","{-454, 401.5}","{-456.5, 400.5}","{-458, 399}","{-461, 398}","{-474.5, 395}","{-474.5, 395}"
 */

- (id) initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
    }
    
    return self;
}

CGMutablePathRef createRivePath(NSArray *stringPaths, CGFloat maxHeight){
    CGMutablePathRef path = CGPathCreateMutable();
    if (stringPaths && stringPaths.count > 0) {
        CGPoint p = CGPointFromString(stringPaths[0]);
        p.y = maxHeight - p.y;
        NSLog(@"%@", NSStringFromCGPoint(p));
        CGPathMoveToPoint(path, nil, p.x, p.y);
        for (int i = 1; i < stringPaths.count; i++) {
            p = CGPointFromString(stringPaths[i]);
            p.y = maxHeight - p.y;
            NSLog(@"%@", NSStringFromCGPoint(p));
            CGPathAddLineToPoint(path, nil, p.x, p.y);
        }
    }
    // do stuff
    return path;
}

- (void) setUp{
//    UIView *view=(UIView*)[self viewWithTag:111];
//    [view.layer setMasksToBounds:NO];
    
//    [self addRiverLayer:view];
    
    [[[self viewWithTag:kLeftUpperRiverViewTag] layer] setSublayers:nil];
    [[[self viewWithTag:kLeftLowerRiverViewTag] layer] setSublayers:nil];
    [[[self viewWithTag:kRightRiverViewTag] layer] setSublayers:nil];
    
    [self addRiverLayer:(UIView*)[self viewWithTag:kLeftUpperRiverViewTag]];
    [self addRiverLayer:(UIView*)[self viewWithTag:kLeftLowerRiverViewTag]];
    [self addRiverLayer:(UIView*)[self viewWithTag:kRightRiverViewTag]];
    
    industryWaterFlow.animationImages = @[UIImage(@"factory1.png"),UIImage(@"factory2.png"),UIImage(@"factory3.png"),UIImage(@"factory4.png"),UIImage(@"factory5.png"),UIImage(@"factory6.png"),UIImage(@"factory7.png")];
    
    houseWaterFlow.animationImages = @[UIImage(@"home1.png"),UIImage(@"home2.png"),UIImage(@"home3.png"),UIImage(@"home4"),UIImage(@"home5.png"),UIImage(@"home6.png"),UIImage(@"home7.png")];
    factoryFlow.animationImages = @[UIImage(@"water_pipe1.png"),UIImage(@"water_pipe2.png"),UIImage(@"water_pipe3.png"),UIImage(@"water_pipe4.png"),UIImage(@"water_pipe5.png"),UIImage(@"water_pipe6.png"),UIImage(@"water_pipe7.png")];
    [industryWaterFlow setAnimationDuration:1.0f];
    [houseWaterFlow setAnimationDuration:1.0f];
    [factoryFlow setAnimationDuration:1.0f];
    [industryWaterFlow startAnimating];
    [houseWaterFlow startAnimating];
    [factoryFlow startAnimating];
    
}

- (void) startAnimating{
    industryWaterFlow.hidden = NO;
    houseWaterFlow.hidden = NO;
    factoryFlow.hidden = NO;
}

-(void)addRiverLayer:(UIView*)view
{
    TMRiverLayer *riverLayer = [[TMRiverLayer alloc] initWithFrame:view.bounds];
    [view.layer addSublayer:riverLayer];
    
    //create an animation for the angle of the second path
    CABasicAnimation *animation2 = [CABasicAnimation animationWithKeyPath:@"angle"];
    animation2.duration =5;
    animation2.fromValue = [NSNumber numberWithFloat:0];
    animation2.toValue = [NSNumber numberWithFloat:6];
    animation2.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    animation2.cumulative=YES;
    //animation2.autoreverses = YES;
    animation2.repeatCount = HUGE_VALF;
    [riverLayer addAnimation:animation2 forKey:@"animateangle"];
}

- (void) dealloc{
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
