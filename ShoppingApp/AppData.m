//
//  AppData.m
//  ShoppingApp
//
//  Created by Jeffrey Linwood on 12/10/12.
//  Copyright (c) 2012 Biscotti Labs, LLC. All rights reserved.
//

#import "AppData.h"

#import "AFNetworking.h"
#import "AppHelper.h"
#import "AppNotifications.h"
#import "Image.h"
#import "Price.h"
#import "ProductDisplay.h"
#import "Product.h"


@interface AppData ()
//array of ProductDisplay objects
@property (nonatomic, strong) NSArray *productDisplays;

//key is nid (as NSString), value is Product object
@property (nonatomic, strong) NSDictionary *products;

- (NSString*) baseURI;
- (void) loadProductDisplays;
- (void) loadProducts;

@end

@implementation AppData


static AppData *sharedData = nil;

- (Product*) firstProduct:(ProductDisplay*)productDisplay {
    //get the first product for a product display
    NSString *productId = productDisplay.productIds[0];
    Product *firstProduct = self.products[productId];
    return firstProduct;
}

- (NSArray*) exploreProductDisplays {
    return self.productDisplays;
}

#pragma mark Drupal Commerce Networking methods

- (NSString*) baseURI {
    return  @"http://commerce.localhost:8082/rest";
}

- (void) loadProductDisplays {
    NSString *uri = [NSString stringWithFormat:@"%@%@",[self baseURI], @"/product-display.json?flatten_fields=false&limit=100"];
    NSURL *url = [NSURL URLWithString:uri];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:urlRequest success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        NSDictionary *results = JSON;
        NSMutableArray *displays = [[NSMutableArray alloc] init];
        for (NSDictionary *result in [results allValues]) {
            ProductDisplay *display = [[ProductDisplay alloc] init];
            display.title = result[@"title"];
            display.nid = result[@"nid"];
            
            NSMutableArray *productIds = [[NSMutableArray alloc] init];
            NSArray *productsJSON = [AppHelper extractDrupalFieldArray:result fieldName:@"field_product"];
            for (NSDictionary *item in productsJSON) {
                NSString *productId = item[@"product_id"];
                [productIds addObject:productId];
            }
            display.productIds = productIds;
            
            [displays addObject:display];
        }
        self.productDisplays = displays;
        [[NSNotificationCenter defaultCenter] postNotificationName:PRODUCT_DISPLAYS_RELOADED object:nil];

    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        self.productDisplays = nil;
    }];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperation:operation];
}

- (void) loadProducts {
    NSString *uri = [NSString stringWithFormat:@"%@%@",[self baseURI], @"/product.json?flatten_fields=false&limit=100"];
    NSURL *url = [NSURL URLWithString:uri];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:urlRequest success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        NSDictionary *results = JSON;
        NSMutableDictionary *products = [[NSMutableDictionary alloc] init];
        for (NSDictionary *result in [results allValues]) {
            Product *product = [[Product alloc] init];
            product.title = result[@"title"];
            product.sku = result[@"sku"];
            product.productId = result[@"product_id"];
            
            NSMutableArray *productImages = [[NSMutableArray alloc] init];
            NSArray *imageJSON = [AppHelper extractDrupalFieldArray:result fieldName:@"field_images"];
            for (NSDictionary *item in imageJSON) {
                Image *image = [[Image alloc] init];
                image.drupalUri = item[@"uri"];
                [productImages addObject:image];
            }
            product.images = productImages;
            
            [products setObject:product forKey:product.productId];
        }
        self.products = products;
        [[NSNotificationCenter defaultCenter] postNotificationName:PRODUCTS_RELOADED object:nil];
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        self.products = nil;
    }];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperation:operation];

}

#pragma mark Singleton method

//Anything we need to do to initialize the shared data singleton can go here.
+ (AppData*) sharedInstance
{
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedData = [[AppData alloc] init];
        [sharedData loadProductDisplays];
        [sharedData loadProducts];
    });
    return sharedData;
}
@end
