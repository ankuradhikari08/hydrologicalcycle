//
//  MacroUtilities.h
//  HydrologicalCycle
//
//  Created by Ankur Adhikari on 12/03/14.
//  Copyright (c) 2014 HydrologicalCycle. All rights reserved.
//
#import "AppDelegate.h"


#define appDelegate ((AppDelegate*)[[UIApplication sharedApplication] delegate])

#define kLocalized(key) NSLocalizedStringFromTableInBundle(key, @"Localizable", [NSBundle mainBundle], nil)

#define kDefineSingleton(className) \
+ (id) sharedInstance;

#define kCreateSingleton(className) \
/* initialize sharedManager as nil (first call only) */ \
__strong static id sharedManager = nil; \
static dispatch_queue_t serialQueue; \
\
+ (id) sharedInstance \
{ /* structure used to test whether the block has completed or not */\
    static dispatch_once_t onceQueue; \
    dispatch_once(&onceQueue, ^{ \
        sharedManager = [[self alloc] init]; \
    }); \
    return sharedManager; \
} \
\
+ (id)allocWithZone:(NSZone *)zone { \
    static dispatch_once_t onceQueue; \
    \
    dispatch_once(&onceQueue, ^{ \
        serialQueue = dispatch_queue_create("com.hd", NULL); \
        if (sharedManager == nil) { \
            sharedManager = [super allocWithZone:zone]; \
        } \
    }); \
    \
    return sharedManager;\
} \
\
- (id)init {\
    id __block obj;\
    \
    dispatch_sync(serialQueue, ^{\
        obj = [super init];\
        if (obj) {\
        \
        }\
    });\
    \
    self = obj;\
    return self;\
} 

