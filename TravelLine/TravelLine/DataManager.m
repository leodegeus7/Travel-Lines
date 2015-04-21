//
//  DataManager.m
//  TravelLine
//
//  Created by Leonardo Geus on 17/04/15.
//  Copyright (c) 2015 Leonardo Geus. All rights reserved.
//

#import "DataManager.h"

@implementation DataManager

+(id)sharedManager
{
    
    static DataManager *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc]init];
    });
    
    return sharedMyManager;
}

-(id)init
{
    self = [super init];
    if (self) {
        _dados= [[NSMutableDictionary alloc]init];
    }
    return self;
    
    
}




@end
