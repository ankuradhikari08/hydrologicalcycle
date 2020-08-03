//
//  TMRippleView.m
//  HydrologicalCycle
//
//  Created by Ankur Adhikari on 04/03/14.
//  Copyright (c) 2014 HydrologicalCycle. All rights reserved.
//

#import "TMRippleView.h"

#define kAnimationDuration 0.4f
#define kNumberOfWaves 2
#define kSpawnInterval 0.15f
#define kWaveSpawnSize 6.0f
#define kAnimationScaleFactor 8.0f
#define kShadowRadius 2.0f

@interface SCWaveLayer : CALayer
{
	
}
- (void) startAnimation;
@end

@implementation SCWaveLayer

- (void)dealloc
{
    [self removeAllAnimations];
}

- (void)drawInContext:(CGContextRef)theContext
{
    CGContextSetRGBStrokeColor(theContext, 1.0, 1.0, 1.0, 1.0);
    CGContextSetLineWidth(theContext, 1.5f);
    CGContextStrokeEllipseInRect(theContext, CGRectMake(self.bounds.size.width/2-(kWaveSpawnSize/2), self.bounds.size.height/2-(kWaveSpawnSize/2), kWaveSpawnSize, kWaveSpawnSize));
}

- (void) startAnimation
{
    
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = -1 / 500.0;
    transform = CATransform3DRotate(transform, .85 * M_PI_2, 1, 0, 0);
    self.transform = transform;
    
    CABasicAnimation* scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
	scaleAnimation.duration = kAnimationDuration;
	scaleAnimation.delegate = self;
	scaleAnimation.repeatCount = 0;
	scaleAnimation.removedOnCompletion = FALSE;
	scaleAnimation.fillMode = kCAFillModeForwards;
	scaleAnimation.toValue = [NSNumber numberWithFloat:kAnimationScaleFactor];
	[self addAnimation:scaleAnimation forKey:@"scale"];
	
	CABasicAnimation* opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
	opacityAnimation.duration = kAnimationDuration;
	opacityAnimation.repeatCount = 0;
	opacityAnimation.removedOnCompletion = FALSE;
	opacityAnimation.fillMode = kCAFillModeForwards;
	opacityAnimation.toValue = [NSNumber numberWithFloat:0.0];
	[self addAnimation:opacityAnimation forKey:@"opacity"];
}

- (void)animationDidStop:(CAAnimation *)theAnimation finished:(BOOL)flag
{
	[self removeFromSuperlayer];
    
}

@end

@implementation TMRippleView

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self spawnWave1];
		if (1<0) {
            double spawnInterval = kSpawnInterval;
            if (!spawnInterval > kAnimationDuration*1.25) {
                spawnInterval = kAnimationDuration*1.25;
            }
            
		}
    }
    return self;
}


- (void) spawnWave1
{
	SCWaveLayer* wave = [SCWaveLayer layer];
    [wave setBounds:(CGRect){CGPointZero, 10, 10}];
    wave.position = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
    wave.cornerRadius = 5.0F;
    wave.shadowColor =[UIColor whiteColor].CGColor;//[UIColor colorWithRed:71.0/255.0 green:271/255.0 blue:229/255.0 alpha:0.2].CGColor;
    wave.shadowOffset = CGSizeMake(0, 0);
    wave.shadowOpacity = 1.0;
    wave.shadowRadius = kShadowRadius;
    wave.backgroundColor = [UIColor whiteColor].CGColor;
    [self.layer addSublayer:wave];
    [wave setNeedsDisplay];
    [wave startAnimation];
	
//	wavesSpawned++;
//	if (wavesSpawned == kNumberOfWaves) {
//		[timer invalidate];
		/*
		 * - (void)invalidate
		 *
		 * "The NSRunLoop object removes and releases the timer,
		 * either just before the invalidate method returns or at some later point."
		 *
		 */
		// = nil;
//	}
}

- (void) setUp{
    [self.layer setMasksToBounds:NO];
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(spawnWave1) userInfo:nil repeats:YES];
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
