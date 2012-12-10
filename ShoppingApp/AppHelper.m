//
//  AppHelper.m
//  ShoppingApp
//
//  Created by Jeffrey Linwood on 12/10/12.
//  Copyright (c) 2012 Biscotti Labs, LLC. All rights reserved.
//

#import "AppHelper.h"

@implementation AppHelper


// helper method to get field values from Drupal 7 JSON nodes
+ (NSString*) extractDrupalFieldValue:(NSDictionary*) node fieldName:(NSString*)fieldName fieldAttr:(NSString*)fieldAttr {
    
    NSDictionary *field = node[fieldName];
    if (field == nil) {
        return nil;
    }
    
    NSDictionary *und = field[@"und"];
    if (und == nil) {
        return nil;
    }
    
    return und[fieldAttr];

}

+ (NSArray*) extractDrupalFieldArray:(NSDictionary*) node fieldName:(NSString*)fieldName  {
    
    NSDictionary *field = node[fieldName];
    if (field == nil) {
        return nil;
    }
    
    return field[@"und"];
}

+ (NSString*) uriForDrupalUri:(NSString*)drupalUri {
    return [drupalUri stringByReplacingOccurrencesOfString:@"public://" withString:@"http://commerce.localhost:8082/sites/commerce.localhost/files/styles/product_thumbnail/public/"];
}

@end
