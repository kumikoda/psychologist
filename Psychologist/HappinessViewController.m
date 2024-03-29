//
//  HappinessViewController.m
//  Happiness
//
//  Created by Anson Chu on 3/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HappinessViewController.h"
#import "FaceView.h"

@interface HappinessViewController () <FaceViewDataSource>
@property (nonatomic, weak) IBOutlet FaceView *faceView;
@property (nonatomic, weak) IBOutlet UIToolbar *toolBar;
@end

@implementation HappinessViewController

@synthesize happiness = _happiness;
@synthesize faceView = _faceView;
@synthesize splitViewBarButtonItem = _splitViewBarButtonItem;
@synthesize toolBar = _toolbar;


-(void) handleSplitViewBarButtonItem:(UIBarButtonItem *) splitViewBarButtonItem
{
    NSMutableArray *toolBarItems = [self.toolBar.items mutableCopy];
    if (_splitViewBarButtonItem) [toolBarItems removeObject:_splitViewBarButtonItem];
    if (splitViewBarButtonItem) [toolBarItems insertObject:splitViewBarButtonItem atIndex:0];
    self.toolBar.items = toolBarItems;
    _splitViewBarButtonItem = splitViewBarButtonItem;
}

- (void) setSplitViewBarButtonItem:(UIBarButtonItem *)splitViewBarButtonItem
{
    if (_splitViewBarButtonItem != splitViewBarButtonItem){
        [self handleSplitViewBarButtonItem:splitViewBarButtonItem];
    }
}
-(void) viewDidLoad
{
    [super viewDidLoad];
    [self handleSplitViewBarButtonItem:self.splitViewBarButtonItem];
}

- (void) setHappiness:(int)happiness
{
    _happiness = happiness;
    [self.faceView setNeedsDisplay];
}

- (void) setFaceView:(FaceView *)faceView
{
    _faceView = faceView;
    [self.faceView addGestureRecognizer:[[UIPinchGestureRecognizer alloc] initWithTarget:self.faceView action:@selector(pinch:)]];
    [self.faceView addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleHappinessGesture:)]];
    self.faceView.dataSource = self;
}
-(float) smileForFaceView:(FaceView *)sender
{
    return (self.happiness - 50) / 50.0;
}

-(void) handleHappinessGesture:(UIPanGestureRecognizer *)gesture
{
    if ((gesture.state == UIGestureRecognizerStateChanged) || (gesture.state == UIGestureRecognizerStateEnded)){
        CGPoint translation = [gesture translationInView:self.faceView];
        self.happiness -= translation.y /2;
        [gesture setTranslation:CGPointZero inView:self.faceView];
    }

}

-(BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return YES;
}

@end
