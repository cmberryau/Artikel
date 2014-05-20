//
//  EnterWordViewController.h
//  derdiedas
//
//  Created by Christopher Berry on 18/03/2014.
//  Copyright (c) 2014 Christopher Berry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DerDieDasWordModel.h"

@interface DerDieDasEnterWordViewController : UIViewController <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField * wordField;
@property (weak, nonatomic) IBOutlet UITableView * wordTable;
@property (strong, nonatomic) DerDieDasWordModel * model;

// adds a word from the current content in the text field
- (void)addWordFromTextField;

@end
