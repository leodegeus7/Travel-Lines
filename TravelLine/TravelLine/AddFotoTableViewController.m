//
//  AddFotoTableViewController.m
//  TravelLine
//
//  Created by Leonardo Geus on 26/04/15.
//  Copyright (c) 2015 Leonardo Geus. All rights reserved.
//

#import "AddFotoTableViewController.h"
#import "TimeLineTableViewController.h"
#import "PaisesTableViewController.h"
#import "TimeLineTableViewCell.h"
#import "DataManager.h"
#import "Item.h"
#import "AppDelegate.h"
#import "ImageTableViewCell.h"
#import "EditarViagemViewController.h"

@interface AddFotoTableViewController (){
    NSArray *myData;
    DataManager *_data;
    NSArray *momento;
    item *Item;
    UIBarButtonItem *addButton;
    UIBarButtonItem *salvarTexto;
    UIBarButtonItem *editarViagem;
}

@end

@implementation AddFotoTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ;
    Item = [[item alloc]init];
    _data = [DataManager sharedManager]; //da um sharedmanager no ponteiro do DM
    [self atualizartabela];
    NSLog(@"testeeeee %ld",_viagemEscolhida);
    CGRect newFrame = _myView2.frame;
    newFrame.size.height = 25;
    CGRect textfield = _myTextField.frame;
    textfield.size.height = 15;
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};

    
    
    
    
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"addFotoCell" forIndexPath:indexPath];
    cell.textLabel.text = [[_data.dados[@"viagem"] objectAtIndex:indexPath.row] objectForKey: @"nome"];
    return cell;
        
}





- (void)selectCamera {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:picker animated:YES completion:NULL];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *selectedImage = info[UIImagePickerControllerEditedImage];
    //    self..image = selectedImage;
    UIImageWriteToSavedPhotosAlbum(selectedImage, nil, nil, nil);
    //    [self saveImage:selectedImage :@"oi"];
    NSString *path;
    path = [self saveImage:selectedImage];
    NSString *nomeFoto = [self retornarCaminhoDaFotoAtual];
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    [self armazenarDadosMomentoImage:nomeFoto];
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}

- (UIImage*)loadImage:(NSString *)caminho;
{
    UIImage* image = [UIImage imageWithContentsOfFile:caminho];
    return image;
}

-(NSString *)retornarCaminhoDaFotoAtual{
    NSString *indiceFotoString= [NSString stringWithFormat:@"%@",_data.dados[@"indiceFoto"]];
    int indiceInteiro = [indiceFotoString intValue];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                         NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *nomeFoto = [NSString stringWithFormat:@"%d.png",indiceInteiro];
    NSString* path = [documentsDirectory stringByAppendingPathComponent:
                      nomeFoto ];
    NSLog(@"%@",path);
    
    return nomeFoto;
}

- (NSString *)saveImage: (UIImage*)image
{
    if (image != nil)
    {
        NSString *indiceFotoString= [NSString stringWithFormat:@"%@",_data.dados[@"indiceFoto"]];
        int indiceInteiro = [indiceFotoString intValue];
        indiceInteiro++;
        NSString *indiceStringFormatada = [NSString stringWithFormat:@"%d",indiceInteiro];
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                             NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *nomeFoto = [NSString stringWithFormat:@"%d.png",indiceInteiro];
        NSString* path = [documentsDirectory stringByAppendingPathComponent:
                          nomeFoto];
        NSData* data = UIImagePNGRepresentation(image);
        [data writeToFile:path atomically:YES];
        NSLog(@"caminho %@",path);
        
        [self armazenarDadosIndice:indiceStringFormatada];
        //        _data.temFoto=true;
        return path;
        
    }
    return nil;
}

-(void)armazenarDadosIndice:(NSString*)descricao{
    NSMutableDictionary* jsonDic=[NSMutableDictionary dictionaryWithDictionary:_data.dados];//pegar nosso dicionario principal
    [jsonDic setObject:descricao forKey:@"indiceFoto"];//atribuicao do array para o dicionario principal
    _data.dados = jsonDic;
    [Item saveFileName:@"paises" conteudo:_data.dados];
}

-(void)atualizartabela{
    myData = [_data.dados allValues];
    
    momento = _data.dados[@"viagem"];
    [self.tableView reloadData];
    [Item saveFileName:@"paises" conteudo:_data.dados];
}




-(void)armazenarDadosMomentoImage:(NSString*)descricao{
    NSMutableDictionary* jsonDic=[NSMutableDictionary dictionaryWithDictionary:_data.dados];//pegar nosso dicionario principal
    NSMutableArray *JAry=[[NSMutableArray alloc] initWithArray:[jsonDic objectForKey:@"viagem"]];//salvo o array a ser manipulado
    NSMutableDictionary *JDic=[[NSMutableDictionary alloc]initWithDictionary:[JAry objectAtIndex:_viagemEscolhida]];
    NSMutableArray *JMomentoGeral=[[NSMutableArray alloc]initWithArray:[JDic objectForKey:@"momento"]];
    NSMutableArray *reversedArray = [NSMutableArray arrayWithArray:[[JMomentoGeral reverseObjectEnumerator] allObjects]];
    NSMutableDictionary *jMomentoEspecifico =[[NSMutableDictionary alloc]init];
    
    
    //NSMutableArray *JAry=[[NSMutableArray alloc] initWithArray:[jsonDic[@"viagem"][_viagemEscolhida] objectForKey:@"momento"]];//salvo o array a ser manipulado
    
    //NSMutableDictionary *mom =[[NSMutableDictionary alloc]init];//Dicionario com lugar
    NSString *tipo = @"imagem";
    NSString *dataAtual = [Item horaAtual];
    NSString *tamanhoCell = @"";
    
    [jMomentoEspecifico setObject:descricao forKey:@"imagem"];
    [jMomentoEspecifico setObject:tipo forKey:@"tipo"];
    [jMomentoEspecifico setObject:dataAtual forKey:@"data"];
    [jMomentoEspecifico setObject:tamanhoCell forKey:@"tamanhoCell"];
    
    [reversedArray addObject:jMomentoEspecifico];
    
    NSArray *reversedArray2 = [NSMutableArray arrayWithArray:[[reversedArray reverseObjectEnumerator] allObjects]];
    
    [JDic setObject:reversedArray2 forKey:@"momento"];
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
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _viagemEscolhida = indexPath.row;
    [self selectCamera];
}


@end