//
//  TimeLineTableViewController.h
//  TravelLine
//
//  Created by Leonardo Geus on 21/04/15.
//  Copyright (c) 2015 Leonardo Geus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TimeLineTableViewController : UITableViewController
- (IBAction)clickAddMomento:(id)sender;



@property (weak, nonatomic) IBOutlet UIView *myView2;

- (IBAction)addText2:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *addImage;

@property (weak, nonatomic) IBOutlet UITextView *myTextField;

@property NSInteger viagemEscolhida;
-(void)mudarTabela;
@end
