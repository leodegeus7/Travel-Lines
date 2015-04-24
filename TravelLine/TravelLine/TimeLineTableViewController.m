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
    CGRect newFrame = _myView2.frame;
    newFrame.size.height = 40;
    CGRect textfield = _myTextField.frame;
    textfield.size.height = 30;
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor clearColor];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    

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
    
    NSLog(@"DESCRICAO = %@",myData[1][_viagemEscolhida][@"momento"][0][@"descricao"]);
    cell.textfieldMomento.text=[NSString stringWithFormat:@"%@",[[myData[1][_viagemEscolhida][@"momento"] objectAtIndex:indexPath.row] objectForKey: @"descricao"]];
    
    return cell;
}
- (IBAction)addImage:(id)sender {
    NSLog(@"oioioioioi");
    
}
//
//- (IBAction)selectFoto:(id)sender {
//    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
//    picker.delegate = self;
//    picker.allowsEditing = YES;
//    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//    [self presentViewController:picker animated:YES completion:NULL];
//    
//    
//}
//- (IBAction)selectCamera:(id)sender {
//    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
//    picker.delegate = self;
//    picker.allowsEditing = YES;
//    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
//    [self presentViewController:picker animated:YES completion:NULL];
//}
//
//- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
//    UIImage *selectedImage = info[UIImagePickerControllerEditedImage];
//    self.imagePais.image = selectedImage;
//    UIImageWriteToSavedPhotosAlbum(selectedImage, nil, nil, nil);
//    //    [self saveImage:selectedImage :@"oi"];
//    NSString *path;
//    path = [self saveImage:selectedImage];
//    NSLog(@"%@",path);
//    [picker dismissViewControllerAnimated:YES completion:NULL];
//    
//}

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

//- (IBAction)addTexto:(id)sender {
//    NSLog(@"oooi1");
//    //[self.storyboard instantiateViewControllerWithIdentifier:@"texto"];
//    CGRect newFrame = _myContainerView.frame;
//    newFrame.size.height = 178;
//    
//    [UIView animateWithDuration:1.0
//                     animations:^{
//                         _myContainerView.frame = newFrame;
//                     }];
//    
//
//    
//    
//}

//- (IBAction)addFoto:(id)sender {
//
//    NSLog(@"oooi2");
//}





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
    NSString *tipo = @"texto";
    [jMomentoEspecifico setObject:descricao forKey:@"descricao"];
    [jMomentoEspecifico setObject:tipo forKey:@"tipo"];
    
    [JMomentoGeral addObject:jMomentoEspecifico];
    [JDic setObject:JMomentoGeral forKey:@"momento"];
    [JAry setObject:JDic atIndexedSubscript:_viagemEscolhida];
    [jsonDic setObject:JAry forKey:@"viagem"];
    //[JAry addObject:mom];//atribuicao do dicionario para o array
    //[jsonDic setObject:JAry forKey:@"viagem"];//atribuicao do array para o dicionario principal
    _data.dados = jsonDic;
    [self atualizartabela];
}


-(void)mudarTabela{
    NSLog(@"oooi1");
    //[self.storyboard instantiateViewControllerWithIdentifier:@"texto"];
    CGRect newFrame = _myView2.frame;
    newFrame.size.height = 180;
    
    [UIView animateWithDuration:1.0
                     animations:^{
                         _myView2.frame = newFrame;
                     }];


}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    [self armazenarDadosViagemnome:_myTextField.text];
    CGRect newFrame = _myView2.frame;
    newFrame.size.height = 20;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}



- (IBAction)buttonOk:(id)sender {
    CGRect newFrame = _myView2.frame;
    newFrame.size.height = 38;
    
    [UIView animateWithDuration:0.5
                     animations:^{
                         _myView2.frame = newFrame;
                     }];
    [self armazenarDadosViagemnome:_myTextField.text];
    [_myTextField resignFirstResponder];
    _myTextField.text = nil;
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor clearColor];
    self.navigationItem.rightBarButtonItem.enabled = NO;
}

- (IBAction)addText2:(id)sender {
    [self mudarTabela];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor blackColor];
    self.navigationItem.rightBarButtonItem.enabled = YES;
    
}
@end
