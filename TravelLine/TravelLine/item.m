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


-(NSString*)escArqNome:(NSString*)nome{
    NSString *docs;
    docs = [item acharcaminhodoarquivo];
//    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES);
//    NSString *docs = [path objectAtIndex:0];
    NSString *propertyList;
    propertyList=[[NSString alloc] initWithFormat:@"/%@.json",nome];
    propertyList=[docs stringByAppendingString:propertyList];
    NSLog(@"%@",propertyList);
    return propertyList;
}

-(NSData*)dictionaryToJson:(NSDictionary *) myDicto {
    NSError* error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:myDicto options:0 error:&error];
    if (!jsonData) {
        return nil;
    }
    else{
        return [jsonData copy];
    }
}

-(void)saveFileName:(NSString*)name conteudo:(NSDictionary*)dicCont{
    NSData *jData;
    jData = [self dictionaryToJson:dicCont];
    NSString* arqName=[self escArqNome:name];
    NSFileManager *filemgr=[NSFileManager defaultManager];
    if (![filemgr fileExistsAtPath:arqName]) {
        NSLog(@"arquivo nao existe");
        [filemgr createFileAtPath:arqName contents:nil attributes:nil];
        NSLog(@"arquivo criado");
    }
    else{
        NSLog(@"arquivo existe");
        if ([filemgr removeItemAtPath:arqName error:nil]==1) {
            [filemgr createFileAtPath:arqName contents:nil attributes:nil];
            
        }
    }
    NSFileHandle *file;
    file = [NSFileHandle fileHandleForUpdatingAtPath:arqName];
    if (file==nil) {
        NSLog(@"dddd");
    }
    else{
        if (jData != nil) {
            [file seekToEndOfFile];
            [file writeData:jData];
            [file closeFile];
            
        }
    }
    

}

+(NSDictionary*)LerArquivoJSon:(NSString*)Nome{
    NSString* path=[[NSBundle mainBundle] pathForResource:@"paises" ofType:@"json"];
    NSData* dataresponse = [[NSData alloc] initWithContentsOfFile:path];
    NSError* error;
    NSDictionary* jsonSerial = [NSJSONSerialization JSONObjectWithData:dataresponse options:NSJSONReadingMutableContainers error:&error];
    return [jsonSerial copy];



}


-(NSDictionary*) lerArqJson:(NSString *)name{
    NSData *leitura;
    NSString *arqName;
    NSFileHandle *jArq;
    arqName = [self escArqNome:name];
    jArq = [NSFileHandle fileHandleForReadingAtPath:arqName];
    if (jArq==nil) {
        return nil;
    }
    else{
        [jArq seekToFileOffset:0];
        leitura = [jArq readDataToEndOfFile];
        NSError *error;
        NSDictionary *jsonSerial = [NSJSONSerialization JSONObjectWithData:leitura options:NSJSONReadingMutableContainers error:&error];
        return [jsonSerial copy];
        
    }
}

-(NSDictionary*) lerArqJson2:(NSString *)name caminho:(NSString *)path{
    NSData *leitura;
    NSString *arqName;
    NSFileHandle *jArq;
    arqName = path;
    jArq = [NSFileHandle fileHandleForReadingAtPath:arqName];
    if (jArq==nil) {
        return nil;
    }
    else{
        [jArq seekToFileOffset:0];
        leitura = [jArq readDataToEndOfFile];
        NSError *error;
        NSMutableDictionary *jsonSerial = [NSJSONSerialization JSONObjectWithData:leitura options:NSJSONReadingMutableContainers error:&error];
        return [jsonSerial copy];
        
    }
}

+ (NSString *)acharoarqfile:(NSString *)file{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectoryPath = [paths objectAtIndex:0];
    NSString *destinationPath = [documentDirectoryPath stringByAppendingPathComponent:file];
    NSLog(@"File: %@", destinationPath);
    return destinationPath;

}

+ (NSString *)acharcaminhodoarquivo{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectoryPath = [paths objectAtIndex:0];
    return documentDirectoryPath;
}

+ (void)moveFromBundleToDocuments:(NSString *)file {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error = nil;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectoryPath = [paths objectAtIndex:0];
    NSString *destinationPath = [documentDirectoryPath stringByAppendingPathComponent:file];
    NSLog(@"File: %@", destinationPath);
    if([fileManager fileExistsAtPath:destinationPath])
        return;
    NSString *sourcePath=[[[NSBundle mainBundle] resourcePath]stringByAppendingPathComponent:file];
    [fileManager copyItemAtPath:sourcePath toPath:destinationPath error:&error];
}

+ (NSString *)getPathFromDocuments:(NSString *)file {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectoryPath = [paths objectAtIndex:0];
    NSString *documentPath = [documentDirectoryPath stringByAppendingPathComponent:file];;
    return documentPath;
}


-(NSString *)horaAtual{
    NSDate *currDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS"];
    NSString *dateString = [dateFormatter stringFromDate:currDate];
    NSLog(@"%@",dateString);
    return dateString;
}


@end
