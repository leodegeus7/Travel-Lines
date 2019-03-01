//
//  ZoomImageViewController.m
//  TravelLine
//
//  Created by Leonardo Geus on 30/04/15.
//  Copyright (c) 2015 Leonardo Geus. All rights reserved.
//

#import "ZoomImageViewController.h"
#import "DataManager.h"

@interface ZoomImageViewController (){
    DataManager *_data;
}

@end

@implementation ZoomImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _data = [DataManager sharedManager];
    NSLog(@"%ld",_viagemEscolhida);
    NSString *nome = [NSString stringWithFormat:@"%@",_data.dados[@"viagem"][_viagemEscolhida][@"momento"][_rowSelecionada][@"imagem"]];
    NSString *caminho= [self acharoarqfile:nome];
    _imageZoom.image = [self loadImage:caminho];
    // Do any additional setup after loading the view.
    _imageZoom.contentMode = UIViewContentModeScaleAspectFit;
    
    NSArray *quebrar = [_data.dados[@"viagem"][_viagemEscolhida][@"momento"][_rowSelecionada][@"data"] componentsSeparatedByString: @"T"];
    NSArray *tirarLixo = [quebrar[1] componentsSeparatedByString: @"."];
    _labelData.text = [NSString stringWithFormat:@"%@\n%@",quebrar[0], tirarLixo[0]];
    _labelData.numberOfLines = 2;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString *)acharoarqfile:(NSString *)file{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectoryPath = [paths objectAtIndex:0];
    NSString *destinationPath = [documentDirectoryPath stringByAppendingPathComponent:file];
    NSLog(@"File: %@", destinationPath);
    return destinationPath;
    
}


- (UIImage*)loadImage:(NSString *)caminho;
{
    UIImage* image = [UIImage imageWithContentsOfFile:caminho];
    return image;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
