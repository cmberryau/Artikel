//
//  EnterWordViewController.m
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

#import "ArtikelEnterWordViewController.h"
#import "ArtikelWordModel.h"
#import "ArtikelAnimationController.h"
#import "ArtikelTableViewController.h"

@interface ArtikelEnterWordViewController ()

@end

@implementation ArtikelEnterWordViewController

ArtikelTableViewController * wordTableController = nil;

#pragma mark - Inherited & Protocol methods

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if(wordTableController == nil)
    {
        wordTableController = [[ArtikelTableViewController alloc] init];
    }

    self.wordField.delegate = self;
    [self.wordField setPlaceholder:@"e.g die Katze"];
    
    [wordTableController setModel:self.model];
    [[self.model fetchedResultsController] setDelegate:wordTableController];
    wordTableController.tableView = self.wordTable;
    [self.wordTable setDelegate:wordTableController];
    [self.wordTable setDataSource:wordTableController];
    //self.wordTable.transform = CGAffineTransformMakeRotation(-M_PI);
    
    self.navigationItem.rightBarButtonItem = wordTableController.editButtonItem;
    
    [wordTableController realignTableView];
}

- (void)viewDidAppear:(BOOL)animated {
    
    // observe keyboard hide and show notifications to resize the text view appropriately
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)viewDidDisappear:(BOOL)animated {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillChangeFrameNotification
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self addWordFromTextField];
    
    return YES;
}

- (IBAction)wordAddTouchedUp:(id)sender
{
    [self addWordFromTextField];
}

#pragma mark - Responding to keyboard events

- (void)adjustTextViewByKeyboardState:(BOOL)showKeyboard keyboardInfo:(NSDictionary *)info
{
    if (showKeyboard) {
        UIInterfaceOrientation orientation = self.interfaceOrientation;
        BOOL isPortrait = UIDeviceOrientationIsPortrait(orientation);
        
        NSValue *keyboardFrameVal = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
        CGRect keyboardFrame = [keyboardFrameVal CGRectValue];
        CGFloat height = isPortrait ? keyboardFrame.size.height : keyboardFrame.size.width;
        
        // adjust the constraint constant to include the keyboard's height
        self.constraintToAdjust.constant += height;
    }
    else {
        self.constraintToAdjust.constant = 0;
    }
}

- (void)keyboardWillShow:(NSNotification *)notification
{
    
    /*
     Reduce the size of the text view so that it's not obscured by the keyboard.
     Animate the resize so that it's in sync with the appearance of the keyboard.
     */
    
    NSDictionary *userInfo = [notification userInfo];
    [self adjustTextViewByKeyboardState:YES keyboardInfo:userInfo];
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    
    /*
     Restore the size of the text view (fill self's view).
     Animate the resize so that it's in sync with the disappearance of the keyboard.
     */
    
    NSDictionary *userInfo = [notification userInfo];
    [self adjustTextViewByKeyboardState:NO keyboardInfo:userInfo];
}

#pragma mark - Our methods

// adds a word from the current content in the text field
-(void)addWordFromTextField
{
    // if the word was valid, and we don't already have it in the model
    if([self.model contains:self.wordField.text])
    {
        NSLog(@"Model already contains word, should alert user!");
    }
    // if the word was not valid or we already have it in the model
    else
    {
        ArtikelWord * word = [self.model addWord:self.wordField.text];
        
        if(!word)
        {
            // do not clear the text field, and show that the word is invalid
            [ArtikelAnimationController DoShake:self.wordField.layer
                                           offset:5.0
                                         duration:0.35
                                         delegate:self];
        }
        else
        {
            // clear the text field and show that the word has been added
            self.wordField.text = @"";
            [self.wordTable reloadData];
            [wordTableController realignTableView];
        }
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
