//
//  customrender.h
//  outlineDEMO
//
//  Created by Petros Douvantzis on 9/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>


/**
 *  this class is used to add animated water ripple in a SINE curve.
 */
@interface TMRiverLayer : CALayer {
    
    NSNumber* linewidth;
    NSNumber* angle;
    
 
}

- (id)initWithFrame:(CGRect)frame;

@property (nonatomic,strong)    NSNumber             * angle;//this angle is used to rotate path2
@property (nonatomic) CGFloat tension;

@end
