//
//  AppData.h
//  ShoppingApp
//
//  Created by Jeffrey Linwood on 12/10/12.
//  Copyright (c) 2012 Biscotti Labs, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Product;
@class ProductDisplay;

@interface AppData : NSObject

- (NSArray*) exploreProductDisplays;
- (Product*) firstProduct:(ProductDisplay*)productDisplay;

//data singleton
+ (AppData*) sharedInstance;
@end
