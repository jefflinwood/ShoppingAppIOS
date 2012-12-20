//
//  ExploreViewController.m
//  ShoppingApp
//
//  Created by Jeffrey Linwood on 12/10/12.
//  Copyright (c) 2012 Biscotti Labs, LLC. All rights reserved.
//

#import "ExploreViewController.h"

#import "AppHelper.h"
#import "AppData.h"
#import "AppNotifications.h"
#import "Image.h"
#import "Product.h"
#import "ProductDetailsViewController.h"
#import "ProductDisplay.h"
#import "ProductTableViewCell.h"
#import "UIImageView+AFNetworking.h"


@interface ExploreViewController ()
- (void) refreshProducts:(NSNotification*)notification;
@end

@implementation ExploreViewController

- (void) refreshProducts:(NSNotification*)notification {
    [self.tableView reloadData];
}

#pragma mark UITableViewDataSource methods

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 
    ProductTableViewCell *cell = (ProductTableViewCell*) [tableView dequeueReusableCellWithIdentifier:@"ProductCell" forIndexPath:indexPath];
    
    //set up for reuse
    cell.productTitleLabel.text = nil;
    cell.productImageView.image = nil;
    
    //get data
    ProductDisplay *productDisplay = [[AppData sharedInstance] exploreProductDisplays][indexPath.row];
                                      
    //fill in data on cell
    cell.productTitleLabel.text = productDisplay.title;
    
    //get the first product for a product display
    Product *product = [[AppData sharedInstance] firstProduct:productDisplay];
    if (product.images != nil && [product.images count] > 0) {
        Image *image = product.images[0];
        NSString *imageUri = [AppHelper uriForDrupalUri:image.drupalUri];
        [cell.productImageView setImageWithURL:[NSURL URLWithString:imageUri]];
    }
    
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[[AppData sharedInstance] exploreProductDisplays] count];
    ;
}

#pragma mark UITableViewDelegate methods
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    ProductDetailsViewController *vc = [[self storyboard] instantiateViewControllerWithIdentifier:@"ProductDetails"];
    ProductDisplay *productDisplay = [[AppData sharedInstance] exploreProductDisplays][indexPath.row];
    [vc setProductDisplay:productDisplay];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark UIViewController methods

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshProducts:) name:PRODUCT_DISPLAYS_RELOADED object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshProducts:) name:PRODUCTS_RELOADED object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setTableView:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super viewDidUnload];
}
@end
