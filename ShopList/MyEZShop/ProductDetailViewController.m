//
//  ProductDetailViewController.m
//  MyEZShop
//
//  Created by  on 5/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ProductDetailViewController.h"
#import "Product.h"

@interface ProductDetailViewController()

@property (retain, nonatomic) Product* currentProduct;

@property (retain, nonatomic) IBOutlet UITextField *textField_name;
@property (retain, nonatomic) IBOutlet UITextField *textField_category;

@end

@implementation ProductDetailViewController

@synthesize currentProduct;
@synthesize textField_name;
@synthesize textField_category;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.textField_name.text = self.currentProduct.name;
    
    self.textField_category.text = self.currentProduct.category;
}

- (void)viewDidUnload
{
    [self setTextField_name:nil];
    [self setTextField_category:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    [textField_name release];
    [textField_category release];
    [super dealloc];
}

- (void)setProduct:(Product *)product
{
    self.currentProduct = product;
}
@end
