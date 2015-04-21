//
//  Viagem.h
//  TravelLine
//
//  Created by Leonardo Geus on 20/04/15.
//  Copyright (c) 2015 Leonardo Geus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Momento;

@interface Viagem : NSManagedObject

@property (nonatomic, retain) NSString * nome;
@property (nonatomic, retain) NSString * capa;
@property (nonatomic, retain) Momento *details;

@end
