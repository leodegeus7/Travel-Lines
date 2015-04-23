//
//  TimeLineTableViewController.m
//  TravelLine
//
//  Created by Leonardo Geus on 21/04/15.
//  Copyright (c) 2015 Leonardo Geus. All rights reserved.
//

#import "TimeLineTableViewController.h"
#import "PaisesTableViewController.h"
#import "TimeLineTableViewCell.h"
#import "DataManager.h"
#import "Item.h"
#import "AppDelegate.h"

@interface TimeLineTableViewController (){
    NSArray *myData;
    DataManager *_data;
    NSArray *momento;
    item *Item;
}

@end

@implementation TimeLineTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    Item = [[item alloc]init];
    _data = [DataManager sharedManager]; //da um sharedmanager no ponteiro do DM
    [self atualizartabela];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    NSLog(@"testeeeee %ld",_viagemEscolhida);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return momento.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TimeLineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellMomento" forIndexPath:indexPath];
    NSMutableDictionary *teste;
    teste = _data.dados[@"viagem"][_viagemEscolhida][@"momento"];
    //cell.viagemLabel.text=[NSString stringWithFormat:@"%@",myData[indexPath.row][@"nome"]];
    
    NSLog(@"DESCRICAO = %@",myData[0][_viagemEscolhida][@"momento"][0][@"descricao"]);
    cell.nomeMomento.text=[NSString stringWithFormat:@"%@",[[myData[0][_viagemEscolhida][@"momento"] objectAtIndex:indexPath.row] objectForKey: @"descricao"]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_data.dados[@"viagem"][_viagemEscolhida][@"momento"] removeObjectAtIndex:indexPath.row];
        // Delete the row from the data source
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)clickAddMomento:(id)sender {
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:@"oooi"
                                          message:@"deu certo meu"
                                          preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction
                               actionWithTitle:@"Ok"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction *action) {
                                   UITextField *myTextfield = alertController.textFields.firstObject;
                                   //_myLabel.text = myTextfield.text;
                                   //[_data.dados[@"viagem"][0] setObject:myTextfield.text forKey:@"nome"];
                                   [self armazenarDadosViagemnome:myTextfield.text];
                                    // =  myData[0][_viagemEscolhida][@"momento"][0][@"descricao"];
                                   
                                   
                               }];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"Insira o local";
    }];
    
    [alertController addAction:okAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

- (IBAction)addTexto:(id)sender {
    [self.storyboard instantiateViewControllerWithIdentifier:@"texto"];
    NSLog(@"oooi1");
    
    
}

- (IBAction)addFoto:(id)sender {
    [self.storyboard instantiateViewControllerWithIdentifier:@"foto"];
    NSLog(@"oooi2");
}



-(void)atualizartabela{
    myData = [_data.dados allValues];
    
    momento = _data.dados[@"viagem"][_viagemEscolhida][@"momento"];
    [self.tableView reloadData];
    [Item saveFileName:@"paises" conteudo:_data.dados];
}

-(void)armazenarDadosViagemnome:(NSString*)descricao{
    NSMutableDictionary* jsonDic=[NSMutableDictionary dictionaryWithDictionary:_data.dados];//pegar nosso dicionario principal
    NSMutableArray *JAry=[[NSMutableArray alloc] initWithArray:[jsonDic objectForKey:@"viagem"]];//salvo o array a ser manipulado
    NSMutableDictionary *JDic=[[NSMutableDictionary alloc]initWithDictionary:[JAry objectAtIndex:_viagemEscolhida]];
    NSMutableArray *JMomentoGeral=[[NSMutableArray alloc]initWithArray:[JDic objectForKey:@"momento"]];
    NSMutableDictionary *jMomentoEspecifico =[[NSMutableDictionary alloc]init];
    
    
    //NSMutableArray *JAry=[[NSMutableArray alloc] initWithArray:[jsonDic[@"viagem"][_viagemEscolhida] objectForKey:@"momento"]];//salvo o array a ser manipulado

    //NSMutableDictionary *mom =[[NSMutableDictionary alloc]init];//Dicionario com lugar

    [jMomentoEspecifico setObject:descricao forKey:@"descricao"];
    
    [JMomentoGeral addObject:jMomentoEspecifico];
    [JDic setObject:JMomentoGeral forKey:@"momento"];
    [JAry setObject:JDic atIndexedSubscript:_viagemEscolhida];
    [jsonDic setObject:JAry forKey:@"viagem"];
    //[JAry addObject:mom];//atribuicao do dicionario para o array
    //[jsonDic setObject:JAry forKey:@"viagem"];//atribuicao do array para o dicionario principal
    _data.dados = jsonDic;
    [self atualizartabela];
}





@end
