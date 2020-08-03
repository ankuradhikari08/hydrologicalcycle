//
//  TMWindMill.m
//  HydrologicalCycle
//
//  Created by Ankur Adhikari on 02/03/14.
//  Copyright (c) 2014 HydrologicalCycle. All rights reserved.
//

#import "TMWindMill.h"

@interface TMWindMill (){
    __weak IBOutlet UIImageView *windMill;
}

@end

@implementation TMWindMill

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Initialization code
//        windMill = [[UIImageView alloc] initWithFrame:(CGRect){CGPointZero, 35, 35}];
//        windMill.contentMode = UIViewContentModeScaleAspectFit;
//        [self addSubview:windMill];
        
    }
    return self;
}

- (void) setUp{
    CABasicAnimation* rotationAnimation1;
    rotationAnimation1 = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation1.toValue = @M_PI_2;
    rotationAnimation1.duration = 1.0;
    rotationAnimation1.cumulative = YES;
    rotationAnimation1.repeatCount = HUGE_VALF;
    [windMill.layer addAnimation:rotationAnimation1 forKey:@"rotation"];
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
