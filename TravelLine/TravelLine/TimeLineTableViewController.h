//
//  TimeLineTableViewController.h
//  TravelLine
//
//  Created by Leonardo Geus on 21/04/15.
//  Copyright (c) 2015 Leonardo Geus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TimeLineTableViewCell.h"

@interface TimeLineTableViewController : UITableViewController <UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic, strong) TimeLineTableViewCell *celulaPrototipo;




@property (weak, nonatomic) IBOutlet UIView *myView2;

@property (weak, nonatomic) IBOutlet UINavigationItem *titleView;


- (IBAction)addText2:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *addImage;

@property (weak, nonatomic) IBOutlet UITextView *myTextField;

-(IBAction)AddButtonCancel:(id)sender;

@property NSInteger viagemEscolhida;
-(void)mudarTabela;
@end
