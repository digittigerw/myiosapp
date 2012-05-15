//
//  Smiley_ViewController.h
//  Smiley
//
//  Created by Ling Wang on 1/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SmileyViewController : UIViewController <UISplitViewControllerDelegate>

// value: 0 - 99 : sad - happy
@property (nonatomic) int happiness;

@end
