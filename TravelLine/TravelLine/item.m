//
//  item.m
//  TravelLine
//
//  Created by Leonardo Geus on 17/04/15.
//  Copyright (c) 2015 Leonardo Geus. All rights reserved.
//

#import "item.h"

@implementation item

+(id)initComDicionario:(NSDictionary *)dict {
    item *novoItem = [[self alloc]init];
    novoItem.nome = dict[@"nome"];
    novoItem.capa = dict[@"capa"];
    novoItem.data = dict[@"data"];
    novoItem.tipo = dict[@"tipo"];
    novoItem.imagem = dict[@"imagem"];
    novoItem.descricao = dict[@"descricao"];
    novoItem.label = dict[@"label"];
    novoItem.local= dict[@"local"];
    
    return novoItem;
}

@end
