//
//  AddFotoTableViewController.h
//  TravelLine
//
//  Created by Leonardo Geus on 26/04/15.
//  Copyright (c) 2015 Leonardo Geus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddFotoTableViewController : UITableViewController <UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>



@property (weak, nonatomic) IBOutlet UIView *myView2;

@property (weak, nonatomic) IBOutlet UINavigationItem *titleView;



@property (weak, nonatomic) IBOutlet UITextView *myTextField;

@property NSInteger viagemEscolhida;
-(void)mudarTabela;
@property NSInteger viagemEscolhidaEditar;
@end