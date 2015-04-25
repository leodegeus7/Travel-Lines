//
//  PaisesTableViewController.m
//  TravelLine
//
//  Created by Leonardo Geus on 17/04/15.
//  Copyright (c) 2015 Leonardo Geus. All rights reserved.
//

#import "PaisesTableViewController.h"
#import "PaisesTableViewCell.h"
#import "DataManager.h"
#import "Item.h"
#import "AppDelegate.h"
#import "AddLugarViewController.h"
#import "TimeLineTableViewController.h"


@interface PaisesTableViewController (){
    NSArray *myData;
    DataManager *_data;
    NSArray *viagem;
    item *Item;
    
}

@end

@implementation PaisesTableViewController



@synthesize managedObjectContext;

- (void)viewDidLoad {
    [super viewDidLoad];

    Item = [[item alloc]init];
    _data = [DataManager sharedManager]; //da um sharedmanager no ponteiro do DM
    [self atualizartabela];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeInfoDark];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    [btn addTarget:self action:@selector(showInfoScreen) forControlEvents:UIControlEventTouchUpInside];



    
    
    //Recuperando caminho para data.json
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"paises" ofType:@".json"];
//    
//    NSLog(@"%@",path);
//    
//    //Criando NSData e preenchendo com o conteúdo do arquivo data.json
//    NSData *dataResponse = [[NSData alloc]initWithContentsOfFile:path];
//    
//    NSError *error;
//    
//    NSDictionary *jsonSerialized = [NSJSONSerialization JSONObjectWithData:dataResponse
//                                                                   options:NSJSONReadingMutableContainers
//                                                                     error:&error];
//    
//    _myData = jsonSerialized[@"viagem"];
    
    
    
    //myData = [[DataManager sharedManager]dict][@"viagem"];
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
    return viagem.count;
}

-(void)showInfoScreen{

    [self performSegueWithIdentifier:@"info" sender:self];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PaisesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellViagem" forIndexPath:indexPath];
    NSMutableDictionary *teste;
    teste = _data.dados;
    //cell.viagemLabel.text=[NSString stringWithFormat:@"%@",myData[indexPath.row][@"nome"]];
    NSString *nomeArquivo = [NSString stringWithFormat:@"%@",[[myData[1] objectAtIndex:indexPath.row] objectForKey: @"capa" ]];
    NSString *caminho = [item acharoarqfile:nomeArquivo];
    //NSString *caminho = [[myData[1] objectAtIndex:indexPath.row] objectForKey: @"capa"];
    NSLog(@"%@",caminho);
    cell.viagemImage2.image = [self loadImage:caminho];
    UIImage *testeF = [self loadImage:caminho];
    NSLog(@"%@", testeF);
    cell.viagemLabel.text=[NSString stringWithFormat:@"%@",[[myData[1] objectAtIndex:indexPath.row] objectForKey: @"nome"]];

    return cell;
}

//- (void)saveImage: (UIImage*)image
//{
//    if (image != nil)
//    {
//        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
//                                                             NSUserDomainMask, YES);
//        NSString *documentsDirectory = [paths objectAtIndex:0];
//        NSString* path = [documentsDirectory stringByAppendingPathComponent:
//                          @"test.png" ];
//        NSData* data = UIImagePNGRepresentation(image);
//        [data writeToFile:path atomically:YES];
//        NSLog(@"caminho %@",path);
//    }
//}
//
- (UIImage*)loadImage:(NSString *)caminho;
{

    UIImage* image = [UIImage imageWithContentsOfFile:caminho];
    return image;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    TimeLineTableViewController *dvc = segue.destinationViewController;
    dvc.viagemEscolhida = _linhaEscolhida;
    if ([segue.identifier isEqualToString:@"oi2"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        TimeLineTableViewController *destViewController = segue.destinationViewController;
        destViewController.viagemEscolhida = indexPath.row;
        
    }
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    _linhaEscolhida = indexPath.row;
    NSLog(@"Celula Clicada %ld", _linhaEscolhida);
    TimeLineTableViewController *vcLinha = [[TimeLineTableViewController alloc]init];
    vcLinha.viagemEscolhida = _linhaEscolhida;
    [self performSegueWithIdentifier:@"oi" sender:self];
    
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_data.dados[@"viagem"] removeObjectAtIndex:indexPath.row];
        // Delete the row from the data source
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        [self atualizartabela];
    }
}

-(void)viewWillAppear:(BOOL)animated{
    [self atualizartabela];
    _data.temFoto=false;
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


- (IBAction)ClickButtonAdd:(id)sender {
    
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
                                   NSMutableArray *momento = [@[] mutableCopy];
                                   [self armazenarDadosViagemnome:myTextfield.text array:momento];
                                   
                               }];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"Insira o local";
    }];
    
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
}


-(void)atualizartabela{
    myData = [_data.dados allValues];
    viagem = _data.dados[@"viagem"];
    [self.tableView reloadData];
    [Item saveFileName:@"paises" conteudo:_data.dados];
}
- (IBAction)refresh:(id)sender {
    [self atualizartabela];
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
    [self atualizartabela];
}

@end
