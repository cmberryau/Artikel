//
//  DerDieDasMainViewController.h
//  derdiedas
//
//  Created by Christopher Berry on 18/03/2014.
//  Copyright (c) 2014 Christopher Berry. All rights reserved.
//
//  DerDieDas is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation, either version 2 of the License, or
//  (at your option) any later version.
//
//  DerDieDas is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
//  GNU General Public License for more details.
//
//  You should have received a copy of the GNU General Public License
//  along with DerDieDas. If not, see <http://www.gnu.org/licenses/>.

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
