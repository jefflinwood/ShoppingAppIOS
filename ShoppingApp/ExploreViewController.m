//
//  ExploreViewController.m
//  ShoppingApp
//
//  Created by Jeffrey Linwood on 12/10/12.
//  Copyright (c) 2012 Biscotti Labs, LLC. All rights reserved.
//

#import "ExploreViewController.h"


#import "AppData.h"
#import "AppNotifications.h"
#import "ProductTableViewCell.h"

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
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[[AppData sharedInstance] exploreProductDisplays] count];
    ;
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
    [self setProductTitleLabel:nil];
    [self setProductImageView:nil];
    [super viewDidUnload];
}
@end
