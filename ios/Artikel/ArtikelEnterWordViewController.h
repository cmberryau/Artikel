//
//  EnterWordViewController.h
//  Artikel
//
//  Created by Christopher Berry on 18/03/2014.
//  Copyright (c) 2014 Christopher Berry. All rights reserved.
//
//  Artikel is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation, either version 2 of the License, or
//  (at your option) any later version.
//
//  Artikel is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
//  GNU General Public License for more details.
//
//  You should have received a copy of the GNU General Public License
//  along with Artikel. If not, see <http://www.gnu.org/licenses/>.

#import <UIKit/UIKit.h>
#import "ArtikelWordModel.h"

@interface ArtikelEnterWordViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField * wordField;
@property (weak, nonatomic) IBOutlet UITableView * wordTable;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintToAdjust;

@property (strong, nonatomic) ArtikelWordModel * model;

// adds a word from the current content in the text field
- (void)addWordFromTextField;

@end
