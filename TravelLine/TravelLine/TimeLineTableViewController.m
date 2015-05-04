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
#import "ImageTableViewCell.h"
#import "EditarViagemViewController.h"
#import "BrancoTableViewCell.h"
#import "ZoomImageViewController.h"

@interface TimeLineTableViewController ()

{
    NSArray *myData;
    DataManager *_data;
    NSArray *momento;
    item *Item;
    UIBarButtonItem *addButton;
    UIBarButtonItem *salvarTexto;
    UIBarButtonItem *settingButton;
    TimeLineTableViewCell *celulaPrototipo;

    UIBarButtonItem *editarViagem;
    UIToolbar *toolBar;
    PaisesTableViewController *paises;
    UIImage *buttonSettings;
    


    
}
@property (nonatomic, retain) NSIndexPath * indexPath;

@end

@implementation TimeLineTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 ;
    Item = [[item alloc]init];
    _data = [DataManager sharedManager]; //da um sharedmanager no ponteiro do DM
    [self atualizartabela];
    self.title=[NSString stringWithFormat:@"%@",_data.dados[@"viagem"] [_viagemEscolhida][@"nome"]];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    NSLog(@"testeeeee %ld",_viagemEscolhida);
    CGRect newFrame = _myView2.frame;
    newFrame.size.height = 40;
    CGRect textfield = _myTextField.frame;
    textfield.size.height = 30;
    //_myTextField.alpha =0;
    
//    self.navigationItem.rightBarButtonItem.tintColor = [UIColor clearColor];
//    self.navigationItem.rightBarButtonItem.enabled = false;
    
//    salvarTexto = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(SalvarTexto:)];
//    
//    [self.navigationItem setRightBarButtonItem:salvarTexto];
//
//    salvarTexto.enabled =false;
//    salvarTexto.tintColor = [UIColor clearColor];
    UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressRecognizer:)];
    [self.tableView addGestureRecognizer:longPressGesture];
    longPressGesture.minimumPressDuration = 1.0f;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didChangePreferredContentSize:)
                                                 name:UIContentSizeCategoryDidChangeNotification object:nil];
    

    
//    editarViagem = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(SalvarTexto:)];
//    editarViagem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(editarViagem:)];
//    UIBarButtonItem *settingsButton = [[UIBarButtonItem alloc] initWithTitle:@"\u2699" style:UIBarButtonItemStylePlain target:self action:@selector(showSettings)];

    buttonSettings = [UIImage imageNamed:@"settings.png"];
    UIImage *settingButtonMexida2 = [self imageWithImage:buttonSettings scaledToSize:CGSizeMake(27, 27)];
//    settingButton = [[UIBarButtonItem alloc] initWithImage:settingButtonMexida style:UIBarButtonItemStyleDone target:self action:@selector(editarViagem:)];
    editarViagem = [[UIBarButtonItem alloc] initWithImage:settingButtonMexida2 style:UIBarButtonItemStyleDone target:self action:@selector(editarViagem:)];
    


    [self.navigationItem setRightBarButtonItem:editarViagem];
    editarViagem.enabled =true;
    editarViagem.tintColor = [UIColor whiteColor];
    
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    UIImage *itemCamera = [UIImage imageNamed:@"Camera Roll.png"];
    UIImage *itemMexido = [self imageWithImage:itemCamera scaledToSize:CGSizeMake(35, 35)];
    UIButton *botaoCamera;
    [botaoCamera setBackgroundImage:itemMexido forState:UIControlStateSelected];
    [botaoCamera setBackgroundImage:itemMexido forState:UIControlStateHighlighted];
    _botaoCamera.image = itemMexido;

}



- (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    //UIGraphicsBeginImageContext(newSize);
    // In next line, pass 0.0 to use the current device's pixel scaling factor (and thus account for Retina resolution).
    // Pass 1.0 to force exact pixel size.
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIContentSizeCategoryDidChangeNotification
                                                  object:nil];
}


- (void)didChangePreferredContentSize:(NSNotification *)notification
{
    [self.tableView reloadData];
}



-(void)longPressRecognizer:(UISwipeGestureRecognizer *)gestureRecognizer{
    if (gestureRecognizer.state != UIGestureRecognizerStateEnded) {
        return;
    }
    
    if(self.editing)
    {
        [super setEditing:NO animated:NO];
        [self.tableView setEditing:NO animated:NO];
        [self.tableView reloadData];
        [self.navigationItem.leftBarButtonItem setTitle:@"Edit"];
        [self.navigationItem.leftBarButtonItem setStyle:UIBarButtonItemStylePlain];
    }
    else
    {
        [super setEditing:YES animated:YES];
        [self.tableView setEditing:YES animated:YES];
        [self.tableView reloadData];
        [self.navigationItem.leftBarButtonItem setTitle:@"Done"];
        [self.navigationItem.leftBarButtonItem setStyle:UIBarButtonItemStyleDone];
        addButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(EditTable:)];
        
        [self.navigationItem setRightBarButtonItem:addButton];
        addButton.enabled =true;
        addButton.tintColor = [UIColor whiteColor];
        

    }
}
- (IBAction)addImage2:(id)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:picker animated:YES completion:NULL];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void)viewWillAppear:(BOOL)animated{
    [self atualizartabela];
    _data.temFoto=false;
    self.tableView.estimatedRowHeight = 30.0; // for example. Set your average height
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
//    NSString *testeDoTipo = [NSString stringWithFormat:@"%@",[[myData[0][_viagemEscolhida][@"momento"] objectAtIndex:indexPath.row] objectForKey: @"tipo"]];
//    if ([testeDoTipo isEqualToString:@"imagem"])
//    {
//        self.tableView.rowHeight =
//    }
    
    
    [self.tableView layoutIfNeeded];
    [self.tableView autoresizingMask];
    [self.tableView reloadData];
    
    [self.navigationController setToolbarHidden:NO animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.navigationController setToolbarHidden:YES animated:YES];
}
- (IBAction)camera:(id)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:picker animated:YES completion:NULL];
    
}



- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *selectedImage = info[UIImagePickerControllerEditedImage];
    //    self..image = selectedImage;
    
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
        UIImageWriteToSavedPhotosAlbum(selectedImage, nil, nil, nil);
    }
    
    //    [self saveImage:selectedImage :@"oi"];
    NSString *path;
    path = [self saveImage:selectedImage];
    NSString *nomeFoto = [self retornarCaminhoDaFotoAtual];
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    [self armazenarDadosMomentoImage:nomeFoto];
    
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

//-(void)acaoDoBotao{
//    [super setEditing:YES animated:YES];
//    [self.tableView setEditing:YES animated:YES];
//    [self.tableView reloadData];
//    [self.navigationItem.leftBarButtonItem setTitle:@"Done"];
//    [self.navigationItem.leftBarButtonItem setStyle:UIBarButtonItemStyleDone];
//
//
//
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *testeDoTipo = [NSString stringWithFormat:@"%@",[[_data.dados[@"viagem"][_viagemEscolhida][@"momento"] objectAtIndex:indexPath.row] objectForKey: @"tipo"]];
    if ([testeDoTipo isEqualToString:@"texto"]) {
        TimeLineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellMomento" forIndexPath:indexPath];
        cell.textfieldMomento.text=[NSString stringWithFormat:@"%@",[[_data.dados[@"viagem"][_viagemEscolhida][@"momento"] objectAtIndex:indexPath.row] objectForKey: @"descricao"]];
        TimeLineTableViewController * vc = [TimeLineTableViewController alloc];
        [vc setIndexPath:_indexPath];
        self.tableView.rowHeight = UITableViewAutomaticDimension;
        
       
        
        return cell;

    }
    else if ([testeDoTipo isEqualToString:@"imagem"]) {
        ImageTableViewCell *imageCell = [tableView dequeueReusableCellWithIdentifier:@"imageMomento" forIndexPath:indexPath];
        NSString *nomeArquivo = [NSString stringWithFormat:@"%@",[[_data.dados[@"viagem"][_viagemEscolhida][@"momento"] objectAtIndex:indexPath.row] objectForKey: @"imagem"]];
        NSString *caminho = [item acharoarqfile:nomeArquivo];
        imageCell.imageMomento.image = [self loadImage:caminho];
    
        self.tableView.rowHeight = 199;
        
        return imageCell;
    }


//    NSMutableDictionary *teste;
//    teste = _data.dados[@"viagem"][_viagemEscolhida][@"momento"];
//    //cell.viagemLabel.text=[NSString stringWithFormat:@"%@",myData[indexPath.row][@"nome"]];
    
   // NSLog(@"DESCRICAO = %@",myData[1][_viagemEscolhida][@"momento"][0][@"descricao"]);
    return nil;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    EditarViagemViewController *dvc = segue.destinationViewController;
    dvc.viagemEscolhidaEditar = _viagemEscolhida;
    
    if ([segue.identifier isEqualToString:@"editarViagem"]) {
//        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        EditarViagemViewController *destViewController = segue.destinationViewController;
        destViewController.viagemEscolhidaEditar = _viagemEscolhida;
        
    }
    if ([segue.identifier isEqualToString:@"zoom"]) {
        ZoomImageViewController *destViewController = segue.destinationViewController;
        destViewController.rowSelecionada = _linhaEscolhida;
        destViewController.viagemEscolhida = _viagemEscolhida;
        NSLog(@"string %@", _data.dados[@"viagem"][_viagemEscolhida][@"momento"]);
    }
}
- (IBAction) EditTable:(id)sender{
    if(self.editing)
    {
        [super setEditing:NO animated:NO];
        [self.tableView setEditing:NO animated:NO];
        [self.tableView reloadData];
        [self.navigationItem.leftBarButtonItem setTitle:@"Edit"];
        [self.navigationItem.leftBarButtonItem setStyle:UIBarButtonItemStylePlain];
        addButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(EditTable:)];
        
        [self.navigationItem setRightBarButtonItem:addButton];
        addButton.enabled =false;
        addButton.tintColor = [UIColor clearColor];
        editarViagem = [[UIBarButtonItem alloc] initWithTitle:@"\u2699" style:UIBarButtonItemStyleDone target:self action:@selector(editarViagem:)];
        
        [self.navigationItem setRightBarButtonItem:editarViagem];
        editarViagem.enabled =true;
        editarViagem.tintColor = [UIColor whiteColor];

    }
    else
    {
        [super setEditing:YES animated:YES];
        [self.tableView setEditing:YES animated:YES];
        [self.tableView reloadData];
        [self.navigationItem.leftBarButtonItem setTitle:@"Done"];
        [self.navigationItem.leftBarButtonItem setStyle:UIBarButtonItemStyleDone];
    }
}

-(IBAction)editarViagem:(id)sender{
    
    [self performSegueWithIdentifier:@"editarViagem" sender:self];

}

- (IBAction)tirarFoto:(id)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:picker animated:YES completion:NULL];
}


//- (IBAction)selectCamera:(id)sender {
//    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
//    picker.delegate = self;
//    picker.allowsEditing = YES;
//    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
//    [self presentViewController:picker animated:YES completion:NULL];
//}



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


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        cell.primeiraLinhaTimeLine.hidden = YES;
//        cell.segundaLinhaTimeLine.hidden = YES;
//        imageCell.primeiraLinhaTimeLine.hidden = YES;
//        imageCell.segundaLinhaTimeLine.hidden = YES;
        [_data.dados[@"viagem"][_viagemEscolhida][@"momento"] removeObjectAtIndex:indexPath.row];
        // Delete the row from the data source
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        [self atualizartabela];
    }
}



/*
// Override to support conditional editing of the table view.FH
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *testeDoTipo= [NSString stringWithFormat:@"%@",[[_data.dados[@"viagem"][_viagemEscolhida][@"momento"] objectAtIndex:indexPath.row] objectForKey: @"tipo"]];
    if ([testeDoTipo isEqualToString:@"imagem"]) {
        
        _linhaEscolhida = indexPath.row;
        ZoomImageViewController *zoomVC = [[ZoomImageViewController alloc]init];
        zoomVC.rowSelecionada = _linhaEscolhida;
        [self performSegueWithIdentifier:@"zoom" sender:self];
    }
}

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
    NSMutableArray *reversedArray = [NSMutableArray arrayWithArray:[[JMomentoGeral reverseObjectEnumerator] allObjects]];
    NSMutableDictionary *jMomentoEspecifico =[[NSMutableDictionary alloc]init];
    
    
    //NSMutableArray *JAry=[[NSMutableArray alloc] initWithArray:[jsonDic[@"viagem"][_viagemEscolhida] objectForKey:@"momento"]];//salvo o array a ser manipulado

    //NSMutableDictionary *mom =[[NSMutableDictionary alloc]init];//Dicionario com lugar
    NSString *tipo = @"texto";
    NSString *tamanhoCell=@"";
    
    [jMomentoEspecifico setObject:descricao forKey:@"descricao"];
    [jMomentoEspecifico setObject:tipo forKey:@"tipo"];
    NSString *dataAtual = [Item horaAtual];
    [jMomentoEspecifico setObject:dataAtual forKey:@"data"];
    [jMomentoEspecifico setObject:tamanhoCell forKey:@"tamanhoCell"];
    
    [reversedArray addObject:jMomentoEspecifico];
    
    NSArray *reversedArray2 = [NSMutableArray arrayWithArray:[[reversedArray reverseObjectEnumerator] allObjects]];
//    NSArray *reversedArray = [[JMomentoGeral reverseObjectEnumerator] allObjects];

    

    
    [JDic setObject:reversedArray2 forKey:@"momento"];
    [JAry setObject:JDic atIndexedSubscript:_viagemEscolhida];
    [jsonDic setObject:JAry forKey:@"viagem"];
    //[JAry addObject:mom];//atribuicao do dicionario para o array
    //[jsonDic setObject:JAry forKey:@"viagem"];//atribuicao do array para o dicionario principal
    _data.dados = jsonDic;
    [self atualizartabela];
}

-(NSMutableArray*)sortArrayList:(NSMutableArray*)arrDeviceList filterKeyName:(NSString*)sortKeyName ascending:(BOOL)isAscending{
    
    NSSortDescriptor *sorter = [[NSSortDescriptor alloc] initWithKey:sortKeyName ascending:isAscending];
    [arrDeviceList sortUsingDescriptors:[NSArray arrayWithObject:sorter]];
    
    return arrDeviceList;
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



//-(void)viewDidAppear:(BOOL)animated
//{
//    self.tableView.estimatedRowHeight = 70.0; // for example. Set your average height
//    self.tableView.rowHeight = UITableViewAutomaticDimension;
//    [self.tableView layoutIfNeeded];
//    [self.tableView autoresizingMask];
//    [self.tableView reloadData];
//}


//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    NSString *testeDoTipo = [NSString stringWithFormat:@"%@",[[myData[1][_viagemEscolhida][@"momento"] objectAtIndex:indexPath.row] objectForKey: @"tipo"]];
//    if ([testeDoTipo isEqualToString:@"imagem"]) {
//        int  height = (int) _celulaPrototipo.image.size.height;
//        _celulaPrototipo.bounds = CGRectMake(0.0f, 0.0f, CGRectGetWidth(tableView.bounds), height);
//        
//        [_celulaPrototipo layoutIfNeeded];
//        return _celulaPrototipo.image.size.height+1;
//    }
//    return 70;
//}

//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    NSString *testeDoTipo = [NSString stringWithFormat:@"%@",[[myData[1][_viagemEscolhida][@"momento"] objectAtIndex:indexPath.row] objectForKey: @"tipo"]];
//
//    return UITableViewAutomaticDimension;
//}


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

-(BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    NSString *stringToMove = [myData[1][_viagemEscolhida][@"momento"] objectAtIndex:sourceIndexPath.row];
    [myData[1][_viagemEscolhida][@"momento"] removeObjectAtIndex:sourceIndexPath.row];
    [myData[1][_viagemEscolhida][@"momento"] insertObject:stringToMove atIndex:destinationIndexPath.row];
    [self atualizartabela];
}


-(IBAction)SalvarTexto:(id)sender{
    if (!(_myTextField.text.length == 0)) {
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
        editarViagem = [[UIBarButtonItem alloc] initWithTitle:@"\u2699" style:UIBarButtonItemStyleDone target:self action:@selector(editarViagem:)];
        
        [self.navigationItem setRightBarButtonItem:editarViagem];
        editarViagem.enabled =true;
        editarViagem.tintColor = [UIColor whiteColor];
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Atenção"
                                                        message:@"Insira um texto para adicionar o momento"
                                                       delegate:self
                                              cancelButtonTitle:@"ok" otherButtonTitles:nil];
        [alert show];

    
    
    
    }

}



//- (IBAction)buttonOk:(id)sender {
//    CGRect newFrame = _myView2.frame;
//    newFrame.size.height = 38;
//    
//    [UIView animateWithDuration:0.5
//                     animations:^{
//                         _myView2.frame = newFrame;
//                     }];
//    [self armazenarDadosViagemnome:_myTextField.text];
//    [_myTextField resignFirstResponder];
//    _myTextField.text = nil;
//    self.navigationItem.rightBarButtonItem.tintColor = [UIColor clearColor];
//    self.navigationItem.rightBarButtonItem.enabled = NO;
//}

- (IBAction)addText2:(id)sender {
    [self mudarTabela];
    salvarTexto = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(SalvarTexto:)];
    
    [self.navigationItem setRightBarButtonItem:salvarTexto];
    
    salvarTexto.enabled =true;
    salvarTexto.tintColor = [UIColor whiteColor];
    
    

}

- (IBAction)AddButtonCancel:(id)sender;
{
    CGRect newFrame = _myView2.frame;
    newFrame.size.height = 38;
    
    [UIView animateWithDuration:0.5
                     animations:^{
                         _myView2.frame = newFrame;
                     }];
    [_myTextField resignFirstResponder];
    _myTextField.text = nil;
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor clearColor];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor clearColor];
    editarViagem = [[UIBarButtonItem alloc] initWithTitle:@"\u2699" style:UIBarButtonItemStyleDone target:self action:@selector(editarViagem:)];
    
    [self.navigationItem setRightBarButtonItem:editarViagem];
    editarViagem.enabled =true;
    editarViagem.tintColor = [UIColor whiteColor];

}

- (IBAction)Back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
