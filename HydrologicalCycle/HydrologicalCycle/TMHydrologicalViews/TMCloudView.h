//
//  TMCloudView.h
//  HydrologicalCycle
//
//  Created by Ankur Adhikari on 27/02/14.
//  Copyright (c) 2014 HydrologicalCycle. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  This class is used to handle cloud animation.
 */

@protocol TMCloudViewDelegate <NSObject>
@required

- (void) startRaining;

@end

@interface TMCloudView : UIView
-(void)startRepeatCycle;
- (void) setUp;
- (void) startAnimation;
@property (nonatomic, weak) id<TMCloudViewDelegate> cloudDelegate;

@end
