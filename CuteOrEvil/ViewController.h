//
//  ViewController.h
//  CuteOrEvil
//
//  Created by Belén Molina del Campo on 06/05/2016.
//  Copyright © 2016 Belén Molina del Campo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MDCSwipeToChoose/MDCSwipeToChoose.h>

#import "CatAPIController.h"
#import "MDCSwipeToChooseView.h"
#import "ResultViewController.h"


@interface ViewController : UIViewController <ImageFeedDelegate, MDCSwipeToChooseDelegate>

- (void)didReceiveImage:(UIImage *)image;

@end

