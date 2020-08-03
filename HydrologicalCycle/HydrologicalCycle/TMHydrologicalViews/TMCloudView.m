//
//  TMCloudView.m
//  HydrologicalCycle
//
//  Created by Ankur Adhikari on 27/02/14.
//  Copyright (c) 2014 HydrologicalCycle. All rights reserved.
//

#import "TMCloudView.h"
#import "TMFrameConstants.h"

@interface TMCloudView (){
    UIImageView *cloudImage1;
    UIImageView *cloudImage2;
    UIImageView *cloudImage3;
    UIImageView *cloudImage4;
    UIImageView *cloudImage5;
    UIImageView *cloudImage6;
    UIImageView *cloudImage7;
    UIImageView *cloudImage8;
    UIImageView *cloudImage9;
    UIImageView *cloudImage10;
    
    
    UIImageView *dustCloudImage1;
    UIImageView *dustCloudImage2;
    UIImageView *dustCloudImage3;
    UIImageView *dustCloudImage4;
    UIImageView *dustCloudImage5;
    UIImageView *dustCloudImage6;
    UIImageView *dustCloudImage7;
    UIImageView *dustCloudImage8;
    UIImageView *dustCloudImage9;
    UIImageView *dustCloudImage10;
    
    UIImageView *mainCloudImage1;
    UIImageView *mainDustCloudImage1;
    
    UIImageView *mainCloudImage2;
    UIImageView *mainDustCloudImage2;
    
}

@end

@implementation TMCloudView

- (void) setUp{
    
    cloudImage1 = [[UIImageView alloc] initWithFrame:kCloud1Frame];
    cloudImage2 = [[UIImageView alloc] initWithFrame:kCloud2Frame];
    cloudImage3 = [[UIImageView alloc] initWithFrame:kCloud3Frame];
    cloudImage4 = [[UIImageView alloc] initWithFrame:kCloud4Frame];
    cloudImage5 = [[UIImageView alloc] initWithFrame:kCloud5Frame];
    cloudImage6 = [[UIImageView alloc] initWithFrame:kCloud6Frame];
    cloudImage7 = [[UIImageView alloc] initWithFrame:kCloud7Frame];
    cloudImage8 = [[UIImageView alloc] initWithFrame:kCloud8Frame];
    cloudImage9 = [[UIImageView alloc] initWithFrame:kCloud9Frame];
    cloudImage10 = [[UIImageView alloc] initWithFrame:kCloud10Frame];
    mainCloudImage1 = [[UIImageView alloc] initWithFrame:kCloudFrame];
    mainCloudImage2 = [[UIImageView alloc] initWithFrame:kCloudFrame1];
    
    dustCloudImage1 = [[UIImageView alloc] initWithFrame:kCloud1Frame];
    dustCloudImage2 = [[UIImageView alloc] initWithFrame:kCloud2Frame];
    dustCloudImage3 = [[UIImageView alloc] initWithFrame:kCloud3Frame];
    dustCloudImage4 = [[UIImageView alloc] initWithFrame:kCloud4Frame];
    dustCloudImage5 = [[UIImageView alloc] initWithFrame:kCloud5Frame];
    dustCloudImage6 = [[UIImageView alloc] initWithFrame:kCloud6Frame];
    dustCloudImage7 = [[UIImageView alloc] initWithFrame:kCloud7Frame];
    dustCloudImage8 = [[UIImageView alloc] initWithFrame:kCloud8Frame];
    dustCloudImage9 = [[UIImageView alloc] initWithFrame:kCloud9Frame];
    dustCloudImage10 = [[UIImageView alloc] initWithFrame:kCloud10Frame];
    mainDustCloudImage1 = [[UIImageView alloc] initWithFrame:kCloudFrame];
    mainDustCloudImage2 = [[UIImageView alloc] initWithFrame:kCloudFrame1];
    
    mainCloudImage1.image = [UIImage imageNamed:@"cloud1"];
    mainCloudImage2.image = [UIImage imageNamed:@"cloud3"];
    cloudImage1.image = [UIImage imageNamed:@"cloud1"];
    cloudImage2.image = [UIImage imageNamed:@"cloud2"];
    cloudImage3.image = [UIImage imageNamed:@"cloud3"];
    cloudImage4.image = [UIImage imageNamed:@"cloud4"];
    cloudImage5.image = [UIImage imageNamed:@"cloud5"];
    cloudImage6.image = [UIImage imageNamed:@"cloud6"];
    cloudImage7.image = [UIImage imageNamed:@"cloud7"];
    cloudImage8.image = [UIImage imageNamed:@"cloud8"];
    cloudImage9.image = [UIImage imageNamed:@"cloud9"];
    cloudImage10.image = [UIImage imageNamed:@"cloud10"];
    
    mainDustCloudImage1.image = [UIImage imageNamed:@"cloud1"];
    mainDustCloudImage2.image = [UIImage imageNamed:@"cloud3"];
    dustCloudImage1.image = [UIImage imageNamed:@"cloud1"];
    dustCloudImage2.image = [UIImage imageNamed:@"cloud2"];
    dustCloudImage3.image = [UIImage imageNamed:@"cloud3"];
    dustCloudImage4.image = [UIImage imageNamed:@"cloud4"];
    dustCloudImage5.image = [UIImage imageNamed:@"cloud5"];
    dustCloudImage6.image = [UIImage imageNamed:@"cloud6"];
    dustCloudImage7.image = [UIImage imageNamed:@"cloud7"];
    dustCloudImage8.image = [UIImage imageNamed:@"cloud8"];
    dustCloudImage9.image = [UIImage imageNamed:@"cloud9"];
    dustCloudImage10.image = [UIImage imageNamed:@"cloud10"];
    
    mainDustCloudImage1.alpha = 0;
    mainDustCloudImage2.alpha = 0;
    
    [self addSubview:cloudImage1];
    [self addSubview:cloudImage2];
    [self addSubview:cloudImage3];
    [self addSubview:cloudImage4];
    [self addSubview:cloudImage5];
    [self addSubview:cloudImage6];
    [self addSubview:cloudImage7];
    [self addSubview:cloudImage8];
    [self addSubview:cloudImage9];
    [self addSubview:cloudImage10];
    [self addSubview:mainCloudImage1];
    [self addSubview:mainCloudImage2];
    
    [self addSubview:dustCloudImage1];
    [self addSubview:dustCloudImage2];
    [self addSubview:dustCloudImage3];
    [self addSubview:dustCloudImage4];
    [self addSubview:dustCloudImage5];
    [self addSubview:dustCloudImage6];
    [self addSubview:dustCloudImage7];
    [self addSubview:dustCloudImage8];
    [self addSubview:dustCloudImage9];
    [self addSubview:dustCloudImage10];
    [self addSubview:mainDustCloudImage1];
    [self addSubview:mainDustCloudImage2];
}

- (void) animateCloud:(UIImageView*)cloud withFrame:(CGRect)cloudFrame withDuration:(NSTimeInterval)duration{
    
    [UIView animateKeyframesWithDuration:duration
                                   delay:0
                                 options:UIViewKeyframeAnimationOptionRepeat
                              animations:^{
                                  cloud.frame = CGRectZero;
                              }
                              completion:^(BOOL finished) {
                                  cloud.frame = cloudFrame;
                              }];
}
-(void)startRepeatCycle
{
   [self.cloudDelegate startRaining];
    
}
- (void) startAnimation{
    
    [self animateCloud:cloudImage1 withFrame:kCloud1Frame withDuration:150];
    [self animateCloud:cloudImage2 withFrame:kCloud2Frame withDuration:120];
    [self animateCloud:cloudImage3 withFrame:kCloud3Frame withDuration:150];
    [self animateCloud:cloudImage4 withFrame:kCloud4Frame withDuration:180];
    [self animateCloud:cloudImage5 withFrame:kCloud5Frame withDuration:120];
    [self animateCloud:cloudImage6 withFrame:kCloud6Frame withDuration:150];
    [self animateCloud:cloudImage7 withFrame:kCloud7Frame withDuration:180];
    [self animateCloud:cloudImage8 withFrame:kCloud8Frame withDuration:120];
    [self animateCloud:cloudImage9 withFrame:kCloud9Frame withDuration:150];
    [self animateCloud:cloudImage10 withFrame:kCloud10Frame withDuration:180];
    
    [self animateCloud:dustCloudImage1 withFrame:kCloud1Frame withDuration:150];
    [self animateCloud:dustCloudImage2 withFrame:kCloud2Frame withDuration:120];
    [self animateCloud:dustCloudImage3 withFrame:kCloud3Frame withDuration:150];
    [self animateCloud:dustCloudImage4 withFrame:kCloud4Frame withDuration:180];
    [self animateCloud:dustCloudImage5 withFrame:kCloud5Frame withDuration:120];
    [self animateCloud:dustCloudImage6 withFrame:kCloud6Frame withDuration:150];
    [self animateCloud:dustCloudImage7 withFrame:kCloud7Frame withDuration:180];
    [self animateCloud:dustCloudImage8 withFrame:kCloud8Frame withDuration:120];
    [self animateCloud:dustCloudImage9 withFrame:kCloud9Frame withDuration:150];
    [self animateCloud:dustCloudImage10 withFrame:kCloud10Frame withDuration:180];
    
    [UIView animateKeyframesWithDuration:20
                                   delay:0
                                 options:UIViewKeyframeAnimationOptionOverrideInheritedDuration
                              animations:^{
                                  CGPoint centerPoint = self->mainDustCloudImage1.center;
                                  centerPoint.x = 700;
                                  self->mainCloudImage1.center = centerPoint;
                                  self->mainDustCloudImage1.center = centerPoint;
                                  self->mainDustCloudImage1.alpha = 1;
                              }
                              completion:^(BOOL finished) {
                                  
                              }];
    
    [UIView animateKeyframesWithDuration:20
                                   delay:0
                                 options:UIViewKeyframeAnimationOptionOverrideInheritedDuration
                              animations:^{
                                  CGPoint centerPoint = self->mainDustCloudImage2.center;
                                  centerPoint.x = 300;
                                  self->mainCloudImage2.center = centerPoint;
                                  self->mainDustCloudImage2.center = centerPoint;
                                  self->mainDustCloudImage2.alpha = 1;
                              }
                              completion:^(BOOL finished) {
                                  [self.cloudDelegate startRaining];
                              }];
    
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
