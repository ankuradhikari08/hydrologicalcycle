//
//  TMRootView.h
//  HydrologicalCycle
//
//  Created by Apple on 01/03/14.
//  Copyright (c) 2014 HydrologicalCycle. All rights reserved.
//


#import <UIKit/UIKit.h>


typedef NS_ENUM(NSUInteger, ROOT_TYPE) {
    ROOT_TYPE_DEFAULT,
    ROOT_TYPE_GRAY
};
/**
 *  this class is used to draw a tree root using Bezier path.
 */
@interface TMRootView : UIView
- (void) setUp:(ROOT_TYPE)type;
- (void) startAnimation;
@end
