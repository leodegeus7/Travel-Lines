//
//  PaisesTableViewController.h
//  TravelLine
//
//  Created by Leonardo Geus on 17/04/15.
//  Copyright (c) 2015 Leonardo Geus. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface PaisesTableViewController : UITableViewController

@property (nonatomic,strong) NSManagedObjectContext* managedObjectContext;
@property (nonatomic,strong) NSArray* failedBankInfos;
@property NSInteger linhaEscolhida;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *itemBottom;


- (IBAction)ClickButtonAdd:(id)sender;
-(void)atualizartabela;

@end
