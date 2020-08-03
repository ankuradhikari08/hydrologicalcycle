//
//  TMContaiminantBubbleView.m
//  HydrologicalCycle
//
//  Created by Ankur Adhikari on 04/03/14.
//  Copyright (c) 2014 HydrologicalCycle. All rights reserved.
//

#import "TMContaiminantBubbleView.h"
#import "APLPositionToBoundsMapping.h"
#import "TMViewTagConstants.h"

@interface TMContaiminantBubbleView (){
    UIImageView *imageView;
    UILabel *label;
    CGRect button1Bounds;
    UIDynamicAnimator *dynamicAnimator;
}
@property (readwrite) BOOL isAnimating;

@end


@implementation TMContaiminantBubbleView

- (id) initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [self addGestureRecognizer:tapGesture];
    }
    return self;
}

/**
 *  This method is used to drop & bouncy effect on a bubble
 *
 *  @param alpha : value
 */
- (void) animateAlpha:(CGFloat)alpha{
    self.alpha = alpha;
    // UIDynamicAnimator instances are relatively cheap to create.
    UIDynamicAnimator *animator = [[UIDynamicAnimator alloc] initWithReferenceView:self];
    
    // APLPositionToBoundsMapping maps the center of an id<ResizableDynamicItem>
    // (UIDynamicItem with mutable bounds) to its bounds.  As dynamics modifies
    // the center.x, the changes are forwarded to the bounds.size.width.
    // Similarly, as dynamics modifies the center.y, the changes are forwarded
    // to bounds.size.height.
    APLPositionToBoundsMapping *buttonBoundsDynamicItem = [[APLPositionToBoundsMapping alloc] initWithTarget:(id)self];
    
    // Create an attachment between the buttonBoundsDynamicItem and the initial
    // value of the button's bounds.
    UIAttachmentBehavior *attachmentBehavior = [[UIAttachmentBehavior alloc] initWithItem:buttonBoundsDynamicItem attachedToAnchor:buttonBoundsDynamicItem.center];
    [attachmentBehavior setFrequency:0.2];
    [attachmentBehavior setDamping:0.2];
    [animator addBehavior:attachmentBehavior];
    
    UIPushBehavior *pushBehavior = [[UIPushBehavior alloc] initWithItems:@[buttonBoundsDynamicItem] mode:UIPushBehaviorModeInstantaneous];
    pushBehavior.angle = M_PI_2;
    pushBehavior.magnitude = 1.0;
    [animator addBehavior:pushBehavior];
    
    [pushBehavior setActive:TRUE];
    
    self->dynamicAnimator = animator;
    
    [NSTimer scheduledTimerWithTimeInterval:10.0 target:self selector:@selector(startAnimation) userInfo:nil repeats:NO];
}

/**
 *  This method is used to animate bubble on water surface.
 */
-(void)startAnimation
{
    _isAnimating = YES;
    
    CABasicAnimation* translateAnimation = [CABasicAnimation animationWithKeyPath:@"transform.translation.x"];
    translateAnimation.duration = 2.0;
    translateAnimation.repeatCount = HUGE_VALF;
    translateAnimation.autoreverses=YES; 
    translateAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    translateAnimation.fromValue = [NSNumber numberWithFloat:-2.0];
    translateAnimation.toValue = [NSNumber numberWithFloat:4.0];
    [self.layer addAnimation:translateAnimation forKey:@"translateAnimation"];
}

- (void) tapAction:(id)sender{
    if(self.tag == kFishContaminatedBubbleViewTag){
        [self.contaiminantDelegate showContaiminantsForType:TMContaiminantTypeFish];
    }
    else if(self.tag == kBlueGreenContaminatedBubbleViewTag){
        [self.contaiminantDelegate showContaiminantsForType:TMContaiminantTypeBlueGreen];
    }
    else if(self.tag == kRedOrangeContaminatedBubbleViewTag){
        [self.contaiminantDelegate showContaiminantsForType:TMContaiminantTypeRedOrange];
    }
    else if(self.tag == kStoneContaminatedBubbleViewTag){
        [self.contaiminantDelegate showContaiminantsForType:TMContaiminantTypeStone];
    }
    else if(self.tag == kChlorineContaminatedBubbleViewTag){
        [self.contaiminantDelegate showContaiminantsForType:TMContaiminantTypeChlorin];
    }
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
