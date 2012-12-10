//
//  AppHelper.h
//  ShoppingApp
//
//  Created by Jeffrey Linwood on 12/10/12.
//  Copyright (c) 2012 Biscotti Labs, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppHelper : NSObject
+ (NSString*) extractDrupalFieldValue:(NSDictionary*) node fieldName:(NSString*)fieldName fieldAttr:(NSString*)fieldAttr;
+ (NSArray*) extractDrupalFieldArray:(NSDictionary*) node fieldName:(NSString*)fieldName;

+ (NSString*) uriForDrupalUri:(NSString*)drupalUri;
@end
