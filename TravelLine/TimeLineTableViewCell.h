//
//  TimeLineTableViewCell.h
//  TravelLine
//
//  Created by Leonardo Geus on 21/04/15.
//  Copyright (c) 2015 Leonardo Geus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TimeLineTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *textfieldMomento;

@property (weak, nonatomic) IBOutlet UIView *primeiraLinhaTimeLine;
@property (weak, nonatomic) IBOutlet UIView *segundaLinhaTimeLine;


@end
