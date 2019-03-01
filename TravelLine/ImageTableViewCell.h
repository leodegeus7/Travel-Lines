//
//  ImageTableViewCell.h
//  TravelLine
//
//  Created by Leonardo Koppe Malanski on 24/04/15.
//  Copyright (c) 2015 Leonardo Geus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageMomento;

@property (weak, nonatomic) IBOutlet UIView *segundaLinhaTimeLine;
@property (weak, nonatomic) IBOutlet UIView *primeiraLinhaTimeLine;

@end
