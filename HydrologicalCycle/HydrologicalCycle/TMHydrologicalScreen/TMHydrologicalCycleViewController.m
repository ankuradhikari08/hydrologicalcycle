//
//  TMHydrologicalCycleViewController.m
//  HydrologicalCycle
//
//  Created by Ankur Adhikari on 27/02/14.
//  Copyright (c) 2014 HydrologicalCycle. All rights reserved.
//

#import "TMHydrologicalCycleViewController.h"
#import "TMRainFallView.h"
#import "TMCloudView.h"
#import "TMSunView.h"
#import "TMSmokeView.h"
#import "TMRootView.h"
#import "TMWindMill.h"
#import "TMRiverView.h"
#import <SpriteKit/SpriteKit.h>
#import "TMBottomView.h"
#import "TMRippleView.h"
#import "TMContaiminantBubbleView.h"
#import "TMContaiminantView.h"
#import <AVFoundation/AVFoundation.h>
#import "TMStringConstants.h"
#import "MacroUtilities.h"

#define UITapGestureRecognizer(selector) [[UITapGestureRecognizer alloc] initWithTarget:self action:selector]

#define ANIMATE_VIEW(view) [UIView animateWithDuration:1.0f\
                                            animations:^{\
                                                view.alpha = 1.0f;\
                                            }\
                                            completion:^(BOOL finished) {\
                                                view.alpha = 0.0f;\
                            }]

@interface TMHydrologicalCycleViewController () <TMSunViewDelegate, TMCloudViewDelegate, TMContaiminantBubbleViewDelegate,TMBottomViewDelegate, AVAudioPlayerDelegate>{
    
    __weak IBOutlet TMCloudView *cloudView;
    __weak IBOutlet TMSunView *sunView;
    __weak IBOutlet TMRainFallView *rainFall;
    
    __weak IBOutlet TMBottomView *cloudImage;
    __weak IBOutlet TMBottomView *earthImage;
    __weak IBOutlet TMBottomView *glassImage;
    __weak IBOutlet TMBottomView *plantImage;
    __weak IBOutlet TMBottomView *undergroundWaterImage;
    __weak IBOutlet TMBottomView *waterInGlassImage;
    __weak IBOutlet TMBottomView *waterImage;
    __weak IBOutlet TMSmokeView *smoke1;
    __weak IBOutlet TMSmokeView *smoke2;
    __weak IBOutlet TMRootView *rootView1;
    __weak IBOutlet TMRootView *rootView2;
    __weak IBOutlet TMRootView *rootView3;
    
    __weak IBOutlet TMWindMill *windMill;
    
    __weak IBOutlet TMRiverView *riverView1;
    __weak IBOutlet TMRiverView *riverView2;
    
    __weak IBOutlet TMRippleView *rippleWave1;
    __weak IBOutlet TMRippleView *rippleWave2;
    __weak IBOutlet TMRippleView *rippleWave3;
    
    __weak IBOutlet TMContaiminantBubbleView *fishContaiminantBubbleView;
    __weak IBOutlet TMContaiminantBubbleView *chlorinContaiminantBubbleView;
    __weak IBOutlet TMContaiminantBubbleView *blueGreenContaiminantBubbleView;
    __weak IBOutlet TMContaiminantBubbleView *redOrangeoContaiminantBubbleView;
    __weak IBOutlet TMContaiminantBubbleView *stoneContaiminantBubbleView;
    
    __weak IBOutlet TMContaiminantView *fishContaiminantView;
    __weak IBOutlet TMContaiminantView *chlorinContaiminantView;
    
    __weak IBOutlet TMContaiminantView *blueGreenContaiminantView;
    __weak IBOutlet TMContaiminantView *redOrangeContaiminantView;
    __weak IBOutlet TMContaiminantView *stoneContaiminantView;
    
    __weak IBOutlet UIImageView *evaporationTopArrow;
    __weak IBOutlet UIImageView *evaporation;
    __weak IBOutlet UIImageView *evaporationMiddleArrow;
    __weak IBOutlet UIImageView *evaporationBottomArrow;
    __weak IBOutlet UIImageView *condensation;
    __weak IBOutlet UIImageView *condensationTopArrow;
    __weak IBOutlet UIImageView *precipitationTopArrow;
    __weak IBOutlet UIImageView *precipitation;
    __weak IBOutlet UIImageView *surfaceRunOff;
    __weak IBOutlet UIImageView *surfaceRunOffBottomArrow;
    __weak IBOutlet UIImageView *surfaceRunOffArrow;
    __weak IBOutlet UIImageView *transpiration;
    __weak IBOutlet UIImageView *transpirationBottomArrow;
    __weak IBOutlet UIImageView *snowmeltRunoff;
    __weak IBOutlet UIImageView *snowmeltLowerArrow;
    __weak IBOutlet UIImageView *snowmeltUpperArrow;
    __weak IBOutlet UIView *rightInfoView;
    __weak IBOutlet UILabel *rightInfoLabel;
    __weak IBOutlet UIView *leftInfoView;
    __weak IBOutlet UILabel *leftInfoLabel;
    
    __weak IBOutlet UIImageView *backGroundImageView;
    
    __weak IBOutlet UIButton *playStopButton;
    NSArray *dataSource;
    BOOL    isCycleRepeat;
    
}

@property (nonatomic, strong) AVAudioPlayer *audioPlayer;

@end

@implementation TMHydrologicalCycleViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) dealloc{
    _audioPlayer = nil;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    isCycleRepeat=NO;
	// Do any additional setup after loading the view.
    
    dataSource = @[
                   @{@"name":kLocalized(@"Evaporation"),@"description":kLocalized(@"Evaporation Description")},
                   @{@"name":kLocalized(@"Condensation"),@"description":kLocalized(@"Condensation Description")},
                   @{@"name":kLocalized(@"Transpiration"),@"description":kLocalized(@"Transpiration Description")},
                   @{@"name":kLocalized(@"Precipitation"),@"description":kLocalized(@"Precipitation Description")},
                   @{@"name":kLocalized(@"Surface Runoff"),@"description":kLocalized(@"Surface Runoff Description")},
                   @{@"name":kLocalized(@"Snowmelt Runoff"),@"description":kLocalized(@"Snowmelt Runoff Description")}
                   ];

    //Adding gesture on all Hydrological Cycle events.
    UITapGestureRecognizer *evaporationGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(evaporationGestureAction:)];
    UITapGestureRecognizer *condensationGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(condensationGestureAction:)];
    UITapGestureRecognizer *precipitationGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(precipitationGestureAction:)];
    UITapGestureRecognizer *surfaceRunOffGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(surfaceRunOffGestureAction:)];
    UITapGestureRecognizer *transpirationGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(transpirationGestureAction:)];
    UITapGestureRecognizer *snowwmeltRunoffGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(snowwmeltRunoffGestureAction:)];
    UITapGestureRecognizer *snowwmeltUpperArrowGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(snowwmeltUpperArrowGestureAction:)];
    
    [evaporation addGestureRecognizer:evaporationGesture];
    
    [condensation addGestureRecognizer:condensationGesture];
    
    [precipitation addGestureRecognizer:precipitationGesture];
    [surfaceRunOff addGestureRecognizer:surfaceRunOffGesture];
    
    [transpiration addGestureRecognizer:transpirationGesture];
    
    [snowmeltRunoff addGestureRecognizer:snowwmeltRunoffGesture];
    
    [snowmeltUpperArrow addGestureRecognizer:snowwmeltUpperArrowGesture];

    
    //Background Image gesture
    UITapGestureRecognizer *backGroundGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backGroundGestureAction:)];
    
    [backGroundImageView addGestureRecognizer:backGroundGesture];
    
    
    cloudView.cloudDelegate = self;
    
    //    [cloudView setUp];
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"hydrological_video" ofType:@"mp3"];
    
    // create a session
    NSError *error;
    NSURL *url = [[NSURL alloc] initFileURLWithPath:filePath];
    
    _audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    _audioPlayer.volume = 1.0f;
    _audioPlayer.numberOfLoops = -1;
    _audioPlayer.delegate = self;
    [_audioPlayer prepareToPlay];
    [_audioPlayer play];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        self->sunView.sunDelegate = self;
        [self->sunView setUp];
        
        [self->smoke1 setUp];
        [self->smoke2 setUp];
        [self->smoke1 setUpClean];
        [self->smoke2 setUpClean];
        [self->rootView1 setUp:ROOT_TYPE_DEFAULT];
        [self->rootView1 startAnimation];
        [self->rootView2 setUp:ROOT_TYPE_GRAY];
        [self->rootView2 startAnimation];
        [self->rootView3 setUp:ROOT_TYPE_DEFAULT];
        [self->rootView3 startAnimation];
        [self->windMill setUp];
        [self->riverView1 setUp];
        [self->riverView2 setUp];
    });
    //
    
    //    [rippleWave1 setUp];
    //    [rippleWave2 setUp];
    //    [rippleWave3 setUp];
    
    [earthImage setBottomViewDelegate:self];
    [glassImage setBottomViewDelegate:self];
    [plantImage setBottomViewDelegate:self];
    [undergroundWaterImage setBottomViewDelegate:self];
    [waterInGlassImage setBottomViewDelegate:self];
    [waterImage setBottomViewDelegate:self];
    [cloudImage setBottomViewDelegate:self];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addSunAnimation:) name:UIApplicationWillEnterForegroundNotification object:nil];
    
}

/**
 *  This Method is responsible for hiding all popup when touch on screen.
 *
 *  @param gesture UIPanGestureRecognizer
 */

-(void)backGroundGestureAction:(UIPanGestureRecognizer*)gesture
{
    self->fishContaiminantView.alpha = 0;
    self->chlorinContaiminantView.alpha = 0;
    self->blueGreenContaiminantView.alpha = 0;
    self->redOrangeContaiminantView.alpha = 0;
    self->stoneContaiminantView.alpha = 0;
    
    [self->leftInfoView.layer removeAnimationForKey:kAnimationKey];
    [self->rightInfoView.layer removeAnimationForKey:kAnimationKey];
    self->leftInfoView.alpha=0;
    self->rightInfoView.alpha=0;
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
    
    NSLog(@"done playing");
}

- (void)audioPlayerDecodeErrorDidOccur:(AVAudioPlayer *)player error:(NSError *)error {
    
    NSLog(@"something didn't play so well");
}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
/**
 *  This Method is responsible for animation of sun,wind and water contaminanat bubble once hydrologial cycle has been completed.
 *
 *  @param sender
 */
- (void) addSunAnimation:(id)sender{
    
    [sunView rotationAnimation];
    [windMill setUp];
    
    if(fishContaiminantBubbleView.isAnimating)
        [fishContaiminantBubbleView startAnimation];
    
    if(chlorinContaiminantBubbleView.isAnimating)
        [chlorinContaiminantBubbleView startAnimation];
    
    if(blueGreenContaiminantBubbleView.isAnimating)
        [blueGreenContaiminantBubbleView startAnimation];
    
    if(redOrangeoContaiminantBubbleView.isAnimating)
        [redOrangeoContaiminantBubbleView startAnimation];
    
    if(stoneContaiminantBubbleView.isAnimating)
        [stoneContaiminantBubbleView startAnimation];
    
    [rippleWave1 setUp];
    [rippleWave2 setUp];
    [rippleWave3 setUp];
    
    [self->riverView1 setUp];
    [self->riverView2 setUp];
    
    [riverView1.layer setNeedsDisplay];
    [riverView2.layer setNeedsDisplay];
}

- (void) viewWillDisappear:(BOOL)animated{
    [_audioPlayer stop];
    [super viewWillDisappear:animated];
}

#pragma mark - sun view delegate
- (void) sunViewAnimationCompleted{
    [self firstCycle];
}

/**
 *  Evaporation, Transpiration and Condensation.
 */
- (void) firstCycle{
    
    [UIView animateWithDuration:5.0
                          delay:0.0
                        options:UIViewAnimationOptionTransitionCrossDissolve
                     animations:^{
                         self->evaporationBottomArrow.alpha = 1;
                     } completion:^(BOOL finished){
                         [self startCloudAnimation];
                     }];
    
    [UIView animateWithDuration:7.0
                          delay:0.0
                        options:UIViewAnimationOptionTransitionCrossDissolve
                     animations:^{
                         self->evaporation.alpha = 1;
                     } completion:NULL];
    
    [UIView animateWithDuration:10.0
                          delay:0.0
                        options:UIViewAnimationOptionTransitionCrossDissolve
                     animations:^{
                         self->evaporationMiddleArrow.alpha = 1;
                     } completion:NULL];
    
    [UIView animateWithDuration:10.0
                          delay:0.0
                        options:UIViewAnimationOptionTransitionCrossDissolve
                     animations:^{
                         self->evaporationTopArrow.alpha = 1;
                     } completion:NULL];
    
    [UIView animateWithDuration:10.0
                          delay:0.0
                        options:UIViewAnimationOptionTransitionCrossDissolve
                     animations:^{
                         self->transpirationBottomArrow.alpha = 1;
                     } completion:NULL];
    
    [UIView animateWithDuration:10.0
                          delay:0.0
                        options:UIViewAnimationOptionTransitionCrossDissolve
                     animations:^{
                         self->condensation.alpha = 1;
                     } completion:^(BOOL finished) {
                         //[self startCloudAnimation];
                     }];
    
    [UIView animateWithDuration:12.0
                          delay:0.0
                        options:UIViewAnimationOptionTransitionCrossDissolve
                     animations:^{
                         self->condensationTopArrow.alpha = 1;
                     } completion:NULL];
    
    
    
    [UIView animateWithDuration:14.0
                          delay:0.0
                        options:UIViewAnimationOptionTransitionCrossDissolve
                     animations:^{
                         self->transpiration.alpha = 1;
                     } completion:NULL];
    
}
/**
 *  Remove Evaporation,Condentation,Transpiration
 */

- (void) removeFirstCycle{
    [UIView animateWithDuration:6.0
                          delay:0.0
                        options:UIViewAnimationOptionTransitionCrossDissolve
                     animations:^{
                         self->evaporationBottomArrow.alpha = 0;
                     } completion:NULL];
    
    [UIView animateWithDuration:6.0
                          delay:0.0
                        options:UIViewAnimationOptionTransitionCrossDissolve
                     animations:^{
                         self->evaporation.alpha = 0;
                     } completion:NULL];
    
    [UIView animateWithDuration:6.0
                          delay:0.0
                        options:UIViewAnimationOptionTransitionCrossDissolve
                     animations:^{
                         self->evaporationMiddleArrow.alpha = 0;
                     } completion:^(BOOL finished) {
                         
                         [UIView animateWithDuration:6.0
                                               delay:0.0
                                             options:UIViewAnimationOptionTransitionCrossDissolve
                                          animations:^{
                                              self->evaporationTopArrow.alpha = 0;
                                          } completion:NULL];
                         
                         [UIView animateWithDuration:6.0
                                               delay:0.0
                                             options:UIViewAnimationOptionTransitionCrossDissolve
                                          animations:^{
                                              self->condensation.alpha = 0;
                                          } completion:NULL];
                         [UIView animateWithDuration:6.0
                                               delay:0.0
                                             options:UIViewAnimationOptionTransitionCrossDissolve
                                          animations:^{
                                              self->condensationTopArrow.alpha = 0;
                                          } completion:NULL];
                     }];
    
    
    
    [UIView animateWithDuration:6.0
                          delay:0.0
                        options:UIViewAnimationOptionTransitionCrossDissolve
                     animations:^{
                         self->transpirationBottomArrow.alpha = 0;
                     } completion:NULL];
    
    [UIView animateWithDuration:6.0
                          delay:0.0
                        options:UIViewAnimationOptionTransitionCrossDissolve
                     animations:^{
                         self->transpiration.alpha = 0;
                     } completion:NULL];
}

/**
 *  Cloud animation will start after appearance of condensation.
 * Now the evaporation, transpiration and condensation cycles will be removed.
 */
- (void) startCloudAnimation{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        if(!self->isCycleRepeat)
        {
            [self->cloudView setUp];
            [self->cloudView startAnimation];
            [self->cloudImage setNeedsLayout];
        }
        else
        {
            [NSTimer scheduledTimerWithTimeInterval:10.0 target:self selector:@selector(startRepeatRainCycle) userInfo:nil repeats:NO];
        }
    });
    
    NSTimer *timer = [NSTimer timerWithTimeInterval:3.0 target:self selector:@selector(startCloudAnimationTimer) userInfo:NULL repeats:NO];
    [timer fire];
    //    timer = nil;
}
-(void)startRepeatRainCycle
{
    [cloudView startRepeatCycle];
    
}

- (void) startCloudAnimationTimer{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        NSTimer *timer = [NSTimer timerWithTimeInterval:20.0 target:self selector:@selector(removeFirstCycle) userInfo:NULL repeats:NO];
        [timer fire];
    });
}

- (void) startRaining{
    
    NSTimer *timer = [NSTimer timerWithTimeInterval:5.0 target:self selector:@selector(startRainingTimer) userInfo:NULL repeats:NO];
    [timer fire];
    //    timer = nil;
}

- (void) startRainingTimer{
    dispatch_async(dispatch_get_main_queue(), ^{
        self->rainFall.alpha=1.0;
        [self->rainFall setupEmitter];
        [self->rainFall setupEmitterCells];
        [self->rainFall setNeedsDisplay];
        [UIView animateWithDuration:2.0
                              delay:0.0
                            options:UIViewAnimationOptionTransitionCrossDissolve
                         animations:^{
                             self->precipitationTopArrow.alpha = 1;
                         } completion:^(BOOL finished) {
                             [self stopRaining];
                         }];
        
        [UIView animateWithDuration:2.0
                              delay:0.0
                            options:UIViewAnimationOptionTransitionCrossDissolve
                         animations:^{
                             self->precipitation.alpha = 1;
                         } completion:^(BOOL finished) {
                         }];
    });
}

- (void) stopRaining{
    
    [NSTimer scheduledTimerWithTimeInterval:12.0 target:self selector:@selector(stopRainingTimer) userInfo:NULL repeats:NO];
    
}
/**
 *  Remove rain , Precipitation
 */
- (void) stopRainingTimer{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [UIView animateWithDuration:2.0
                              delay:0.0
                            options:UIViewAnimationOptionTransitionCrossDissolve
                         animations:^{
                             self->rainFall.alpha = 0;
                         } completion:^(BOOL finished) {
                             [self->rainFall stopRainFall];
                         }];
        
        
        
        [UIView animateWithDuration:2.0
                              delay:0.0
                            options:UIViewAnimationOptionTransitionCrossDissolve
                         animations:^{
                             self->precipitationTopArrow.alpha = 0;
                         } completion:^(BOOL finished) {
                             [self startSnowMeltAndSurfaceRunoff];
                         }];
        
        [UIView animateWithDuration:2.0
                              delay:0.0
                            options:UIViewAnimationOptionTransitionCrossDissolve
                         animations:^{
                             self->precipitation.alpha = 0;
                         } completion:^(BOOL finished) {
                         }];
        
        
        
    });
}

- (void) startSnowMeltAndSurfaceRunoff{
    
    [UIView animateWithDuration:2.0
                          delay:0.0
                        options:UIViewAnimationOptionTransitionCrossDissolve
                     animations:^{
                         self->snowmeltUpperArrow.alpha = 1;
                     } completion:NULL];
    
    [UIView animateWithDuration:2.0
                          delay:0.0
                        options:UIViewAnimationOptionTransitionCrossDissolve
                     animations:^{
                         self->snowmeltLowerArrow.alpha = 1;
                     } completion:NULL];
    
    [UIView animateWithDuration:2.0
                          delay:0.0
                        options:UIViewAnimationOptionTransitionCrossDissolve
                     animations:^{
                         self->snowmeltRunoff.alpha = 1;
                     } completion:NULL];
    
    [UIView animateWithDuration:2.0
                          delay:0.0
                        options:UIViewAnimationOptionTransitionCrossDissolve
                     animations:^{
                         self->surfaceRunOffArrow.alpha = 1;
                     } completion:NULL];
    
    [UIView animateWithDuration:2.0
                          delay:0.0
                        options:UIViewAnimationOptionTransitionCrossDissolve
                     animations:^{
                         self->surfaceRunOffBottomArrow.alpha = 1;
                     } completion:NULL];
    
    [UIView animateWithDuration:2.0
                          delay:0.0
                        options:UIViewAnimationOptionTransitionCrossDissolve
                     animations:^{
                         self->surfaceRunOff.alpha = 1;
                     } completion:^(BOOL finished) {
                         
                         [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(stopSnowMeltAndSurfaceRunoff) userInfo:NULL repeats:NO];
                         
                         if(!self->isCycleRepeat)
                         {
                             [self startSmokePollution];
                         }
                         else
                         {
                             [NSTimer scheduledTimerWithTimeInterval:10.0 target:self selector:@selector(startRepeatingCycle) userInfo:nil repeats:NO];
                         }
                     }];
    
}

- (void) stopSnowMeltAndSurfaceRunoff{
    
    [UIView animateWithDuration:2.0
                          delay:0.0
                        options:UIViewAnimationOptionTransitionCrossDissolve
                     animations:^{
                         self->snowmeltUpperArrow.alpha = 0;
                     } completion:NULL];
    
    [UIView animateWithDuration:2.0
                          delay:0.0
                        options:UIViewAnimationOptionTransitionCrossDissolve
                     animations:^{
                         self->snowmeltLowerArrow.alpha = 0;
                     } completion:NULL];
    
    [UIView animateWithDuration:2.0
                          delay:0.0
                        options:UIViewAnimationOptionTransitionCrossDissolve
                     animations:^{
                         self->snowmeltRunoff.alpha = 0;
                     } completion:NULL];
    
    [UIView animateWithDuration:2.0
                          delay:0.0
                        options:UIViewAnimationOptionTransitionCrossDissolve
                     animations:^{
                         self->surfaceRunOffArrow.alpha = 0;
                     } completion:NULL];
    
    [UIView animateWithDuration:2.0
                          delay:0.0
                        options:UIViewAnimationOptionTransitionCrossDissolve
                     animations:^{
                         self->surfaceRunOffBottomArrow.alpha = 0;
                     } completion:NULL];
    
    [UIView animateWithDuration:2.0
                          delay:0.0
                        options:UIViewAnimationOptionTransitionCrossDissolve
                     animations:^{
                         self->surfaceRunOff.alpha = 0;
                     } completion:NULL];
    
    
}

- (void) startSmokePollution{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self->rippleWave1 setHidden:NO];
        [self->rippleWave2 setHidden:NO];
        [self->rippleWave3 setHidden:NO];
        
        [self->rippleWave1 setUp];
        [self->rippleWave2 setUp];
        [self->rippleWave3 setUp];
        
        [self->smoke1 setUpDust];
        [self->smoke2 setUpDust];
        
        [self->riverView1 startAnimating];
        [self->riverView2 startAnimating];
        [self startShowingContaiminants];
    });
}

- (void) startShowingContaiminants{
    
    NSTimer *timer = [NSTimer timerWithTimeInterval:6.0 target:self selector:@selector(startShowingContaiminantsTimer) userInfo:NULL repeats:NO];
    [timer fire];
    //    timer = nil;
}

- (void) startShowingContaiminantsTimer{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        self->fishContaiminantBubbleView.alpha = 0;
        self->chlorinContaiminantBubbleView.alpha=0;
        self->blueGreenContaiminantBubbleView.alpha = 0;
        self->redOrangeoContaiminantBubbleView.alpha = 0;
        self->stoneContaiminantBubbleView.alpha = 0;
        
        self->fishContaiminantBubbleView.hidden = NO;
        self->chlorinContaiminantBubbleView.hidden=NO;
        self->blueGreenContaiminantBubbleView.hidden = NO;
        self->redOrangeoContaiminantBubbleView.hidden = NO;
        self->stoneContaiminantBubbleView.hidden = NO;
        
        [UIView animateWithDuration:2.0
                              delay:0.0
                            options:UIViewAnimationOptionTransitionCrossDissolve
                         animations:^{
                             [self->fishContaiminantBubbleView animateAlpha:1.0f];
                             [self->chlorinContaiminantBubbleView animateAlpha:1.0f];
                             [self->blueGreenContaiminantBubbleView animateAlpha:1.0f];
                             [self->redOrangeoContaiminantBubbleView animateAlpha:1.0f];
                             [self->stoneContaiminantBubbleView animateAlpha:1.0f];
                             
                         } completion:^(BOOL finished) {
                             self->fishContaiminantBubbleView.contaiminantDelegate = self;
                             self->chlorinContaiminantBubbleView.contaiminantDelegate=self;
                             self->blueGreenContaiminantBubbleView.contaiminantDelegate = self;
                             self->redOrangeoContaiminantBubbleView.contaiminantDelegate = self;
                             self->stoneContaiminantBubbleView.contaiminantDelegate = self;
                             
                         }];
        
        
        
        [NSTimer scheduledTimerWithTimeInterval:12.0 target:self selector:@selector(startRepeatingCycle) userInfo:nil repeats:NO];
        
    });
}
-(void)startRepeatingCycle
{
    
    isCycleRepeat=YES;
    [UIView animateWithDuration:2.0 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
        self->evaporationBottomArrow.alpha = 1;
        self->evaporation.alpha = 1;
        self->evaporationMiddleArrow.alpha = 1;
        self->evaporationTopArrow.alpha = 1;
        self->condensation.alpha = 1;
        self->condensationTopArrow.alpha = 1;
        self->transpiration.alpha = 1;
        self->transpirationBottomArrow.alpha = 1;
        self->precipitationTopArrow.alpha = 1;
        self->precipitation.alpha = 1;
        self->snowmeltUpperArrow.alpha = 1;
        self->snowmeltLowerArrow.alpha = 1;
        self->snowmeltRunoff.alpha = 1;
        self->surfaceRunOffArrow.alpha = 1;
        self->surfaceRunOffBottomArrow.alpha = 1;
        self->surfaceRunOff.alpha = 1;
        
    } completion:^(BOOL finished) {
        
        self->playStopButton.hidden = NO;
        //        [UIView animateWithDuration:2.0 delay:5.0 options:UIViewAnimationOptionCurveLinear animations:^{
        //
        //            evaporationBottomArrow.alpha = 0;
        //            evaporation.alpha = 0;
        //            evaporationMiddleArrow.alpha = 0;
        //            evaporationTopArrow.alpha = 0;
        //            condensation.alpha = 0;
        //            condensationTopArrow.alpha = 0;
        //            transpirationBottomArrow.alpha = 0;
        //            transpiration.alpha = 0;
        //            rainFall.alpha = 0;
        //            precipitationTopArrow.alpha = 0;
        //            precipitation.alpha = 0;
        //            snowwmeltUpperArrow.alpha=0;
        //            snowwmeltLowerArrow.alpha = 0;
        //            snowwmeltRunoff.alpha = 0;
        //            surfaceRunOffArrow.alpha = 0;
        //            surfaceRunOffBottomArrow.alpha = 0;
        //            surfaceRunOff.alpha = 0;
        //
        //          } completion:^(BOOL finished) {
        //
        //              [self firstCycle];
        //        }];
        
    }];
}

- (IBAction)playStopAction:(id)sender{
    playStopButton.hidden = YES;
    [UIView animateWithDuration:3.0 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
        
        self->evaporationBottomArrow.alpha = 0;
        self->evaporation.alpha = 0;
        self->evaporationMiddleArrow.alpha = 0;
        self->evaporationTopArrow.alpha = 0;
        self->condensation.alpha = 0;
        self->condensationTopArrow.alpha = 0;
        self->transpirationBottomArrow.alpha = 0;
        self->transpiration.alpha = 0;
        self->rainFall.alpha = 0;
        self->precipitationTopArrow.alpha = 0;
        self->precipitation.alpha = 0;
        self->snowmeltUpperArrow.alpha=0;
        self->snowmeltLowerArrow.alpha = 0;
        self->snowmeltRunoff.alpha = 0;
        self->surfaceRunOffArrow.alpha = 0;
        self->surfaceRunOffBottomArrow.alpha = 0;
        self->surfaceRunOff.alpha = 0;
        
        self->fishContaiminantView.alpha = 0;
        self->chlorinContaiminantView.alpha = 0;
        self->blueGreenContaiminantView.alpha = 0;
        self->redOrangeContaiminantView.alpha = 0;
        self->stoneContaiminantView.alpha = 0;
        
        [self->leftInfoView.layer removeAnimationForKey:kAnimationKey];
        [self->rightInfoView.layer removeAnimationForKey:kAnimationKey];
        self->leftInfoView.alpha=0;
        self->rightInfoView.alpha=0;

        
    } completion:^(BOOL finished) {
                
        [self firstCycle];
    }];
}

/**
 *  This Method is responsible for show/hide bottom bar views.
 *
 *  @param index : view tag number
 */
- (void) didSelectViewAtIndex:(NSInteger)index{
    
    switch (index) {
        case 0:
        {
            [waterImage setDisabled];
            [glassImage setDisabled];
            [undergroundWaterImage setDisabled];
            [waterInGlassImage setDisabled];
            [plantImage setDisabled];
            [cloudImage setDisabled];
        }
            break;
            
        case 1:
        {
            [earthImage setDisabled];
            [glassImage setDisabled];
            [undergroundWaterImage setDisabled];
            [waterInGlassImage setDisabled];
            [plantImage setDisabled];
            [cloudImage setDisabled];
        }
            break;
            
        case 2:
        {
            [earthImage setDisabled];
            [waterImage setDisabled];
            [undergroundWaterImage setDisabled];
            [waterInGlassImage setDisabled];
            [plantImage setDisabled];
            [cloudImage setDisabled];
        }
            break;
            
        case 3:
        {
            [earthImage setDisabled];
            [waterImage setDisabled];
            [glassImage setDisabled];
            [waterInGlassImage setDisabled];
            [plantImage setDisabled];
            [cloudImage setDisabled];
        }
            break;
            
        case 4:
        {
            [earthImage setDisabled];
            [waterImage setDisabled];
            [glassImage setDisabled];
            [undergroundWaterImage setDisabled];
            [plantImage setDisabled];
            [cloudImage setDisabled];
        }
            break;
            
        case 5:
        {
            [earthImage setDisabled];
            [waterImage setDisabled];
            [glassImage setDisabled];
            [undergroundWaterImage setDisabled];
            [waterInGlassImage setDisabled];
            [cloudImage setDisabled];
        }
            break;
            
        case 6:
        {
            [earthImage setDisabled];
            [waterImage setDisabled];
            [glassImage setDisabled];
            [undergroundWaterImage setDisabled];
            [waterInGlassImage setDisabled];
            [plantImage setDisabled];
        }
            break;
            
        default:
            break;
    }
}

- (IBAction)viewRootScreen:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - Gesture Actions

-(void) evaporationTopArrowGestureAction:(UITapGestureRecognizer*)tapGesture
{
    ANIMATE_VIEW(self->evaporation);
    ANIMATE_VIEW(self->condensation);
}

-(void) evaporationGestureAction:(UITapGestureRecognizer*)tapGesture
{
    self->fishContaiminantView.alpha = 0;
    self->chlorinContaiminantView.alpha = 0;
    self->blueGreenContaiminantView.alpha = 0;
    self->redOrangeContaiminantView.alpha = 0;
    self->stoneContaiminantView.alpha = 0;
    
    NSString *text = [NSString stringWithFormat:@"%@\n%@", dataSource[0][@"name"], dataSource[0][@"description"]];
    leftInfoLabel.text=text;
    [UIView animateWithDuration:2.0
                          delay:0.0
                        options:UIViewAnimationOptionTransitionCrossDissolve
                     animations:^{
                         self->leftInfoView.alpha = 1;
                     } completion:^(BOOL finished) {
                         [UIView animateWithDuration:2.0
                                               delay:4.0
                                             options:UIViewAnimationOptionTransitionCrossDissolve
                                          animations:^{
                                              self->leftInfoView.alpha = 0;
                                          } completion:NULL];
                         
                     }];
}

-(void) evaporationMiddleArrowGestureAction:(UITapGestureRecognizer*)tapGesture
{
    ANIMATE_VIEW(self->evaporation);
}

-(void) evaporationBottomArrowGestureAction:(UITapGestureRecognizer*)tapGesture
{
    ANIMATE_VIEW(self->evaporation);
}

-(void) condensationGestureAction:(UITapGestureRecognizer*)tapGesture
{
    self->fishContaiminantView.alpha = 0;
    self->chlorinContaiminantView.alpha = 0;
    self->blueGreenContaiminantView.alpha = 0;
    self->redOrangeContaiminantView.alpha = 0;
    self->stoneContaiminantView.alpha = 0;
    
    NSString *text = [NSString stringWithFormat:@"%@\n%@", dataSource[1][@"name"], dataSource[1][@"description"]];
    leftInfoLabel.text=text;
    [UIView animateWithDuration:2.0
                          delay:0.0
                        options:UIViewAnimationOptionTransitionCrossDissolve
                     animations:^{
                         self->leftInfoView.alpha = 1;
                     } completion:^(BOOL finished) {
                         [UIView animateWithDuration:2.0
                                               delay:10.0
                                             options:UIViewAnimationOptionTransitionCrossDissolve
                                          animations:^{
                                              self->leftInfoView.alpha = 0;
                                          } completion:NULL];
                         
                     }];
}

-(void) precipitationTopArrowGestureAction:(UITapGestureRecognizer*)tapGesture
{
    ANIMATE_VIEW(self->precipitation);
}

-(void) precipitationGestureAction:(UITapGestureRecognizer*)tapGesture
{
    self->fishContaiminantView.alpha = 0;
    self->chlorinContaiminantView.alpha = 0;
    self->blueGreenContaiminantView.alpha = 0;
    self->redOrangeContaiminantView.alpha = 0;
    self->stoneContaiminantView.alpha = 0;
    
    NSString *text = [NSString stringWithFormat:@"%@\n%@", dataSource[3][@"name"], dataSource[3][@"description"]];
    rightInfoLabel.text=text;
    [UIView animateWithDuration:2.0
                          delay:0.0
                        options:UIViewAnimationOptionTransitionCrossDissolve
                     animations:^{
                         self->rightInfoView.alpha = 1;
                     } completion:^(BOOL finished) {
                         [UIView animateWithDuration:2.0
                                               delay:10.0
                                             options:UIViewAnimationOptionTransitionCrossDissolve
                                          animations:^{
                                              self->rightInfoView.alpha = 0;
                                          } completion:NULL];
                         
                     }];
}

-(void) surfaceRunOffGestureAction:(UITapGestureRecognizer*)tapGesture
{
    self->fishContaiminantView.alpha = 0;
    self->chlorinContaiminantView.alpha = 0;
    self->blueGreenContaiminantView.alpha = 0;
    self->redOrangeContaiminantView.alpha = 0;
    self->stoneContaiminantView.alpha = 0;
    
    NSString *text = [NSString stringWithFormat:@"%@\n%@", dataSource[4][@"name"], dataSource[4][@"description"]];
    rightInfoLabel.text=text;
    
    [UIView animateWithDuration:2.0
                          delay:0.0
                        options:UIViewAnimationOptionTransitionCrossDissolve
                     animations:^{
                         self->rightInfoView.alpha = 1;
                     } completion:^(BOOL finished) {
                         [UIView animateWithDuration:2.0
                                               delay:10.0
                                             options:UIViewAnimationOptionTransitionCrossDissolve
                                          animations:^{
                                              self->rightInfoView.alpha = 0;
                                          } completion:NULL];
                         
                     }];
    
    
}

-(void) surfaceRunOffBottomArrowGestureAction:(UITapGestureRecognizer*)tapGesture
{
    ANIMATE_VIEW(self->surfaceRunOff);
}

-(void) surfaceRunOffArrowGestureAction:(UITapGestureRecognizer*)tapGesture
{
    ANIMATE_VIEW(self->surfaceRunOff);
}

-(void) transpirationGestureAction:(UITapGestureRecognizer*)tapGesture
{
    self->fishContaiminantView.alpha = 0;
    self->chlorinContaiminantView.alpha = 0;
    self->blueGreenContaiminantView.alpha = 0;
    self->redOrangeContaiminantView.alpha = 0;
    self->stoneContaiminantView.alpha = 0;
    
    NSString *text = [NSString stringWithFormat:@"%@\n%@", dataSource[2][@"name"], dataSource[2][@"description"]];
    rightInfoLabel.text=text;
    [UIView animateWithDuration:2.0
                          delay:0.0
                        options:UIViewAnimationOptionTransitionCrossDissolve
                     animations:^{
                         self->rightInfoView.alpha = 1;
                     } completion:^(BOOL finished) {
                         [UIView animateWithDuration:2.0
                                               delay:10.0
                                             options:UIViewAnimationOptionTransitionCrossDissolve
                                          animations:^{
                                              self->rightInfoView.alpha = 0;
                                          } completion:NULL];
                         
                     }];
    
}

-(void) transpirationBottomArrowGestureAction:(UITapGestureRecognizer*)tapGesture
{
    ANIMATE_VIEW(self->transpiration);
}

-(void) snowwmeltRunoffGestureAction:(UITapGestureRecognizer*)tapGesture
{
    self->fishContaiminantView.alpha = 0;
    self->chlorinContaiminantView.alpha = 0;
    self->blueGreenContaiminantView.alpha = 0;
    self->redOrangeContaiminantView.alpha = 0;
    self->stoneContaiminantView.alpha = 0;
    
    NSString *text = [NSString stringWithFormat:@"%@\n%@", dataSource[5][@"name"], dataSource[5][@"description"]];
    leftInfoLabel.text=text;
    [UIView animateWithDuration:2.0
                          delay:0.0
                        options:UIViewAnimationOptionTransitionCrossDissolve
                     animations:^{
                         self->leftInfoView.alpha = 1;
                     } completion:^(BOOL finished) {
                         [UIView animateWithDuration:2.0
                                               delay:10.0
                                             options:UIViewAnimationOptionTransitionCrossDissolve
                                          animations:^{
                                              self->leftInfoView.alpha = 0;
                                          } completion:NULL];
                         
                     }];
}

-(void) snowwmeltLowerArrowGestureAction:(UITapGestureRecognizer*)tapGesture
{
    ANIMATE_VIEW(self->snowmeltRunoff);
}

-(void) snowwmeltUpperArrowGestureAction:(UITapGestureRecognizer*)tapGesture
{
    ANIMATE_VIEW(self->snowmeltRunoff);
}

#pragma mark - Show/Hide popup
/**
 *  This Method are responsiable for show/hide multiple popup.
 */

-(void)hideLeftRightView
{
  
//   NSLog(@"%@",[leftInfoView.layer animationKeys]);
    
    [self->leftInfoView.layer removeAnimationForKey:kAnimationKey];
    [self->rightInfoView.layer removeAnimationForKey:kAnimationKey];
    
        [UIView animateWithDuration:0.0
                              delay:0.0
                            options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionTransitionCrossDissolve
                         animations:^{
                             self->leftInfoView.alpha = 0;
                             self->rightInfoView.alpha = 0;
                         } completion:^(BOOL finished) {
                             [UIView animateWithDuration:0.0
                                                   delay:0.0
                                                 options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionTransitionCrossDissolve
                                              animations:^{
                                                  self->leftInfoView.alpha = 0;
                                                  self->rightInfoView.alpha = 0;
                                              } completion:NULL];
                             
                         }];
   }


- (void) showContaiminantsForType:(TMContaiminantType)contaiminantType{
    
 
    [self hideLeftRightView];
    
    //-----manoj --------- update on 18th march
    
    self->fishContaiminantView.alpha = 0;
    self->chlorinContaiminantView.alpha = 0;
    self->blueGreenContaiminantView.alpha = 0;
    self->redOrangeContaiminantView.alpha = 0;
    self->stoneContaiminantView.alpha = 0;
    
    [UIView animateKeyframesWithDuration:1.0f
                                   delay:0.0f
                                 options:UIViewKeyframeAnimationOptionCalculationModeLinear
                              animations:^{
                                
                               
                              } completion:^(BOOL finished) {
                                  switch (contaiminantType) {
                                      case TMContaiminantTypeFish:{
                                          [UIView animateKeyframesWithDuration:1.0f
                                                                         delay:0.0f
                                                                       options:UIViewKeyframeAnimationOptionCalculationModeLinear
                                                                    animations:^{
                                                                        self->fishContaiminantView.alpha = 1;
                                                                        self->chlorinContaiminantView.alpha = 0;
                                                                        self->blueGreenContaiminantView.alpha = 0;
                                                                        self->redOrangeContaiminantView.alpha = 0;
                                                                        self->stoneContaiminantView.alpha = 0;
                                                                        
                                                                    } completion:NULL];
                                      }
                                          
                                          break;
                                          
                                      case TMContaiminantTypeBlueGreen:{
                                          [UIView animateKeyframesWithDuration:1.0f
                                                                         delay:0.0f
                                                                       options:UIViewKeyframeAnimationOptionCalculationModeLinear
                                                                    animations:^{
                                                                        self->blueGreenContaiminantView.alpha = 1;
                                                          
                                                                        self->fishContaiminantView.alpha = 0;
                                                                        self->chlorinContaiminantView.alpha = 0;
                                                                        self->redOrangeContaiminantView.alpha = 0;
                                                                        self->stoneContaiminantView.alpha = 0;
                                                                        
                                                                    } completion:NULL];
                                      }
                                          
                                          break;
                                          
                                      case TMContaiminantTypeRedOrange:{
                                          [UIView animateKeyframesWithDuration:1.0f
                                                                         delay:0.0f
                                                                       options:UIViewKeyframeAnimationOptionCalculationModeLinear
                                                                    animations:^{
                                                                        self->redOrangeContaiminantView.alpha = 1;
                                                   
                                                                        self->fishContaiminantView.alpha = 0;
                                                                        self->chlorinContaiminantView.alpha = 0;
                                                                        self->blueGreenContaiminantView.alpha = 0;
                                                                        self->stoneContaiminantView.alpha = 0;
                                                                        
                                                                    } completion:NULL];
                                      }
                                          
                                          break;
                                          
                                      case TMContaiminantTypeStone:{
                                          [UIView animateKeyframesWithDuration:1.0f
                                                                         delay:0.0f
                                                                       options:UIViewKeyframeAnimationOptionCalculationModeLinear
                                                                    animations:^{
                                                                        self->stoneContaiminantView.alpha = 1;
                 
                                                                        self->fishContaiminantView.alpha = 0;
                                                                        self->chlorinContaiminantView.alpha = 0;
                                                                        self->blueGreenContaiminantView.alpha = 0;
                                                                        self->redOrangeContaiminantView.alpha = 0;
                                                                        
                                                                    } completion:NULL];
                                      }
                                          
                                          break;
                                      case TMContaiminantTypeChlorin:{
                                          [UIView animateKeyframesWithDuration:1.0f
                                                                         delay:0.0f
                                                                       options:UIViewKeyframeAnimationOptionCalculationModeLinear
                                                                    animations:^{
                                                                        self->chlorinContaiminantView.alpha = 1;
                                                     
                                                                        self->fishContaiminantView.alpha = 0;
                                                                        self->blueGreenContaiminantView.alpha = 0;
                                                                        self->redOrangeContaiminantView.alpha = 0;
                                                                        self->stoneContaiminantView.alpha = 0;
                                                                        
                                                                    } completion:NULL];
                                      }
                                          
                                          break;
                                          
                                      default:
                                          break;
                                  }
                              }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
