//
//  DerDieDasWordModel.h
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
-(BOOL) containsWordObject:(DerDieDasWord *)word;

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

// fetches a recently added word from the store
-(DerDieDasWord *) fetchRecentlyAddedWord;

// fetches a word with a high fail rate
-(DerDieDasWord *) fetchDifficultWord:(BOOL) with_time_limit;

// fetches a word that the user has not attempted often
-(DerDieDasWord *) fetchRarelyAttemptedWord:(BOOL) with_time_limit;

// Returns the current word
-(DerDieDasWord *) current;

// Returns the number of words
-(NSUInteger) count;

@end