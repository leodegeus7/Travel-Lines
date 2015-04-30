//
//  AppDelegate.h
//  TravelLine
//
//  Created by Leonardo Geus on 16/04/15.
//  Copyright (c) 2015 Leonardo Geus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iCloud.h"
#import "iCloudDocument.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate,iCloudDelegate>

@property (strong, nonatomic) UIWindow *window;
@property NSMutableDictionary *myData;

@end

