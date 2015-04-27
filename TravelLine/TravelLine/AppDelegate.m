//
//  AppDelegate.m
//  TravelLine
//
//  Created by Leonardo Geus on 16/04/15.
//  Copyright (c) 2015 Leonardo Geus. All rights reserved.
//

#import "AppDelegate.h"
#import "DataManager.h"
#import "item.h"
#import "CRGradientNavigationBar.h"

@interface AppDelegate (){
    item* Item;
}

@end

@implementation AppDelegate



DataManager *_data;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{

    _data = [DataManager sharedManager];
    Item = [[item alloc] init]; //alloc na classe item
    [item moveFromBundleToDocuments:@"paises.json"]; //mover do bundle para o documents
    NSString *pathjsondoc;
    pathjsondoc = [item getPathFromDocuments:@"paises.json"];//criar a string dos documentos
    NSLog(@"%@",pathjsondoc);
    NSString *pathjson;
    pathjson = [item acharoarqfile:@"paises.json"]; //achar o caminho do json nos documents
    _data.dados = [Item lerArqJson2:@"paises" caminho:pathjson]; //alimentar meu NSDictionary com o json dos documents
    NSLog(@"TESTE DE DATAMANAGER %@",_data.dados);
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"fundoGradiente.jpg"] forBarMetrics:UIBarMetricsDefault];


    
//    NSDictionary *myDict;
//    Item = [[item alloc] init];
//    
//    myDict = [Item lerArqJson:@"paises"];
//
//    if (myDict==nil) {
//        NSLog(@"NAO EXISTE");
//
//        NSString *path1 = [[NSBundle mainBundle] pathForResource:@"paises" ofType:@".json"];
//        
//        NSLog(@"%@",path1);
//        
//        //Criando NSData e preenchendo com o conteúdo do arquivo data.json
//        NSData *dataResponse = [[NSData alloc]initWithContentsOfFile:path1];
//        
//        NSError *error;
//        
//        NSDictionary *jsonSerialized = [NSJSONSerialization JSONObjectWithData:dataResponse
//                                                                       options:NSJSONReadingMutableContainers
//                                                                         error:&error];
//        
//        _myData = jsonSerialized[@"Jogos"];
//        NSLog(@"mydata = %@",_myData);
//        NSDictionary *dados = [[NSDictionary alloc]init];
//        dados = [item LerArquivoJSon:@"paises"];
//        
//        [Item saveFileName:@"dados" conteudo:dados];
//        
//        //NSString *path2 = [[NSBundle mainBundle] pathForResource:@"dados" ofType:@".json"];
//        
//        //NSLog(@"%@",path2);
//    }
//    else {
//    
//        NSLog(@"%@",myDict);
//        
//    }
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Saves changes in the application's managed object context before the application terminates.
}



@end
