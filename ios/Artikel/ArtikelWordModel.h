//
//  ArtikelWordModel.h
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

#import <Foundation/Foundation.h>
#import "ArtikelWord.h"

@interface ArtikelWordModel : NSObject

@property (strong, nonatomic) NSFetchedResultsController * fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext * managedObjectContext;
@property (strong, nonatomic) ArtikelWord * currentWord;

// Inits a new model with a managed object context
-(ArtikelWordModel *) initWithManagedObjectContext:(NSManagedObjectContext *) context;

// Adds the default words to the model
-(void) addDefaultWords;

// Returns true if the word already exists in the model
-(BOOL) containsWordObject:(ArtikelWord *)word;

// Returns true if the word already exists in the model
-(BOOL) contains:(NSString *) whole_word;

// Returns true if the word already exists in the model
-(BOOL) contains:(NSString *) article characters:(NSString *)characters;

// Adds a word to the model and returns the newly created object
-(ArtikelWord *) addWord:(NSString *) whole_word;

// Adds a word to the model and returns the newly created object
-(ArtikelWord *) addWord:(NSString *) article characters:(NSString *)characters;

// Deletes the word from the model
-(void) remove:(ArtikelWord *)word;

// Returns the next word
-(ArtikelWord *) next;

// fetches a recently added word from the store
-(ArtikelWord *) fetchRecentlyAddedWord;

// fetches a word with a high fail rate
-(ArtikelWord *) fetchDifficultWord:(BOOL) with_time_limit;

// fetches a word that the user has not attempted often
-(ArtikelWord *) fetchRarelyAttemptedWord:(BOOL) with_time_limit;

// Returns the current word
-(ArtikelWord *) current;

// Returns the number of words
-(NSUInteger) count;

@end