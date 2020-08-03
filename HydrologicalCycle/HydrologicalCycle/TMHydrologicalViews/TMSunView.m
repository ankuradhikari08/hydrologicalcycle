//
//  TMSunView.m
//  HydrologicalCycle
//
//  Created by Ankur Adhikari on 28/02/14.
//  Copyright (c) 2014 HydrologicalCycle. All rights reserved.
//

#import "TMSunView.h"
#import "TMFrameConstants.h"

@interface TMSunView (){
    UIImageView *sunImageView;
    UIImageView *sunOverlayImageView;
}

@end

@implementation TMSunView


- (void) setUp{
    sunImageView = [[UIImageView alloc] initWithFrame:kSunImageViewFrame];
    sunImageView.contentMode = UIViewContentModeScaleAspectFit;
    sunImageView.image = [UIImage imageNamed:@"sun"];
    sunImageView.alpha = 0.5f;
    sunOverlayImageView = [[UIImageView alloc] initWithFrame:kSunOverlayImageViewFrame];
    sunOverlayImageView.contentMode = UIViewContentModeScaleAspectFit;
    sunOverlayImageView.image = [UIImage imageNamed:@"sun_overlay"];
    sunOverlayImageView.alpha = 0.7f;
    [self addSubview:sunImageView];
    [self addSubview:sunOverlayImageView];
    
    [self.layer setMasksToBounds:YES];
    
    [UIView animateKeyframesWithDuration:5
                                   delay:0
                                 options:UIViewKeyframeAnimationOptionCalculationModePaced
                              animations:^{
                                  self->sunImageView.center = kSunImageViewPoints;
                                  self->sunOverlayImageView.center = kSunImageViewPoints;
                                  self->sunImageView.alpha = 1.0f;
                                  self->sunOverlayImageView.alpha = 1.0f;
                              }
                              completion:^(BOOL finished) {
                                  [self rotationAnimation];
                                  [self->_sunDelegate sunViewAnimationCompleted];
                              }];
}
/**
 *  this method is responsiable for rotate a sun using CABasicAnimation
 */
- (void) rotationAnimation{
    // Do any additional setup after loading the view.
    CABasicAnimation* rotationAnimation1;
    rotationAnimation1 = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation1.toValue = @M_PI_2;
    //* 2.0 /* full rotation*/ * rotations * duration ];
    rotationAnimation1.duration = 5.0;
    rotationAnimation1.cumulative = YES;
    rotationAnimation1.repeatCount = HUGE_VALF;
    [self->sunImageView.layer addAnimation:rotationAnimation1 forKey:@"rotation"];
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
