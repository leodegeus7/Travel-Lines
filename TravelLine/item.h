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

-(NSDictionary*) lerArqJson:(NSString *)name;
-(void)saveFileName:(NSString*)name conteudo:(NSDictionary*)dicCont;
+(NSDictionary*)LerArquivoJSon:(NSString*)Nome;
+ (void)moveFromBundleToDocuments:(NSString *)file;
+ (NSString *)getPathFromDocuments:(NSString *)file;
+ (NSString *)acharoarqfile:(NSString *)file;
-(NSDictionary*) lerArqJson2:(NSString *)name caminho:(NSString *)path;
-(NSString *)horaAtual;
@end
