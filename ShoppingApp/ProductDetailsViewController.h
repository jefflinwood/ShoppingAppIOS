//
//  ProductDetailsViewController.h
//  ShoppingApp
//
//  Created by Jeffrey Linwood on 12/10/12.
//  Copyright (c) 2012 Biscotti Labs, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ProductDisplay;

@interface ProductDetailsViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UIImageView *productImageView;

- (void) setProductDisplay:(ProductDisplay*)productDisplay;

@end
