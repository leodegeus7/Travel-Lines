//
//  CreditosViewController.m
//  TravelLine
//
//  Created by Leonardo Geus on 25/04/15.
//  Copyright (c) 2015 Leonardo Geus. All rights reserved.
//

#import "CreditosViewController.h"
#import "AddLugarViewController.h"
#import "DataManager.h"
#import "item.h"
#import "PaisesTableViewController.h"
#import "PaisesTableViewCell.h"


@interface CreditosViewController (){
    item *Item;
    PaisesTableViewController *_paises;
    PaisesTableViewCell *_paisesCell;
    DataManager *_data;
}

@end

@implementation CreditosViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    Item = [[item alloc]init];
    _paises = [[PaisesTableViewController alloc]init];
    _data = [DataManager sharedManager];
    
    
    
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


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:NULL];
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}







@end

