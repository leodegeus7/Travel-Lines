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

- (IBAction)addTexto:(id)sender;

- (IBAction)addFoto:(id)sender;

@property NSInteger viagemEscolhida;
@end
