//
//  ProductDetailsViewController.m
//  ShoppingApp
//
//  Created by Jeffrey Linwood on 12/10/12.
//  Copyright (c) 2012 Biscotti Labs, LLC. All rights reserved.
//

#import "ProductDetailsViewController.h"

#import "AppData.h"
#import "AppHelper.h"
#import "Image.h"
#import "Product.h"
#import "ProductDisplay.h"
#import "UIImageView+AFNetworking.h"

@interface ProductDetailsViewController ()
@property (nonatomic, strong) ProductDisplay *productDisplay;
@end

@implementation ProductDetailsViewController

#pragma mark UIViewController methods
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.titleLabel.text = self.productDisplay.title;
    //get the first product for a product display
    Product *product = [[AppData sharedInstance] firstProduct:self.productDisplay];
    if (product.images != nil && [product.images count] > 0) {
        Image *image = product.images[0];
        NSString *imageUri = [AppHelper uriForDrupalUri:image.drupalUri];
        [self.productImageView setImageWithURL:[NSURL URLWithString:imageUri]];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setTitleLabel:nil];
    [self setProductImageView:nil];
    [self setAddToCartButton:nil];
    [self setDescriptionWebView:nil];
    [self setPriceLabel:nil];
    [super viewDidUnload];
}
- (IBAction)addToCart:(id)sender {
}
@end
