//
//  TMContaiminantBubbleView.h
//  HydrologicalCycle
//
//  Created by Ankur Adhikari on 04/03/14.
//  Copyright (c) 2014 HydrologicalCycle. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  This class is used to showing , animating Contaiminant bubble.
 */

typedef NS_ENUM(NSUInteger, TMContaiminantType) {
    TMContaiminantTypeFish,
    TMContaiminantTypeBlueGreen,
    TMContaiminantTypeRedOrange,
    TMContaiminantTypeStone,
    TMContaiminantTypeChlorin
};

@protocol TMContaiminantBubbleViewDelegate <NSObject>

@required
- (void) showContaiminantsForType:(TMContaiminantType)contaiminantType;

@end

@interface TMContaiminantBubbleView : UIView
@property id <TMContaiminantBubbleViewDelegate> contaiminantDelegate;
- (void) animateAlpha:(CGFloat)alpha;
-(void)startAnimation;
@property (nonatomic, readonly) BOOL isAnimating;
@end
