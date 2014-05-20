//
//  EnterWordViewController.h
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

@interface DerDieDasEnterWordViewController : UIViewController <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField * wordField;
@property (weak, nonatomic) IBOutlet UITableView * wordTable;
@property (strong, nonatomic) DerDieDasWordModel * model;

// adds a word from the current content in the text field
- (void)addWordFromTextField;

@end
