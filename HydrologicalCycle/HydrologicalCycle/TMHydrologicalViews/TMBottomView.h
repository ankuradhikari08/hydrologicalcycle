//
//  TMBottomView.h
//  HydrologicalCycle
//
//  Created by Ankur Adhikari on 02/03/14.
//  Copyright (c) 2014 HydrologicalCycle. All rights reserved.


#import <UIKit/UIKit.h>

/**
 *  This Class is used to handle all bottom bar views.
 */
extern CGRect const kImageViewRect;

@protocol TMBottomViewDelegate <NSObject>

@required
- (void) didSelectViewAtIndex:(NSInteger)index;

@end

@interface TMBottomView : UIView
@property id<TMBottomViewDelegate> bottomViewDelegate;
- (void) setDisabled;
@end
