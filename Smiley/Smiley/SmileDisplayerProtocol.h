//
//  SmileDisplayerProtocol.h
//  Smiley
//
//  Created by Ling Wang on 2/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#ifndef Smiley_SmileDisplayerProtocol_h
#define Smiley_SmileDisplayerProtocol_h

@protocol SmileDisplayer

// happiness is (0, 100) => (very sad, very happy)
//
- (void)showHappiness:(int)happiness;

@end

#endif
