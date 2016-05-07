//
//  ViewController.m
//  CuteOrEvil
//
//  Created by Belén Molina del Campo on 06/05/2016.
//  Copyright © 2016 Belén Molina del Campo. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (strong, nonatomic) CatAPIController *apiController;
@property (strong, readwrite) NSMutableArray *imageList;

- (IBAction)showNextPicture:(id)sender;
- (void)changeImage;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.apiController = [CatAPIController new];
    self.apiController.delegate = self;
    [self styleImageView:self.imageView];
    [self.apiController getCatImages];
}


- (IBAction)showNextPicture:(id)sender {
    
    if (self.imageList.count != 0) {
        self.imageView.image = self.imageList.firstObject;
        [self.imageList removeObjectAtIndex:0];
    }
}

- (void)didReceiveImage:(UIImage *)image
{
    if (!self.imageList) {
        self.imageList = [NSMutableArray new];
    }
    
    [self.imageList addObject:image];
    
    if (!self.imageView.image) {
        self.imageView.image = self.imageList.firstObject;
        [self.imageList removeObjectAtIndex:0];
    }
}

- (void)styleImageView:(UIImageView *)imageView
{
    imageView.layer.shadowOpacity = 0.70;
    imageView.layer.shadowRadius = 40;
    imageView.layer.shadowOffset = CGSizeMake(0, 0);
    
}

@end
