//
//  ResultViewController.m
//  CuteOrEvil
//
//  Created by Belén Molina del Campo on 07/05/2016.
//  Copyright © 2016 Belén Molina del Campo. All rights reserved.
//

#import "ResultViewController.h"

@interface ResultViewController ()

@property (weak, nonatomic) IBOutlet UILabel *resultLabel;
@property (weak, nonatomic) IBOutlet UILabel *catsAreLabel;
- (IBAction)tryAgain:(id)sender;

@end

@implementation ResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.resultLabel.text = self.resultString;
    
    UIImage *backgroundImage;


    if ([self.resultString isEqualToString:@"EVIL"]) {
        backgroundImage = [UIImage imageNamed:@"Evil"];
        self.resultLabel.textColor = [UIColor whiteColor];
        self.catsAreLabel.textColor = [UIColor whiteColor];
    }else
    {
        backgroundImage = [UIImage imageNamed:@"Cute"];
    }
    
    UIImageView *backgroundImageView =[[UIImageView alloc]initWithFrame:self.view.frame];
    backgroundImageView.image=backgroundImage;
    [self.view insertSubview:backgroundImageView atIndex:0];
}

- (IBAction)tryAgain:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        NSLog(@"Me voy!");
    }];
}

@end
