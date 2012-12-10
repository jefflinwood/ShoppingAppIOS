//
//  Product.h
//  ShoppingApp
//
//  Created by Jeffrey Linwood on 12/10/12.
//  Copyright (c) 2012 Biscotti Labs, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Product : NSObject

@property (nonatomic, strong) NSString *sku;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *productId;

// Array of Price objects
@property (nonatomic, strong) NSArray *prices;

// Array of Image objects
@property (nonatomic, strong) NSArray *images;

@end
