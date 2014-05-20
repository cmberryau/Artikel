//
//  DerDieDasTableViewController.h
//  derdiedas
//
//  Created by Christopher Berry on 30/03/2014.
//  Copyright (c) 2014 Christopher Berry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DerDieDasWordModel.h"

@interface DerDieDasTableViewController : UITableViewController

@property (strong, nonatomic) DerDieDasWordModel * model;

-(void)realignTableView;

@end
