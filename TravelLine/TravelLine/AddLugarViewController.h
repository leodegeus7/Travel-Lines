//
//  AddLugarViewController.h
//  TravelLine
//
//  Created by Leonardo Geus on 22/04/15.
//  Copyright (c) 2015 Leonardo Geus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddLugarViewController : UIViewController <UITextFieldDelegate,UIImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imagePais;
@property (weak, nonatomic) IBOutlet UITextField *textfieldPais;
@property NSInteger *viagemEscolhida;
- (IBAction)addPais:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *textFieldAno;
@end
