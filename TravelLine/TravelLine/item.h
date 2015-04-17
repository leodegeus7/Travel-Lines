//
//  item.h
//  TravelLine
//
//  Created by Leonardo Geus on 17/04/15.
//  Copyright (c) 2015 Leonardo Geus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface item : NSObject


@property NSString *nome, *capa, *data, *imagem, *descricao, *label, *local, *tipo;

+(id)initComDicionario:(NSDictionary *)dict;


@end
