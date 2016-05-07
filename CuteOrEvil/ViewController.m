//
//  ViewController.m
//  CuteOrEvil
//
//  Created by Belén Molina del Campo on 06/05/2016.
//  Copyright © 2016 Belén Molina del Campo. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIView *containerSwipableView;

@property (strong, nonatomic) CatAPIController *apiController;
@property (strong, readwrite) NSMutableArray *imageList;
@property (strong, nonatomic) UIImage *currentImage;
@property (strong, nonatomic) NSNumber *cuteCount;
@property (strong, nonatomic) NSNumber *evilCount;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.apiController = [CatAPIController new];
    self.apiController.delegate = self;
    
//    [self styleImageView:self.swipableView.imageView];
    [self.apiController getCatImages];
}


//- (void)showNextPicture:(id)sender {
//    
//    if (self.imageList.count != 0) {
//        self.swipableView.imageView.image = self.imageList.firstObject;
//        [self.imageList removeObjectAtIndex:0];
//    }
//}

- (void)didReceiveImage:(UIImage *)image
{
    if (!self.imageList) {
        self.imageList = [NSMutableArray new];
    }
    
    [self.imageList addObject:image];
    
    if (!self.currentImage) {
        [self configureSwipableViewWithImage:image];
        [self.imageList removeObject:image];
    }
}

- (void)styleImageView:(UIImageView *)imageView
{
    imageView.layer.shadowOpacity = 0.70;
    imageView.layer.shadowRadius = 40;
    imageView.layer.shadowOffset = CGSizeMake(0, 0);
    
}

- (void)view:(MDCSwipeToChooseView *)view wasChosenWithDirection:(MDCSwipeDirection)direction {
    if (self.imageList.count != 0) {
        [self.imageList removeObject: view.imageView.image];

        [self configureSwipableViewWithImage:self.imageList.firstObject];
    }

    if (direction == MDCSwipeDirectionLeft) {
        NSLog(@"Gato meno!");
    } else {
        NSLog(@"Gato mao!");
    }
}

- (void)configureSwipableViewWithImage:(UIImage *)image
{
    MDCSwipeToChooseViewOptions *options = [MDCSwipeToChooseViewOptions new];
    options.likedText = @"Evil";
    options.likedColor = [UIColor redColor];
    options.nopeText = @"Cute";
    options.nopeColor = [UIColor whiteColor];
    options.delegate = self;
    
    options.onPan = ^(MDCPanState *state){
        if (state.thresholdRatio == 1.f && state.direction == MDCSwipeDirectionLeft) {
            NSLog(@"Let go now to delete the photo!");
        }
    };
    
    MDCSwipeToChooseView *view = [[MDCSwipeToChooseView alloc] initWithFrame:self.containerSwipableView.bounds
                                                                     options:options];
    self.currentImage = self.imageList.firstObject;
    view.imageView.image = self.currentImage;
    [self.containerSwipableView addSubview:view];
}
@end
