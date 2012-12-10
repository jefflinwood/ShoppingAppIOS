//
//  ProductDisplay.h
//  ShoppingApp
//
//  Created by Jeffrey Linwood on 12/10/12.
//  Copyright (c) 2012 Biscotti Labs, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProductDisplay : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *nid;
@property (nonatomic, strong) NSString *body;
@property (nonatomic, strong) NSString *brandId;
@property (nonatomic, strong) NSString *categoryId;
@property (nonatomic, strong) NSString *collectionId;
@property (nonatomic, strong) NSString *genderId;

//Array of NSString product ids
@property (nonatomic, strong) NSArray *productIds;


@end
