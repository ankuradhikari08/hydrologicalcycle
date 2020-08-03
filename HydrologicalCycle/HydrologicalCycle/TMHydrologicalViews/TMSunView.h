//
//  TMSunView.h
//  HydrologicalCycle
//
//  Created by Ankur Adhikari on 28/02/14.
//  Copyright (c) 2014 HydrologicalCycle. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TMSunViewDelegate <NSObject>

@required
- (void) sunViewAnimationCompleted;

@end
/**
 *  this class is used to rotate a sun view.
 */
@interface TMSunView : UIView

@property id<TMSunViewDelegate> sunDelegate;
- (void) setUp;
- (void) rotationAnimation;
@end
