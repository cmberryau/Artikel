//
//  DerDieDasAppDelegate.h
//  derdiedas
//
//  Created by Christopher Berry on 15/03/2014.
//  Copyright (c) 2014 Christopher Berry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DerDieDasWordModel.h"
#import "DerDieDasMainViewController.h"

@interface DerDieDasAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
