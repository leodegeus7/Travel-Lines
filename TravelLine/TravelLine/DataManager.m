//
//  DataManager.m
//  TravelLine
//
//  Created by Leonardo Geus on 17/04/15.
//  Copyright (c) 2015 Leonardo Geus. All rights reserved.
//

#import "DataManager.h"

@implementation DataManager

+(id)getDataManager {
    static DataManager *dm = nil;
    if (dm == nil) {
        dm = [[self alloc]init];
    }
    return dm;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _dict = [[NSMutableDictionary alloc]init];
    }
    return self;
}

- (NSMutableDictionary *)LoadJsonDictionaryFromFile:(NSString *)nomeArquivo {
    NSString *documentPath, *contentOfFile;
    NSMutableDictionary *json;
    NSError *error;
    
    documentPath = [[NSBundle mainBundle] pathForResource:nomeArquivo ofType:@"json"];
    contentOfFile = [NSString stringWithContentsOfFile:documentPath encoding:NSUTF8StringEncoding error:&error];
    //    NSLog(@"Erro de leitura:%@", [error description]);
    json = [NSJSONSerialization JSONObjectWithData:[contentOfFile dataUsingEncoding: NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:&error];
    //    NSLog(@"Erro de JSON:%@", [error description]);
    return json;
}

- (NSMutableArray *)LoadJsonArrayFromFile:(NSString *)nomeArquivo {
    NSString *documentPath, *contentOfFile;
    NSMutableArray *json;
    NSError *error;
    
    documentPath = [[NSBundle mainBundle] pathForResource:nomeArquivo ofType:@"json"];
    contentOfFile = [NSString stringWithContentsOfFile:documentPath encoding:NSUTF8StringEncoding error:&error];
    //    NSLog(@"Erro de leitura:%@", [error description]);
    json = [NSJSONSerialization JSONObjectWithData:[contentOfFile dataUsingEncoding: NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:&error];
    //    NSLog(@"Erro de JSON:%@", [error description]);
    return json;
}

@end
