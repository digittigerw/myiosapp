//
//  Smiley_ViewController.m
//  Smiley
//
//  Created by Ling Wang on 1/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SmileyViewController.h"
#import "FaceView.h"
#import "SmileDisplayerProtocol.h"

@interface SmileyViewController()

@property (weak, nonatomic) IBOutlet FaceView *faceView;

@property (weak, nonatomic) id <SmileDisplayer> smileDisplayer;

@end


@implementation SmileyViewController

@synthesize happiness = _happiness;
@synthesize faceView = _faceView;
@synthesize smileDisplayer = _smileDisplayer;

-(void)setHappiness:(int)happiness {
    _happiness = happiness;
    if (self.smileDisplayer)
        [self.smileDisplayer showHappiness:happiness];
}

- (void)setFaceView:(FaceView *)faceView
{
    _faceView = faceView;
    
    // set the faceView as our smile displayer.
    _smileDisplayer = faceView;
    
    // Allow the faceView to honor Pinch gesture
    //
    UIGestureRecognizer* gr = 
        [[UIPinchGestureRecognizer alloc] initWithTarget:self.faceView action:@selector(pinch:)];
    
    [self.faceView addGestureRecognizer:gr];
    
    // Allow self to honor 
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
//    [self setFaceView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
    
    // Return YES for supported orientations
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

#pragma mark - SplitViewControllerDelegate
- (BOOL)splitViewController:(UISplitViewController *)svc shouldHideViewController:(UIViewController *)vc inOrientation:(UIInterfaceOrientation)orientation {
    if (orientation == UIInterfaceOrientationPortrait)
        return YES;
    
    return NO;
}


@end
