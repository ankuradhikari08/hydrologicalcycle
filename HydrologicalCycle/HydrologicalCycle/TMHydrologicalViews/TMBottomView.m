//
//  TMBottomView.m
//  HydrologicalCycle
//
//  Created by Ankur Adhikari on 02/03/14.
//  Copyright (c) 2014 HydrologicalCycle. All rights reserved.
//

#import "TMBottomView.h"
#import "APLPositionToBoundsMapping.h"
#import "TMViewTagConstants.h"
#import "TMFrameConstants.h"

@interface TMBottomView (){
    UIImageView *imageView;
    UILabel *label;
    CGRect button1Bounds;
    UIDynamicAnimator *dynamicAnimator;
    NSInteger currentSelectedTab;
}

@end

//CGRect const kImageViewRect={0,0,70,70};

@implementation TMBottomView

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Initialization code
        self->button1Bounds = self.bounds;
        imageView = (UIImageView*)[self viewWithTag:kBottomImageTag];
        label = (UILabel*)[self viewWithTag:kBottomLableTag];
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [self addGestureRecognizer:tapGesture];
        
        [self.layer setMasksToBounds:NO];
        imageView.backgroundColor = [UIColor clearColor];
        [imageView.layer setMasksToBounds:NO];
        [label.layer setMasksToBounds:NO];
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.


- (void)tapAction:(UITapGestureRecognizer*)tapGesture
{
    // Reset the buttons bounds to their initial state.  See the comment in
    // -viewDidLoad.
    self.bounds = self->button1Bounds;
   
    // UIDynamicAnimator instances are relatively cheap to create.
    UIDynamicAnimator *animator;
    if (!self->dynamicAnimator) {
        animator = [[UIDynamicAnimator alloc] initWithReferenceView:self];
    }
    
    [self->dynamicAnimator removeAllBehaviors];
    imageView.frame=kImageViewRect;
    
    // APLPositionToBoundsMapping maps the center of an id<ResizableDynamicItem>
    // (UIDynamicItem with mutable bounds) to its bounds.  As dynamics modifies
    // the center.x, the changes are forwarded to the bounds.size.width.
    // Similarly, as dynamics modifies the center.y, the changes are forwarded
    // to bounds.size.height.
    APLPositionToBoundsMapping *buttonBoundsDynamicItem = [[APLPositionToBoundsMapping alloc] initWithTarget:(id)imageView];
    
    // Create an attachment between the buttonBoundsDynamicItem and the initial
    // value of the button's bounds.
    UIAttachmentBehavior *attachmentBehavior = [[UIAttachmentBehavior alloc] initWithItem:buttonBoundsDynamicItem attachedToAnchor:buttonBoundsDynamicItem.center];
    [attachmentBehavior setFrequency:3.0];
    [attachmentBehavior setDamping:0.3];
    [animator addBehavior:attachmentBehavior];
    
    UIPushBehavior *pushBehavior = [[UIPushBehavior alloc] initWithItems:@[buttonBoundsDynamicItem] mode:UIPushBehaviorModeInstantaneous];
    pushBehavior.angle = M_PI_2;
    pushBehavior.magnitude = 1.0;
    [animator addBehavior:pushBehavior];
    
    [pushBehavior setActive:TRUE];
    
    self->dynamicAnimator = animator;
    if(currentSelectedTab==self.tag)
    {
        [self setDisabled];
    }
    else
    {
        switch (self.tag) {
            case kEarthViewTag:{
                imageView.image = [UIImage imageNamed:@"earth_highlighted"];
                label.textColor = [UIColor whiteColor];
                [_bottomViewDelegate didSelectViewAtIndex:0];
                currentSelectedTab =self.tag;
            }
                
                break;
                
            case kWaterViewTag:{
                imageView.image = [UIImage imageNamed:@"water_highlighted"];
                label.textColor = [UIColor whiteColor];
                [_bottomViewDelegate didSelectViewAtIndex:1];
                currentSelectedTab=self.tag;

            }
                break;
                
            case kGlassViewTag:{
                imageView.image = [UIImage imageNamed:@"glass_highlighted"];
                label.textColor = [UIColor whiteColor];
                [_bottomViewDelegate didSelectViewAtIndex:2];
                currentSelectedTab=self.tag;

            }
                break;
                
            case kUndergroundViewTag:{
                imageView.image = [UIImage imageNamed:@"underground_highlighted"];
                label.textColor = [UIColor whiteColor];
                [_bottomViewDelegate didSelectViewAtIndex:3];
                currentSelectedTab=self.tag;

            }
                break;
                
            case kWateringlassViewTag:{
                imageView.image = [UIImage imageNamed:@"water_glass_highlighted"];
                label.textColor = [UIColor whiteColor];
                [_bottomViewDelegate didSelectViewAtIndex:4];
                currentSelectedTab=self.tag;

            }
                break;
                
            case kPlantViewTag:{
                imageView.image = [UIImage imageNamed:@"plant_highlighted"];
                label.textColor = [UIColor whiteColor];
                [_bottomViewDelegate didSelectViewAtIndex:5];
                currentSelectedTab=self.tag;

            }
                break;
            case kCloud_rainViewTag:{
                imageView.image = [UIImage imageNamed:@"cloud_highlighted"];
                label.textColor = [UIColor whiteColor];
                [_bottomViewDelegate didSelectViewAtIndex:6];
                currentSelectedTab=self.tag;
                
            }
                break;
                
            default:{
                
            }
                break;
        }

        
    }
    
    
    
}

- (void) setDisabled{
    switch (self.tag) {
        case kEarthViewTag:{
            imageView.image = [UIImage imageNamed:@"earth_normal"];
            label.textColor = [UIColor colorWithRed:91.0f/255.0f green:52.0f/255.0f blue:32.0f/255.0f alpha:1.0f];
        }
            
            break;
            
        case kWaterViewTag:{
            imageView.image = [UIImage imageNamed:@"water_normal"];
            label.textColor = [UIColor colorWithRed:91.0f/255.0f green:52.0f/255.0f blue:32.0f/255.0f alpha:1.0f];
        }
            break;
            
        case kGlassViewTag:{
            imageView.image = [UIImage imageNamed:@"glass_normal"];
            label.textColor = [UIColor colorWithRed:91.0f/255.0f green:52.0f/255.0f blue:32.0f/255.0f alpha:1.0f];
        }
            break;
            
        case kUndergroundViewTag:{
            imageView.image = [UIImage imageNamed:@"underground_normal"];
            label.textColor = [UIColor colorWithRed:91.0f/255.0f green:52.0f/255.0f blue:32.0f/255.0f alpha:1.0f];
        }
            break;
            
        case kWateringlassViewTag:{
            imageView.image = [UIImage imageNamed:@"water_glass_normal"];
            label.textColor = [UIColor colorWithRed:91.0f/255.0f green:52.0f/255.0f blue:32.0f/255.0f alpha:1.0f];
        }
            break;
            
        case kPlantViewTag:{
            imageView.image = [UIImage imageNamed:@"plant_normal"];
            label.textColor = [UIColor colorWithRed:91.0f/255.0f green:52.0f/255.0f blue:32.0f/255.0f alpha:1.0f];
        }
            break;
            
        case kCloud_rainViewTag:{
            imageView.image = [UIImage imageNamed:@"cloud_normal"];
            label.textColor = [UIColor colorWithRed:91.0f/255.0f green:52.0f/255.0f blue:32.0f/255.0f alpha:1.0f];
        }
            break;
            
        default:{
            
        }
            break;
    }
                currentSelectedTab=0;
}

@end
