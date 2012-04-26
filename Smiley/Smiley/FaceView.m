//
//  FaceView.m
//  Smiley
//
//  Created by Ling Wang on 1/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FaceView.h"

@interface FaceView()
@property (nonatomic) CGRect faceRect;

@property (nonatomic) CGRect mouthRect; // area for changing smile

@property (nonatomic) float happiness;  // (-1, 1) => (very sad, very happy)

@end

@implementation FaceView

@synthesize faceRect = _faceRect;
@synthesize mouthRect = _mouthRect;
@synthesize happiness = _happiness;

- (void)setFaceRect:(CGRect)faceRect
{
    _faceRect = faceRect;
    [self setNeedsDisplay];
}

- (void)setHappiness:(float)happiness
{
    if (happiness > 1.0) happiness = 1;
    if (happiness < -1) happiness = -1;
    
    _happiness = happiness;
    
    [self setNeedsDisplay];    
}

- (void)setup 
{
    // indicates redraw on orientation change.
    self.contentMode = UIViewContentModeScaleAspectFill;
    
    // default to bounds of the view
    self.faceRect = self.bounds;
    
    // Register gestures we need to honor
    //
    UIGestureRecognizer* gr = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self addGestureRecognizer:gr];

    /* As exercise, we do this in ViewController.
    gr = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinch:)];
    [self addGestureRecognizer:gr];
    */
    
    gr = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(mySwipe:)];
    [self addGestureRecognizer:gr];

    gr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(myTap:)];
    ((UITapGestureRecognizer*)gr).numberOfTapsRequired = 2; // only honor double tap
    [self addGestureRecognizer:gr];

    NSArray* grs = self.gestureRecognizers;
    NSEnumerator* it = [grs objectEnumerator];
    id obj;
    while (obj = [it nextObject]) {
        NSLog(@"%@", [[obj class] description]);
    }
}

// For controller to change happiness.
// argument: 
//   happiness: 0 - 99
- (void)showHappiness:(int)happiness 
{
    // Convert to our scale
    self.happiness = (happiness % 100 - 50) / 50.0;
    
    [self setNeedsDisplay]; // redraw
}

- (void)awakeFromNib
{
    [self setup];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)pan:(UIPanGestureRecognizer*)gr 
{
    static BOOL draggingMouth = false;
    
    if (gr.state == UIGestureRecognizerStateBegan) {
        CGPoint startPoint = [gr locationOfTouch:0 inView:self];
        
        if (startPoint.x > self.mouthRect.origin.x &&
            startPoint.x < self.mouthRect.origin.x + self.mouthRect.size.width &&
            startPoint.y > self.mouthRect.origin.y &&
            startPoint.y < self.mouthRect.origin.y + self.mouthRect.size.height)
            draggingMouth = true;
    }

    if (gr.state == UIGestureRecognizerStateChanged || 
        gr.state == UIGestureRecognizerStateEnded) 
    {
        CGPoint translation = [gr translationInView:self];
        NSLog(@"panned: x = %f  y = %f NumbOfTouch = %d", translation.x, translation.y, gr.numberOfTouches);
        
        if (draggingMouth) {
            self.happiness += translation.y / 100;
            
            if (gr.state == UIGestureRecognizerStateEnded)
                draggingMouth = NO;
        }
        else {
            // dragging the whole face
            CGRect new = self.faceRect;
            new.origin.x += translation.x;
            new.origin.y += translation.y;
            
            self.faceRect = new; // redraw
        }

        // We need increments, so reset.
        [gr setTranslation:CGPointZero inView:self];
    }
}

- (void)mySwipe:(UISwipeGestureRecognizer*)gr 
{
    if (gr.state == UIGestureRecognizerStateEnded) 
    {
        NSLog(@"swiped");
    }
}

- (void)myTap:(UITapGestureRecognizer*)gr 
{
    if (gr.state == UIGestureRecognizerStateEnded) 
    {
        NSLog(@"tapped");
        self.happiness = 0;
    }
}

- (void)pinch:(UIPinchGestureRecognizer*)gr
{
    if (gr.state == UIGestureRecognizerStateChanged || 
        gr.state == UIGestureRecognizerStateEnded) 
    {
        CGRect new = self.faceRect;
        
        CGPoint center = new.origin;
        center.x += new.size.width/2;
        center.y += new.size.height/2;
        
        new.size.width *= gr.scale;
        new.size.height *= gr.scale;
        new.origin.x = center.x - new.size.width/2;
        new.origin.y = center.y - new.size.height/2;
        
        gr.scale = 1;

        // this will cause redraw
        self.faceRect = new;
    }
}

- (void)drawAndFillCircleAtPoint:(CGPoint)p withRadius:(CGFloat)r withContext:(CGContextRef)context
{
    CGContextBeginPath(context);
    CGContextAddArc(context, p.x, p.y, r, 0, 2*M_PI, YES);
    CGPathRef path = CGContextCopyPath(context);
    CGContextFillPath(context);
    CGContextAddPath(context, path);
    CGContextStrokePath(context);
}

//
// "happiness" is between (-1, 1), indicating sadness to happiness.
//
- (void)drawFaceInRect:(CGRect)rect withHappiness:(float)happiness withContext:(CGContextRef)context
{
    CGPoint center = CGPointMake(rect.origin.x + rect.size.width/2, rect.origin.y + rect.size.height/2);
    CGFloat r = MIN(rect.size.width, rect.size.height) / 2 - 10;
    
    // draw face
    CGContextSetLineWidth(context, 5.0);
    [[UIColor blueColor] setStroke];
    [[UIColor yellowColor] setFill];
    [self drawAndFillCircleAtPoint:center withRadius:r withContext:context];

    // draw eyes
    [[UIColor blackColor] setFill];
    CGRect left_eye_rect = CGRectMake(center.x - r/3, center.y - r/2, r/4, r/3);
    CGRect right_eye_rect = CGRectMake(center.x + r/3 - r/5, center.y - r/2, r/4, r/3);
    CGContextFillEllipseInRect(context, left_eye_rect);
    CGContextFillEllipseInRect(context, right_eye_rect);
    
    // draw mouth
    //
#define MOUSE_POS_V  r/4
    [[UIColor blackColor] setStroke];
    
    CGPoint mStart = CGPointMake(center.x - r*2/3, center.y + MOUSE_POS_V);
    CGPoint mEnd = CGPointMake(center.x + r*2/3, center.y + MOUSE_POS_V);
    CGPoint mCP1 = CGPointMake(center.x - r/2, center.y + MOUSE_POS_V);
    CGPoint mCP2 = CGPointMake(center.x + r/2, center.y + MOUSE_POS_V);

    CGFloat smileOffset = r*2/3 * happiness;
    mCP1.y += smileOffset;
    mCP2.y += smileOffset;

    // record mouth rect
    _mouthRect.origin.x = mCP1.x;
    _mouthRect.origin.y = mCP1.y - 20;
    _mouthRect.size.width = mCP2.x - mCP1.x;
    _mouthRect.size.height = 40;
    
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, mStart.x, mStart.y);
    CGContextAddCurveToPoint(context, mCP1.x, mCP1.y, mCP2.x, mCP2.y, mEnd.x, mEnd.y);
    CGContextStrokePath(context);

    // left mouth wrinkle
#define WRINKLE_SIZE r/12
    
    CGPoint points[2];
    points[0] = points[1] = mStart;
    points[0].x -= WRINKLE_SIZE;
    points[0].y += WRINKLE_SIZE;
    points[1].x += WRINKLE_SIZE;
    points[1].y -= WRINKLE_SIZE;
    CGContextStrokeLineSegments(context, points, 2);
    
    // right mouth wrinkle
    points[0] = points[1] = mEnd;
    points[0].x -= WRINKLE_SIZE;
    points[0].y -= WRINKLE_SIZE;
    points[1].x += WRINKLE_SIZE;
    points[1].y += WRINKLE_SIZE;
    CGContextStrokeLineSegments(context, points, 2);

}

- (void)showHelp:(CGRect)rect withContext:(CGContextRef)context
{
#define FONT_SIZE 16
    CGContextSelectFont(context, "Arial", FONT_SIZE, kCGEncodingMacRoman);
    CGContextSetTextMatrix(context, CGAffineTransformMake(1.0,0.0, 0.0, -1.0, 0.0, 0.0));

    int y = rect.origin.y;
    CGContextShowTextAtPoint(context, rect.origin.x+10, y += FONT_SIZE+2, "Pinch: resize", 13);
    CGContextShowTextAtPoint(context, rect.origin.x+10, y += FONT_SIZE+2, "Drag: move face", 15);
    CGContextShowTextAtPoint(context, rect.origin.x+10, y += FONT_SIZE+2, "Drag on mouth: change happiness", 28);
    CGContextShowTextAtPoint(context, rect.origin.x+10, y += FONT_SIZE+2, "Double Tap: reset happiness", 25);
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    UIGraphicsPushContext(context);
    
    [self drawFaceInRect:self.faceRect withHappiness:self.happiness withContext:context];
    
    [self showHelp:rect withContext:context];
    
    UIGraphicsPopContext();
}

@end
