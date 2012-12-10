//
//  AppData.m
//  ShoppingApp
//
//  Created by Jeffrey Linwood on 12/10/12.
//  Copyright (c) 2012 Biscotti Labs, LLC. All rights reserved.
//

#import "AppData.h"

#import "AFNetworking.h"

@interface AppData ()
//array of ProductDisplay objects
@property (nonatomic, strong) NSArray *productDisplays;

//key is nid (as NSString), value is Product object
@property (nonatomic, strong) NSDictionary *products;

- (void) loadDisplayProducts;
- (void) loadProducts;

@end

@implementation AppData


static AppData *sharedData = nil;

#pragma mark Drupal Commerce Networking methods

- (NSString*) baseURL {
    return  @"http://commerce.localhost:8082/rest";
}

- (void) loadDisplayProducts {
    
}

- (void) loadProducts {
    
}

#pragma mark Singleton method

//Anything we need to do to initialize the shared data singleton can go here.
+ (AppData*) sharedInstance
{
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedData = [[AppData alloc] init];
        [sharedData loadDisplayProducts];
        [sharedData loadProducts];
    });
    return sharedData;
}
@end
