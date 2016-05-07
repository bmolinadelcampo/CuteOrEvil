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
- (IBAction)tryAgain:(id)sender;

@end

@implementation ResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.resultLabel.text = self.resultString;
    if ([self.resultString isEqualToString:@"EVIL"]) {
        self.view.backgroundColor = [UIColor redColor];
    }else
    {
        self.view.backgroundColor = [UIColor colorWithRed:1.00 green:0.80 blue:0.96 alpha:1.00];
    }
}

- (IBAction)tryAgain:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        NSLog(@"Me voy!");
    }];
}

@end
