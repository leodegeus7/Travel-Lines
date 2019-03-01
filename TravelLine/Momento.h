//
//  Momento.h
//  TravelLine
//
//  Created by Leonardo Geus on 20/04/15.
//  Copyright (c) 2015 Leonardo Geus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Viagem;

@interface Momento : NSManagedObject

@property (nonatomic, retain) NSString * tipo;
@property (nonatomic, retain) NSString * imagem;
@property (nonatomic, retain) NSString * descricao;
@property (nonatomic, retain) NSString * texto;
@property (nonatomic, retain) NSString * geo;
@property (nonatomic, retain) Viagem *info;

@end
