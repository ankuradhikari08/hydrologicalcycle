//
//  TMRainFallView.h
//  HydrologicalCycle
//
//  Created by Ankur Adhikari on 27/02/14.
//  Copyright (c) 2014 HydrologicalCycle. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TMRainFallView : UIView

/**
 *  Create emitterLayer & configure its various properties
 */
- (void) setupEmitter;

/**
 *  Create emitter cells for RAIN WATER, set their properties and add them to the emitter
 */
- (void) setupEmitterCells;

- (void) stopRainFall;
@end
