//
//  EditarViagemViewController.m
//  TravelLine
//
//  Created by Leonardo Geus on 26/04/15.
//  Copyright (c) 2015 Leonardo Geus. All rights reserved.
//

#import "EditarViagemViewController.h"
#import "AddLugarViewController.h"
#import "DataManager.h"
#import "item.h"
#import "PaisesTableViewController.h"

@interface EditarViagemViewController (){
    item *Item;
    PaisesTableViewController *_paises;
    DataManager *_data;
    NSArray *_pickerData;
    NSMutableArray *_pickerDataAnos;
    NSString *_anoEscohido;
}

@end

@implementation EditarViagemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    Item = [[item alloc]init];
    _paises = [[PaisesTableViewController alloc]init];
    _data = [DataManager sharedManager];
    [_textfieldPais setDelegate:self];
    // Do any additional setup after loading the view.
    NSLog(@"%li",(long)_viagemEscolhidaEditar);

    self.title=[NSString stringWithFormat:@"Editar %@",_data.dados[@"viagem"][_viagemEscolhidaEditar][@"nome"]];
    //Inicializando os dados do PickerView
    _pickerData = @[@"Item 1", @"Item 2", @"Item 3", @"Item 4", @"Item 5", @"Item 6"];
    
    //Conectando os dados do PickerView
    self.picker.dataSource = self;
    self.picker.delegate = self;
    
    // Pegando o ano atual
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"YYYY"];
    int i2 = [[dateFormatter stringFromDate:[NSDate date]] intValue];
    NSLog(@"%d",i2);
    _pickerDataAnos = [[NSMutableArray alloc] init];
    for (int i1=i2; i1<=i2 & i1>=1920; i1--) {
        [_pickerDataAnos addObject:[NSString stringWithFormat:@"%d",i1]];
    }

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Número de clounas
- (long)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// Número de linhas
- (long)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return _pickerDataAnos.count;
}

// Povoando o PickerView
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return _pickerDataAnos[row];
    
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    _anoEscohido= [NSString stringWithFormat:@"%@",_pickerDataAnos[row]];
    
}


- (IBAction)selectPhoto:(id)sender {
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
    
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
        
        UIImageWriteToSavedPhotosAlbum(selectedImage, nil, nil, nil);
        
    }
    
    //    [self saveImage:selectedImage :@"oi"];
    NSString *path;
    path = [self saveImage:selectedImage];
    NSLog(@"%@",path);
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:NULL];
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

-(void)armazenarDadosIndice:(NSString*)descricao{
    NSMutableDictionary* jsonDic=[NSMutableDictionary dictionaryWithDictionary:_data.dados];//pegar nosso dicionario principal
    
    
    [jsonDic setObject:descricao forKey:@"indiceFoto"];//atribuicao do array para o dicionario principal
    _data.dados = jsonDic;
    [Item saveFileName:@"paises" conteudo:_data.dados];
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
    if (![_textfieldPais.text isEqualToString:@""]) {
        if (![_anoEscohido isEqualToString:@""]) {
            if (_data.temFoto) {
                NSMutableArray *momento = [@[] mutableCopy];
                [self armazenarDadosViagemnome:_textfieldPais.text array:momento ano:_anoEscohido];
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
    
    NSMutableDictionary *viagem = [[NSMutableDictionary alloc]initWithDictionary:JAry[_viagemEscolhidaEditar]];
    
    NSString *caminhoFoto = [self retornarCaminhoDaFotoAtual];
    [viagem setObject:nome forKey:@"nome"];
    [viagem setObject:caminhoFoto forKey:@"capa"];
    [viagem setObject:ano forKey:@"ano"];
    
    
    
    [JAry setObject:viagem atIndexedSubscript:_viagemEscolhidaEditar];//atribuicao do dicionario para o array
    [jsonDic setObject:JAry forKey:@"viagem"];//atribuicao do array para o dicionario principal
    _data.dados = jsonDic;
    [_paises atualizartabela];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    NSInteger nextTag = textField.tag + 1;
    // Aqui ele encontra o next responder
    UIResponder* nextResponder = [textField.superview viewWithTag:nextTag];
    if (nextResponder) {
        // Se encontrou, set
        [nextResponder becomeFirstResponder];
    } else {
        // Não encontrou, ele esconde o teclado
        [textField resignFirstResponder];
    }
    return NO;
    
    
    //    [textField resignFirstResponder];
    //
    //    return YES;
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
