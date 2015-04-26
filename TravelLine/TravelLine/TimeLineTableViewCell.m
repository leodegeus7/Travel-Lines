//
//  TimeLineTableViewCell.m
//  TravelLine
//
//  Created by Leonardo Geus on 21/04/15.
//  Copyright (c) 2015 Leonardo Geus. All rights reserved.
//

#import "TimeLineTableViewCell.h"
#import "DataManager.h"
#import "AddLugarViewController.h"



@interface TimeLineTableViewCell (){
    DataManager * _data;
    AddLugarViewController *_addLugar;
    }

@end

@implementation TimeLineTableViewCell {
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _textfieldMomento.numberOfLines = 0;
   
    //[_textfieldMomento sizeToFit];
    NSLog(@"HEIGHT NA CELULA%f",_textfieldMomento.frame.size.height);
    
    [self.contentView layoutIfNeeded];
    self.textfieldMomento.preferredMaxLayoutWidth = CGRectGetWidth(self.textfieldMomento.frame);


  
}


@end
