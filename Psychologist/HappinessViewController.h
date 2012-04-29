//
//  HappinessViewController.h
//  Happiness
//
//  Created by Anson Chu on 3/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SplitViewBarButtonItemPresenter.h"

@interface HappinessViewController : UIViewController <SplitViewBarButtonItemPresenter>

@property (nonatomic) int happiness; // 0 sad, 100 happy

@end
