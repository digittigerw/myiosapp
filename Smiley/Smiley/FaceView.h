//
//  FaceView.h
//  Smiley
//
//  Created by Ling Wang on 1/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SmileDisplayerProtocol.h"

@interface FaceView : UIView <SmileDisplayer>

- (void)pinch:(UIPinchGestureRecognizer*)gr;

@end
