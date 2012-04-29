//
//  PsychologistViewController.m
//  Psychologist
//
//  Created by Anson Chu on 4/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PsychologistViewController.h"
#import "HappinessViewController.h"

@interface PsychologistViewController ()
@property (nonatomic) int diagnosis;
@end

@implementation PsychologistViewController
@synthesize diagnosis = _diagnosis;

// START CODE MODIFIED ACCORDING TO DEMO CODE
// This part of the code handles the missing button dance bug with dr. pill

- (id <SplitViewBarButtonItemPresenter>)splitViewBarButtonItemPresenter
{
    id detailVC = [self.splitViewController.viewControllers lastObject];
    if (![detailVC conformsToProtocol:@protocol(SplitViewBarButtonItemPresenter)]) {
        detailVC = nil;
    }
    return detailVC;
}

// Does the bar button item transfer from existing detail view controller to destination
-(void) transferSplitViewBarButtonItemToViewController:(id)destinationViewController
{
    UIBarButtonItem *splitViewBarButtonItem = [[self splitViewBarButtonItemPresenter] splitViewBarButtonItem];
    [[self splitViewBarButtonItemPresenter] setSplitViewBarButtonItem:nil];
    if (splitViewBarButtonItem) {
        [destinationViewController setSplitViewBarButtonItem:splitViewBarButtonItem];
    }
}

- (HappinessViewController *) splitViewHappinessViewController
{
    id hvc = [self.splitViewController.viewControllers lastObject];
    if (![hvc isKindOfClass:[HappinessViewController class]]){
        hvc = nil;
    }
    return hvc;
}

-(void) setAndShowDiagnosis:(int)diagnosis
{
    self.diagnosis = diagnosis;
    if ([self splitViewHappinessViewController]){
        [self splitViewHappinessViewController].happiness = diagnosis;
    } else{
        [self performSegueWithIdentifier:@"ShowDiagnosis" sender:self];
    }
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"ShowDiagnosis"]){
        [segue.destinationViewController setHappiness:self.diagnosis];
    }
    else if ([segue.identifier isEqualToString:@"celebrity"]){
        [self transferSplitViewBarButtonItemToViewController:segue.destinationViewController];
        [segue.destinationViewController setHappiness:100];
    }
    else if ([segue.identifier isEqualToString:@"problem"]){
        [self transferSplitViewBarButtonItemToViewController:segue.destinationViewController];
        [segue.destinationViewController setHappiness:20];
    }
    else if ([segue.identifier isEqualToString:@"tv"]){
        [self transferSplitViewBarButtonItemToViewController:segue.destinationViewController];
        [segue.destinationViewController setHappiness:50];
    }
}

// END CODE MODIFIED AFTER LECTURE

- (IBAction)flying:(id)sender {
    [self setAndShowDiagnosis:85];
}
- (IBAction)apple:(id)sender {
    
    [self setAndShowDiagnosis:100];
}
- (IBAction)dragons:(id)sender {
    
    [self setAndShowDiagnosis:20];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
