//
//  ProductTableViewCell.h
//  ShoppingApp
//
//  Created by Jeffrey Linwood on 12/10/12.
//  Copyright (c) 2012 Biscotti Labs, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *productTitleLabel;
@property (strong, nonatomic) IBOutlet UIImageView *productImageView;

@end
