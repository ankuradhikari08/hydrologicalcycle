//
//  TMRainFallView.m
//  HydrologicalCycle
//
//  Created by Ankur Adhikari on 27/02/14.
//  Copyright (c) 2014 HydrologicalCycle. All rights reserved.
//

#import "TMRainFallView.h"

static const int kParticleBirthIntensity = 20;
FOUNDATION_EXPORT NSString *const kRainEmitterName;
FOUNDATION_EXPORT NSString *const kRainEmitterBirthKeyPath;
#define ARC4RANDOM_MAX      0x100000000

@interface TMRainFallView ()

@property (nonatomic, strong) NSMutableArray *emittersArray;

@end

NSString *const kRainEmitterBirthKeyPath = @"emitterCells.rainEmitter.birthRate";
NSString *const kRainEmitterName = @"rainEmitter";

@implementation TMRainFallView
// 507, 170

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _emittersArray = [NSMutableArray arrayWithCapacity:0];
    }
    return self;
}

- (CAEmitterLayer*) getEmitterLayer{
    CAEmitterLayer *emitterLayer = [CAEmitterLayer layer];
    
    //Set the background color to be dark teal
    emitterLayer.backgroundColor = [[UIColor clearColor] CGColor];
    emitterLayer.emitterShape = kCAEmitterLayerCuboid;
    emitterLayer.renderMode = kCAEmitterLayerLine;
    
    //Size of Emitter
    emitterLayer.emitterSize = CGSizeMake(1, 1);
    
    return emitterLayer;
}


- (CAEmitterCell*) getEmitterCellWithYAcceleration:(int)yAcceleration;{
    
    //Create Cell
    CAEmitterCell * rainEmitterCell = [CAEmitterCell emitterCell];
    
    //Name is nessary to access this cell using Key-Value-Coding (KVC)
    rainEmitterCell.name = kRainEmitterName;
    
    //Image used for the cell
    rainEmitterCell.contents = (id) [[UIImage imageNamed:@"water_drop.png"] CGImage];
    
    //Number of particles per second
    rainEmitterCell.birthRate = kParticleBirthIntensity;
    
    //Life in seconds
    rainEmitterCell.lifetime = 1.3;
    // angle
    rainEmitterCell.emissionRange = 150;
    
    // speed
    rainEmitterCell.velocity = 2;
    
    //alpha
    rainEmitterCell.alphaRange = 0.2;
    rainEmitterCell.alphaSpeed = 0;
    
    
    //Scaling of the particles
    rainEmitterCell.scale = 0.2;
    rainEmitterCell.scaleRange = 0.6;
    
    //Magnitude of initial veleocity with which particles travel
    rainEmitterCell.yAcceleration = 200;
    //    rainEmitterCell.xAcceleration = -10;
    //    rainEmitterCell.zAcceleration = 350;
    //Radial direction of emission of the particles
    //    rainEmitterCell.emissionRange = 2 * M_PI;
    
    
    
    return rainEmitterCell;
}
//===============================================================
//Creates emitter layer and set up its properties
//===============================================================
-(void) setupEmitter{
    int scale1 = 15;
    int emitterPosition = scale1;
    for (int index = 0; index < 24; index++) {
        CAEmitterLayer *emitterLayer = [self getEmitterLayer];
        emitterLayer.emitterPosition = CGPointMake(100 + index*emitterPosition, -20);
        NSLog(@"%@", NSStringFromCGPoint(emitterLayer.position));
        [self.layer addSublayer:emitterLayer];
        [_emittersArray addObject:emitterLayer];
    }
    
    //    CAEmitterLayer *emitterLayer = [self getEmitterLayer];
    //    emitterLayer.emitterPosition = CGPointMake(163.44, 5);
    //    NSLog(@"%@", NSStringFromCGPoint(emitterLayer.position));
    //    [self.layer addSublayer:emitterLayer];
    
}



//===============================================================
//Creates emitter cells and set up its properties
//===============================================================
-(void) setupEmitterCells{
    
    //============== EMITTER CELL 1 - Gold Star ==============
    int yAcceleration = 0;
    NSLog(@"%@", [self.layer sublayers]);
    for (id emitterLayer in [self.layer sublayers]) {
        if ([emitterLayer isMemberOfClass:[CAEmitterLayer class]]) {
            CAEmitterCell *emitterCell = [self getEmitterCellWithYAcceleration:yAcceleration];
            yAcceleration+=200;
            [(CAEmitterLayer*)emitterLayer setEmitterCells: @[emitterCell, emitterCell, emitterCell]];
            [emitterLayer setValue:@(kParticleBirthIntensity) forKey:kRainEmitterBirthKeyPath];
        }
    }
}

- (void) stopRainFall{
    self.layer.sublayers = nil;
}

- (void) dealloc{
    
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
