//
//  DerDieDasWordModel.h
//  derdiedas
//
//  Created by Christopher Berry on 19/03/2014.
//  Copyright (c) 2014 Christopher Berry. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DerDieDasWord.h"

@interface DerDieDasWordModel : NSObject

@property (strong, nonatomic) NSFetchedResultsController * fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext * managedObjectContext;
@property (strong, nonatomic) DerDieDasWord * currentWord;

// Inits a new model with a managed object context
-(DerDieDasWordModel *) initWithManagedObjectContext:(NSManagedObjectContext *) context;

// Adds the default words to the model
-(void) addDefaultWords;

// Returns true if the word already exists in the model
-(BOOL) contains:(NSString *) whole_word;

// Returns true if the word already exists in the model
-(BOOL) contains:(NSString *) article characters:(NSString *)characters;

// Adds a word to the model and returns the newly created object
-(DerDieDasWord *) addWord:(NSString *) whole_word;

// Adds a word to the model and returns the newly created object
-(DerDieDasWord *) addWord:(NSString *) article characters:(NSString *)characters;

// Deletes the word from the model
-(void) remove:(DerDieDasWord *)word;

// Returns the next word
-(DerDieDasWord *) next;

// fetches a word with some random elements added
-(DerDieDasWord *) fetcNextWordNoisy;

// fetches a recently added word from the store
-(DerDieDasWord *) fetchRecentlyAddedWord;

// fetches a word with a high fail rate
-(DerDieDasWord *) fetchDifficultWord;

// fetches a word that the user has not attempted often
-(DerDieDasWord *) fetchRarelyAttemptedWord;

// Returns the current word
-(DerDieDasWord *) current;

// Returns the word at the index
-(DerDieDasWord *) atIndex:(NSInteger)index;

// Returns the number of words
-(NSUInteger) count;

@end