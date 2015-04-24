//
//  PaisesTableViewCell.m
//  TravelLine
//
//  Created by Leonardo Geus on 17/04/15.
//  Copyright (c) 2015 Leonardo Geus. All rights reserved.
//

#import "PaisesTableViewCell.h"
#import "AddLugarViewController.h"

@interface PaisesTableViewCell () {
    AddLugarViewController *_addLugar;
}

@end

@implementation PaisesTableViewCell

- (void)awakeFromNib {
    [[AddLugarViewController alloc]init];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



@end
