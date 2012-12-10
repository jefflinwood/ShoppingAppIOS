//
//  AppData.h
//  ShoppingApp
//
//  Created by Jeffrey Linwood on 12/10/12.
//  Copyright (c) 2012 Biscotti Labs, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppData : NSObject

- (NSArray*) exploreProductDisplays;

//data singleton
+ (AppData*) sharedInstance;
@end
