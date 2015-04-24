
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
#import "PaisesTableViewCell.h"


@interface AddLugarViewController (){
    item *Item;
    PaisesTableViewController *_paises;
    PaisesTableViewCell *_paisesCell;
    DataManager *_data;
}

@end

@implementation AddLugarViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    Item = [[item alloc]init];
    _paises = [[PaisesTableViewController alloc]init];
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
- (IBAction)selectFoto:(id)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:picker animated:YES completion:NULL];
    
    
}
- (IBAction)selectCamera:(id)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:picker animated:YES completion:NULL];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *selectedImage = info[UIImagePickerControllerEditedImage];
    self.imagePais.image = selectedImage;
    UIImageWriteToSavedPhotosAlbum(selectedImage, nil, nil, nil);
//    [self saveImage:selectedImage :@"oi"];
    NSString *path;
    path = [self saveImage:selectedImage];
    NSLog(@"%@",path);
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

- (IBAction)addPais:(id)sender {
    
//    if (_data.temFoto) {
//        NSLog(@"DEEEEU CERTOOO");
//    }
    
    if (![_textfieldPais.text isEqualToString:@""]) {
        if (![_textFieldAno.text isEqualToString:@""]) {
            if (_data.temFoto) {
                NSMutableArray *momento = [@[] mutableCopy];
                NSString *data=  _textFieldAno.text;
                [self armazenarDadosViagemnome:_textfieldPais.text array:momento ano:data];
                [_paises atualizartabela];
                [_paises.tableView reloadData];
                [self.navigationController popToRootViewControllerAnimated:YES];
            }
            else {
                UIAlertView* alert;
                alert = [[UIAlertView alloc] initWithTitle:@"Aviso!" message:[NSString stringWithFormat:@"Escolha uma foto de capa!"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [alert show];
            
            
            }

            }
        else{
            UIAlertView* alert;
            alert = [[UIAlertView alloc] initWithTitle:@"Aviso!" message:[NSString stringWithFormat:@"Insira o ano da viagem!"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alert show];
        }

    }
    else{
        UIAlertView* alert;
        alert = [[UIAlertView alloc] initWithTitle:@"Aviso!" message:[NSString stringWithFormat:@"Insira o título da viagem"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    
    
    }
    

    //[self.storyboard instantiateViewControllerWithIdentifier:@"inicialController"];
}


-(void)armazenarDadosViagemnome:(NSString*)nome array:(NSMutableArray*)array ano:(NSString*)ano{
    NSMutableDictionary* jsonDic=[NSMutableDictionary dictionaryWithDictionary:_data.dados];//pegar nosso dicionario principal
    NSMutableArray *JAry=[[NSMutableArray alloc] initWithArray:[jsonDic objectForKey:@"viagem"]];//salvo o array a ser manipulado
    NSMutableDictionary *lugar =[[NSMutableDictionary alloc]init];//Dicionario com lugar
    NSString *caminhoFoto = [self retornarCaminhoDaFotoAtual];
    [lugar setObject:nome forKey:@"nome"];
    [lugar setObject:caminhoFoto forKey:@"capa"];
    [lugar setObject:array forKey:@"momento"];
    [lugar setObject:ano forKey:@"ano"];
    
    
    
    [JAry addObject:lugar];//atribuicao do dicionario para o array
    [jsonDic setObject:JAry forKey:@"viagem"];//atribuicao do array para o dicionario principal
    _data.dados = jsonDic;
    [_paises atualizartabela];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}



//- (void)saveImage:(UIImage*)image:(NSString*)imageName{
//    NSData *imageData = UIImagePNGRepresentation(image); //convert image into .png format.
//    
//    NSFileManager *fileManager = [NSFileManager defaultManager];//create instance of NSFileManager
//    
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); //create an array and store result of our search for the documents directory in it
//    
//    NSString *documentsDirectory = [paths objectAtIndex:0]; //create NSString object, that holds our exact path to the documents directory
//    
//    NSString *fullPath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png", imageName]]; //add our image to the path
//    
//    [fileManager createFileAtPath:fullPath contents:imageData attributes:nil]; //finally save the path (image)
//    
//    NSLog(@"image saved");}

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
                          nomeFoto ];
        NSData* data = UIImagePNGRepresentation(image);
        [data writeToFile:path atomically:YES];
        NSLog(@"caminho %@",path);
        
        [self armazenarDadosIndice:indiceStringFormatada];
        _data.temFoto=true;
        return path;

    }
    return nil;
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


-(void)armazenarDadosIndice:(NSString*)descricao{
    NSMutableDictionary* jsonDic=[NSMutableDictionary dictionaryWithDictionary:_data.dados];//pegar nosso dicionario principal


    [jsonDic setObject:descricao forKey:@"indiceFoto"];//atribuicao do array para o dicionario principal
    _data.dados = jsonDic;
    [Item saveFileName:@"paises" conteudo:_data.dados];
}



- (UIImage*)loadImage
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                         NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString* path = [documentsDirectory stringByAppendingPathComponent:
                      @"test.png" ];
    UIImage* image = [UIImage imageWithContentsOfFile:path];
    return image;
}

 

@end
