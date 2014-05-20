//
//  DerDieDasMainViewController.m
//  derdiedas
//
//  Created by Christopher Berry on 15/03/2014.
//  Copyright (c) 2014 Christopher Berry. All rights reserved.
//

#import "DerDieDasMainViewController.h"
#import "DerDieDasAnimationController.h"
#import "DerDieDasEnterWordViewController.h"

@interface DerDieDasMainViewController ()

@end

@implementation DerDieDasMainViewController

static CGFloat _label_movement_offset;
static volatile bool _ready_to_answer;

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
    [self setArticleSelectorFontSize:20];
    
    _label_movement_offset = (self.articleLabel.bounds.size.width/2);
    _ready_to_answer = true;
    
    [self.wordLabel setText:[[self.model current] characters]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)articleSelectorValueChanged:(id)sender {
    // hack to fix the font size
    [self setArticleSelectorFontSize:20];
    
    if(!_ready_to_answer)
        return;
    
    NSString * article = [self.articleSelector
                          titleForSegmentAtIndex:[self.articleSelector selectedSegmentIndex]];
    
    DerDieDasWord * word = [self.model current];
    
    // is article correct?
    if([word attemptToAnswer:article])
    {
        // unhide the article label (it is still invisible due to opacity)
        [self.articleLabel setText:article];
        [self.articleLabel setHidden:false];
        
        // fade in the article label using opacity
        [DerDieDasAnimationController DoFadeIn:[self.articleLabel layer] duration:0.5 delegate:self];
        
        // move both article and word labels into middle of view
        [DerDieDasAnimationController DoMove:[self.wordLabel layer]
                                              xmove:_label_movement_offset
                                              ymove:0 duration:0.25 delegate:self];
        [DerDieDasAnimationController DoMove:[self.articleLabel layer]
                                              xmove:_label_movement_offset
                                              ymove:0 duration:0.25 delegate:self];
        
        // start delay timer before resetting state
        [NSTimer scheduledTimerWithTimeInterval:1.25
                                         target:self
                                       selector:@selector(wordChangeDelayExpired)
                                       userInfo:nil
                                        repeats:NO];
        
        _ready_to_answer = false;
    }
    else
    {
        
        [DerDieDasAnimationController DoShake:[self.wordLabel layer]
                                       offset:5.0
                                     duration:0.35
                                     delegate:self];
        [self.articleSelector setEnabled:false
                       forSegmentAtIndex:[self.articleSelector selectedSegmentIndex]];
    }
}

#pragma mark - Our methods

// called after the delay from selecting the correct word has expired
- (void)wordChangeDelayExpired
{
    // reset segment states to enabled
    [self.articleSelector setEnabled:true forSegmentAtIndex:0];
    [self.articleSelector setEnabled:true forSegmentAtIndex:1];
    [self.articleSelector setEnabled:true forSegmentAtIndex:2];
    
    // hide the article label
    [self.articleLabel setHidden:true];
    [[self.articleLabel layer] removeAllAnimations];
    
    // move the labels back
    [[self.articleLabel layer] removeAllAnimations];
    [[self.wordLabel layer] removeAllAnimations];
    
    [self.wordLabel setText:[[self.model next] characters]];
    
    _ready_to_answer = true;
}

// sets the article's label field font size
- (void)setArticleSelectorFontSize:(int)size {
    NSDictionary *textAttributes = [NSDictionary
                                    dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:size],
                                    NSFontAttributeName, nil];
    
    [self.articleSelector setTitleTextAttributes:textAttributes forState:UIControlStateNormal];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    DerDieDasEnterWordViewController * view = (DerDieDasEnterWordViewController *)[segue destinationViewController];
    [view setModel:self.model];
}
    
@end
