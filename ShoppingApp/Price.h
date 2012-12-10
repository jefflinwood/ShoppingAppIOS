//
//  Price.h
//  ShoppingApp
//
//  Created by Jeffrey Linwood on 12/10/12.
//  Copyright (c) 2012 Biscotti Labs, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Price : NSObject
@property (nonatomic, strong) NSNumber *amount;
@property (nonatomic, strong) NSString *currency;
@end
