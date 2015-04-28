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
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    [btn addTarget:self action:@selector(showInfoScreen) forControlEvents:UIControlEventTouchUpInside];

    UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressRecognizer:)];
    [self.tableView addGestureRecognizer:longPressGesture];
    longPressGesture.minimumPressDuration = 1.0f;
    UIImage *toolbar = [UIImage imageNamed:@"novaToolbar.png"];
    UIImage *toolbarMexida = [self imageWithImage:toolbar scaledToSize:CGSizeMake(200, 130)];
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:toolbarMexida];
    
    UIImage *itemCamera = [UIImage imageNamed:@"Camera Roll.png"];
    UIImage *itemMexido = [self imageWithImage:itemCamera scaledToSize:CGSizeMake(35, 35)];
    UIButton *botaoCamera;
    [botaoCamera setBackgroundImage:itemMexido forState:UIControlStateSelected];
    [botaoCamera setBackgroundImage:itemMexido forState:UIControlStateHighlighted];
    
    
    _itemBottom.image = itemMexido;
    
#pragma park  ALTERAR BACKGROUND DA VIEW
//    UIImageView *tempImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 460)];
//    [tempImg setImage:[UIImage imageNamed:@"IMG_0071.JPG"]];
//    [testTableView setBackgroundView:tempImg];

    
//    UIColor *firstColor = [UIColor colorWithRed:255.0f/255.0f green:42.0f/255.0f blue:104.0f/255.0f alpha:1.0f];
//    UIColor *secondColor = [UIColor colorWithRed:255.0f/255.0f green:90.0f/255.0f blue:58.0f/255.0f alpha:1.0f];
//    
//    NSArray *colors = [NSArray arrayWithObjects:(id)firstColor.CGColor, (id)secondColor.CGColor, nil];
//    //NSArray *colors = [NSArray arrayWithObjects:(id)UIColorFromRGB(0xf16149).CGColor, (id)UIColorFromRGB(0xf14959).CGColor, nil];
//
//    [[CRGradientNavigationBar appearance] setBarTintGradientColors:colors];
//    [[self.navigationController navigationBar] setTranslucent:NO]; // Remember, the default value is YES.

//    
//      UIColor *firstColor = [UIColor colorWithRed:0.0f/255.0f green:0.0f/255.0f blue:0.0f/255.0f alpha:1.0f];
//      UIColor *secondColor = [UIColor colorWithRed:255.0f/255.0f green:90.0f/255.0f blue:58.0f/255.0f alpha:1.0f];
//      CAGradientLayer *gradient = [CAGradientLayer layer];
//      gradient.frame = self.navigationController.navigationBar.bounds;
//      gradient.colors = [NSArray arrayWithObjects:(id)[firstColor CGColor], (id)[secondColor CGColor], nil];
//    
//      [self.navigationController.navigationBar.layer insertSublayer:gradient atIndex:0];    
    
    
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:117.0/255.0 green:4.0/255.0 blue:32.0/255.0 alpha:1];
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:1];

    self.navigationController.toolbar.barTintColor = [UIColor colorWithRed:117.0/255.0 green:4.0/255.0 blue:32.0/255.0 alpha:1];

    [self.navigationController.toolbar setBackgroundImage:[UIImage imageNamed:@"fundoGradienteBaixo.jpg"] forToolbarPosition:UIToolbarPositionAny barMetrics:UIBarMetricsDefault];
    self.navigationController.toolbar.alpha= 0 ;



    
    

    
    
    
    

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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
        addButton.tintColor = [UIColor blueColor];
        
        
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
    //cell.viagemLabel.text=[NSString stringWithFormat:@"%@",myData[indexPath.row][@"nome"]];
    NSString *nomeArquivo = [NSString stringWithFormat:@"%@",[[myData[1] objectAtIndex:indexPath.row] objectForKey: @"capa" ]];
    NSString *caminho = [item acharoarqfile:nomeArquivo];
    //NSString *caminho = [[myData[1] objectAtIndex:indexPath.row] objectForKey: @"capa"];
    NSLog(@"%@",caminho);
    cell.viagemImage2.image = [self loadImage:caminho];
    UIImage *testeF = [self loadImage:caminho];
    NSLog(@"%@", testeF);
    cell.viagemLabel.text=[NSString stringWithFormat:@"%@",[[myData[1] objectAtIndex:indexPath.row] objectForKey: @"nome"]];
    cell.anoLabel.text=[NSString stringWithFormat:@"%@",[[myData[1] objectAtIndex:indexPath.row] objectForKey: @"ano"]];

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

#pragma mark Row reordering
// Determine whether a given row is eligible for reordering or not.
- (BOOL)tableView:(UITableView *)tableview canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
//- (void) tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)targetIndexPath
//{
//    NSUInteger sourceIndex = [sourceIndexPath row];
//    NSUInteger targetIndex = [targetIndexPath row];
//    if (sourceIndex != targetIndex)
//    {
//        NSLog(@"LOOOOOCOOO");
//    }
//}


@end
