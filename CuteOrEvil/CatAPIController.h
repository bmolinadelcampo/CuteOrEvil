//
//  CatAPIController.h
//  CuteOrEvil
//
//  Created by Belén Molina del Campo on 06/05/2016.
//  Copyright © 2016 Belén Molina del Campo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol ImageFeedDelegate

- (void)didReceiveImage:(UIImage *)image;

@end

@interface CatAPIController : NSObject <NSXMLParserDelegate>
@property (weak, nonatomic) id <ImageFeedDelegate> delegate;

- (void)getCatImages;

@end
