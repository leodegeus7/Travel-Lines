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
#import "CRGradientNavigationBar.h"


@interface PaisesTableViewController (){
    NSArray *myData;
    DataManager *_data; 
    NSArray *viagem;
    item *Item;
    UIToolbar *toolBar;
    UIBarButtonItem *addButton;
    UIBarButtonItem *editarViagem;
    NSString *fileText;
    NSString *fileTitle;
    NSMutableArray *fileNameList;
    NSMutableArray *fileObjectList;
    UIRefreshControl *refreshControl;
    
}

@end

@implementation PaisesTableViewController



@synthesize managedObjectContext;

- (void)viewDidLoad {


    [super viewDidLoad];
//    [self testariCloud];
    Item = [[item alloc]init];
    _data = [DataManager sharedManager]; //da um sharedmanager no ponteiro do DM
    [self atualizartabela];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeInfoDark];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    [btn addTarget:self action:@selector(showInfoScreen) forControlEvents:UIControlEventTouchUpInside];

    UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressRecognizer:)];
    [self.tableView addGestureRecognizer:longPressGesture];
    longPressGesture.minimumPressDuration = 1.0f;
    UIImage *toolbar = [UIImage imageNamed:@"novaToolbar.png"];
    UIImage *toolbarMexida = [self imageWithImage:toolbar scaledToSize:CGSizeMake(200, 160)];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:toolbarMexida];
    imageView.contentMode = UIViewContentModeCenter;
    self.navigationItem.titleView = imageView;
    
    UIImage *itemCamera = [UIImage imageNamed:@"Camera Roll.png"];
    UIImage *itemMexido = [self imageWithImage:itemCamera scaledToSize:CGSizeMake(35, 35)];
    UIButton *botaoCamera;
    [botaoCamera setBackgroundImage:itemMexido forState:UIControlStateSelected];
    [botaoCamera setBackgroundImage:itemMexido forState:UIControlStateHighlighted];
    
    self.navigationController.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
    self.navigationController.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
    
    [[UIBarButtonItem appearance] setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    
    _itemBottom.image = itemMexido;

    
#pragma park  ALTERAR BACKGROUND DA VIEW
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:117.0/255.0 green:4.0/255.0 blue:32.0/255.0 alpha:1];
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:1];

    self.navigationController.toolbar.barTintColor = [UIColor colorWithRed:117.0/255.0 green:4.0/255.0 blue:32.0/255.0 alpha:1];

    [self.navigationController.toolbar setBackgroundImage:[UIImage imageNamed:@"fundoGradienteBaixo.jpg"] forToolbarPosition:UIToolbarPositionAny barMetrics:UIBarMetricsDefault];
    self.navigationController.toolbar.alpha= 0 ;

}











- (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {

    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
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
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeInfoDark];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
        [btn addTarget:self action:@selector(showInfoScreen) forControlEvents:UIControlEventTouchUpInside];
        

        
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
    myData = [_data.dados allValues];
    PaisesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellViagem" forIndexPath:indexPath];
    NSMutableDictionary *teste;
    teste = _data.dados;
    NSString *nomeArquivo = [NSString stringWithFormat:@"%@",[[_data.dados[@"viagem"]  objectAtIndex:indexPath.row] objectForKey: @"capa" ]];
    NSString *caminho = [item acharoarqfile:nomeArquivo];

    NSLog(@"%@",caminho);
    cell.viagemImage2.image = [self loadImage:caminho];
       cell.viagemLabel.text=[NSString stringWithFormat:@"%@",[[_data.dados[@"viagem"]  objectAtIndex:indexPath.row] objectForKey: @"nome"]];
    cell.anoLabel.text=[NSString stringWithFormat:@"%@",[[_data.dados[@"viagem"]  objectAtIndex:indexPath.row] objectForKey: @"ano"]];

    return cell;
}

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

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    NSString *stringToMove = [myData[1] objectAtIndex:sourceIndexPath.row];
    [myData[1] removeObjectAtIndex:sourceIndexPath.row];
    [myData[1] insertObject:stringToMove atIndex:destinationIndexPath.row];
    [self atualizartabela];
}

-(void)viewWillAppear:(BOOL)animated{
    [self atualizartabela];
    _data.temFoto=false;

    [self.navigationController setToolbarHidden:NO animated:YES];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.navigationController setToolbarHidden:YES animated:YES];
}



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

#pragma mark Row reordering
// Determine whether a given row is eligible for reordering or not.
- (BOOL)tableView:(UITableView *)tableview canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}



@end
