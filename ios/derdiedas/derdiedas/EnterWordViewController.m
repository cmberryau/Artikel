//
//  EnterWordViewController.m
//  derdiedas
//
//  Created by Christopher Berry on 18/03/2014.
//  Copyright (c) 2014 Christopher Berry. All rights reserved.
//

#import "EnterWordViewController.h"
#import "DerDieDasWordModel.h"
#import "DerDieDasAnimationController.h"
#import "DerDieDasTableViewController.h"

@interface EnterWordViewController ()

@end

@implementation EnterWordViewController

DerDieDasTableViewController * wordTableController = nil;

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
    
    self.wordField.delegate = self;
    [self.wordField becomeFirstResponder];
    [self.wordField setPlaceholder:@"e.g die Katze"];
    
    wordTableController = [[DerDieDasTableViewController alloc] init];
    [wordTableController setModel:self.model];
    wordTableController.tableView = self.wordTable;
    [self.wordTable setDelegate:wordTableController];
    [self.wordTable setDataSource:wordTableController];
    
    //self.navigationItem.rightBarButtonItem = wordTableController.editButtonItem;
    
    [wordTableController realignTableView];
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

- (IBAction)wordAddTouchedUp:(id)sender {
    [self addWordFromTextField];
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
        DerDieDasWord * word = [self.model addWord:self.wordField.text];
        
        if(!word)
        {
            // do not clear the text field, and show that the word is invalid
            [DerDieDasAnimationController DoShake:self.wordField.layer
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
