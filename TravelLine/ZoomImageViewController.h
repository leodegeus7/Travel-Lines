//
//  ZoomImageViewController.h
//  TravelLine
//
//  Created by Leonardo Geus on 30/04/15.
//  Copyright (c) 2015 Leonardo Geus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZoomImageViewController : UIViewController


@property NSInteger viagemEscolhidaEditar;
@property NSInteger viagemEscolhida;
@property NSInteger rowSelecionada;
@property (weak, nonatomic) IBOutlet UILabel *labelData;
@property (weak, nonatomic) IBOutlet UIImageView *imageZoom;

@end
