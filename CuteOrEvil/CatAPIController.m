//
//  CatAPIController.m
//  CuteOrEvil
//
//  Created by Belén Molina del Campo on 06/05/2016.
//  Copyright © 2016 Belén Molina del Campo. All rights reserved.
//

#import "CatAPIController.h"


@interface CatAPIController ()

@property (strong, nonatomic) NSMutableString *imageURLString;
@property (strong, nonatomic) NSMutableArray *imageURLsList;
@property (strong, nonatomic) NSURLSession *session;

@end

@implementation CatAPIController

#pragma  mark - Public Methods

- (void)getCatImages
{
    if (!self.imageURLsList) {
        self.imageURLsList = [[NSMutableArray alloc] initWithCapacity:0];
    }
    else
    {
        [self.imageURLsList removeAllObjects];
    }
    
    NSString *numberOfImages = @"10";
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://thecatapi.com/api/images/get?format=xml&type=jpg,png&results_per_page=%@", numberOfImages]];
    
    self.session = [NSURLSession sharedSession];
    NSURLSessionDataTask *downloadDataTask = [self.session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSXMLParser *parser = [[NSXMLParser alloc] initWithData:data];
        [parser setDelegate: self];
        [parser parse];
        NSLog(@"%@", self.imageURLsList);
        
        [self downloadImages];
        
    }];
    
    [downloadDataTask resume];
}

#pragma mark - XML Parser Delegate Methds

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if ([elementName isEqualToString:@"url"]) {
        self.imageURLString = [NSMutableString new];
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    [self.imageURLString appendString:string];
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if ([elementName isEqualToString:@"url"]) {
        
        [self.imageURLsList addObject:[NSURL URLWithString:self.imageURLString]];
        self.imageURLString = nil;
    }
}

#pragma mark - Private Methods
- (void)downloadImages
{
    
    for (int i = 0; i < self.imageURLsList.count; i++) {
        
        if (self.session) {
            NSURL *url = self.imageURLsList[i];
            NSLog(@"URL: %@", url);
            NSURLSessionDownloadTask *downloadImageTask = [self.session downloadTaskWithURL:url completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
               
                if (!error) {
                    
                    NSData *data = [[NSData alloc] initWithContentsOfURL:url];
                    UIImage *image = [[UIImage alloc] initWithData:data];
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (image) {
                            [self.delegate didReceiveImage:image];
                        }
                        
                    });
                }
            }];
            
            [downloadImageTask resume];
        }
    }
}
@end
