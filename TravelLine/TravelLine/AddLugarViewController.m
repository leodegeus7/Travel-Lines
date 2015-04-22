//
//  AddLugarViewController.m
//  TravelLine
//
//  Created by Leonardo Geus on 22/04/15.
//  Copyright (c) 2015 Leonardo Geus. All rights reserved.
//

#import "AddLugarViewController.h"
#import "DataManager.h"
#import "item.h"
#import "PaisesTableViewController.h"

@interface AddLugarViewController (){
    item *Item;
    PaisesTableViewController *paises;
    DataManager *_data;
}

@end

@implementation AddLugarViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    Item = [[item alloc]init];
    paises = [[PaisesTableViewController alloc]init];
    _data = [DataManager sharedManager];
    [_textfieldPais setDelegate:self];
    
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)addPais:(id)sender {
    
    NSMutableArray *momento = [@[] mutableCopy];
    [self armazenarDadosViagemnome:_textfieldPais.text array:momento];
    [paises atualizartabela];
    [paises.tableView reloadData];
    [self.navigationController popToRootViewControllerAnimated:YES];

    //[self.storyboard instantiateViewControllerWithIdentifier:@"inicialController"];
}





-(void)armazenarDadosViagemnome:(NSString*)nome array:(NSMutableArray*)array{
    NSMutableDictionary* jsonDic=[NSMutableDictionary dictionaryWithDictionary:_data.dados];//pegar nosso dicionario principal
    NSMutableArray *JAry=[[NSMutableArray alloc] initWithArray:[jsonDic objectForKey:@"viagem"]];//salvo o array a ser manipulado
    NSMutableDictionary *lugar =[[NSMutableDictionary alloc]init];//Dicionario com lugar
    [lugar setObject:nome forKey:@"nome"];
    [lugar setObject:nome forKey:@"capa"];
    [lugar setObject:array forKey:@"momento"];
    
    
    
    [JAry addObject:lugar];//atribuicao do dicionario para o array
    [jsonDic setObject:JAry forKey:@"viagem"];//atribuicao do array para o dicionario principal
    _data.dados = jsonDic;
    [paises atualizartabela];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    
    
    return YES;
    
}

@end
