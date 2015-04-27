//
//  EditarViagemViewController.h
//  TravelLine
//
//  Created by Leonardo Geus on 26/04/15.
//  Copyright (c) 2015 Leonardo Geus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditarViagemViewController : UIViewController <UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIPickerViewDataSource,UIPickerViewDelegate>

@property NSInteger viagemEscolhidaEditar;
@property (weak, nonatomic) IBOutlet UIImageView *imagePais;
@property (weak, nonatomic) IBOutlet UITextField *textfieldPais;
@property (weak, nonatomic) IBOutlet UITextField *textfieldAno;
- (IBAction)addPais:(id)sender;

@property (weak, nonatomic) IBOutlet UIPickerView *picker;


@end
