//
//  DerDieDasMainViewController.h
//  derdiedas
//
//  Created by Christopher Berry on 15/03/2014.
//  Copyright (c) 2014 Christopher Berry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DerDieDasWordModel.h"

@interface DerDieDasMainViewController : UIViewController

@property (weak, nonatomic) IBOutlet UISegmentedControl *articleSelector;
@property (weak, nonatomic) IBOutlet UILabel *wordLabel;
@property (weak, nonatomic) IBOutlet UILabel *articleLabel;
@property (strong, nonatomic) DerDieDasWordModel * model;

// called after the delay from selecting the correct word has expired
- (void)wordChangeDelayExpired;
// sets the article's label field font size
- (void)setArticleSelectorFontSize:(int)size;

@end
