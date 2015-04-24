//
//  DataManager.h
//  TravelLine
//
//  Created by Leonardo Geus on 17/04/15.
//  Copyright (c) 2015 Leonardo Geus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataManager : NSObject

@property NSMutableDictionary *dict,*myData;;



+(id)sharedManager;
-(id)init;



@property NSMutableDictionary *dados;
@property NSInteger *indiceFoto;



@end
