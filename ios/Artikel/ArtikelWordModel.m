//
//  ArtikelWordModel.m
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

#import "ArtikelWordModel.h"

@implementation ArtikelWordModel

-(ArtikelWordModel *) initWithManagedObjectContext:(NSManagedObjectContext *) context
{
    if(context == nil)
    {
        [NSException raise:@"Passed NSMangedObjectContext cannot be null" format:@""];
    }
    
    _managedObjectContext = context;
    
    NSFetchRequest * fetch_request = [[NSFetchRequest alloc] init];
    NSEntityDescription * entity_description = [NSEntityDescription entityForName:@"Word"
                                                           inManagedObjectContext:_managedObjectContext];
    
    [fetch_request setEntity:entity_description];
    
    NSError * error;
    NSUInteger count = [_managedObjectContext countForFetchRequest:fetch_request error:&error];
    
    if(count <= 0)
    {
        [self addDefaultWords];
    }
    
    return self;
}

// Returns a pointer to the NSFetchedResultsController object
-(NSFetchedResultsController *) fetchedResultsController
{
    if(_fetchedResultsController == nil)
    {
        NSFetchRequest * fetch_request = [[NSFetchRequest alloc] init];
        NSEntityDescription * entity_description = [NSEntityDescription entityForName:@"Word"
                                                               inManagedObjectContext:_managedObjectContext];
        
        [fetch_request setEntity:entity_description];
        
        NSSortDescriptor * sort_descriptor = [[NSSortDescriptor alloc] initWithKey:@"date_created" ascending:YES];
        NSArray * sort_descriptors_array = @[sort_descriptor];
        
        [fetch_request setSortDescriptors:sort_descriptors_array];
        
        _fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetch_request
                                                                        managedObjectContext:_managedObjectContext
                                                                          sectionNameKeyPath:nil
                                                                                   cacheName:nil];
        
        NSError * error;
        BOOL success = [_fetchedResultsController performFetch:&error];
        
        if(!success)
        {
            [NSException raise:@"fetchedResultsController performFetch resulted in failure" format:@""];
        }
    }
    
    return _fetchedResultsController;
}

// Adds the default words to the model
-(void) addDefaultWords
{
    [self addWord:@"die Katze"];
    [self addWord:@"die Gesundheit"];
    [self addWord:@"das Auto"];
    [self addWord:@"der Entsafter"];
    [self addWord:@"das Bein"];
    [self addWord:@"der Kater"];
    [self addWord:@"die Tür"];
}

// Returns true if the word already exists in the model
-(BOOL) containsWordObject:(ArtikelWord *)word
{
    if(word == nil)
    {
        return false;
    }
    
    return [self contains:word.article characters:word.characters];
}

// Returns true if the word already exists in the model
-(BOOL) contains:(NSString *) whole_word
{
    if(whole_word == nil)
    {
        return false;
    }
    
    NSString * trimmed_word = [whole_word stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSArray * strings = [trimmed_word componentsSeparatedByString:@" "];
    
    if([strings count] != 2)
        return false;
    
    NSString * article = [strings[0] lowercaseString];
    NSString * characters = [strings[1] capitalizedString];
    
    return [self contains:article characters:characters];
}

// Returns true if the word already exists in the model
-(BOOL) contains:(NSString *) article
      characters:(NSString *)characters
{
    if(article == nil || characters == nil)
    {
        return false;
    }
    
    NSFetchRequest * fetch_request = [[NSFetchRequest alloc] init];
    NSEntityDescription * entity_description = [NSEntityDescription entityForName:@"Word"
                                                           inManagedObjectContext:_managedObjectContext];
    
    [fetch_request setEntity:entity_description];
    
    NSPredicate * search_predicate = [NSPredicate predicateWithFormat:@"article == %@ AND characters == %@", article, characters];
    
    [fetch_request setPredicate:search_predicate];
    
    NSError * error;
    NSUInteger count = [_managedObjectContext countForFetchRequest:fetch_request
                                                             error:&error];
    
    if(count > 0)
    {
        return true;
    }
    
    return false;
}

// Adds a word to the model and returns the newly created object
-(ArtikelWord *) addWord:(NSString *) whole_word
{
    ArtikelWord * word = [ArtikelWord wordWithString:whole_word
                                             context:_managedObjectContext];
    
    NSError * error;
    [_managedObjectContext save:&error];
    return word;
}

// Adds a word to the model and returns the newly created object
-(ArtikelWord *) addWord:(NSString *) article
              characters:(NSString *)characters
{
    ArtikelWord * word = [ArtikelWord wordWithArticleAndCharacters:article
                                                        characters:characters
                                                           context:_managedObjectContext];
    
    NSError * error;
    [_managedObjectContext save:&error];
    return word;
}

// Deletes the word from the model
-(void) remove:(ArtikelWord *)word
{
    if(word == nil)
    {
        [NSException raise:@"Passed word cannot be null" format:@""];
    }
    
    // cannot remove die Katze
    if([[word characters] isEqualToString:@"Katze"] && [[word article] isEqualToString:@"die"])
    {
        return;
    }
    
    NSFetchRequest * fetch_request = [[NSFetchRequest alloc] init];
    NSEntityDescription * entity_description = [NSEntityDescription entityForName:@"Word"
                                                           inManagedObjectContext:_managedObjectContext];
    
    [fetch_request setEntity:entity_description];
    
    NSPredicate * search_predicate = [NSPredicate predicateWithFormat:@"article == %@ AND characters == %@", word.article, word.characters];
    
    [fetch_request setPredicate:search_predicate];
    
    NSError * error;
    NSArray * objects = [_managedObjectContext executeFetchRequest:fetch_request
                                                             error:&error];
    ArtikelWord * match = nil;
    
    // only one object returned, this is how it should be
    if([objects count] == 1)
    {
        match = objects[0];
        [_managedObjectContext deleteObject:match];
    }
    // more than one object returned, remove all the objects matching
    else if([objects count] > 1)
    {
        [NSException raise:@"More than one object returned in model search for deleting item" format:@""];
    }
    // no objects returned, a serious error
    else if([objects count] < 1)
    {
        [NSException raise:@"No objects returned in model search for deleting item" format:@""];
    }
    
    [_managedObjectContext save:&error];
}

// Returns the next word
-(ArtikelWord *) next
{
    ArtikelWord * match = nil;
    
    // try a first pass with a time limit, and if that does not work, try
    // without the time limit
    for(int i=0; match == nil; i++)
    {
        int random_number = arc4random_uniform(11);
        
        if(random_number < 4)
        {
            match = [self fetchRecentlyAddedWord];
            
            if(match == nil)
            {
                match = [self fetchRarelyAttemptedWord: (i < 1)];
            }
        }
        
        if(match == nil)
        {
            match = [self fetchDifficultWord:  (i < 1)];
        }
    }
    
    if(match == nil)
    {
        [NSException raise:@"Fetched word null" format:@""];
    }
    
    _currentWord = match;
    
    return match;
}

// fetches a recently added word from the store
-(ArtikelWord *) fetchRecentlyAddedWord
{
    NSFetchRequest * fetch_request = [[NSFetchRequest alloc] init];
    NSEntityDescription * entity_description = [NSEntityDescription entityForName:@"Word"
                                                           inManagedObjectContext:_managedObjectContext];
    [fetch_request setEntity:entity_description];
    
    // words that have not been attempted yet, or have no last attempted date
    NSPredicate * search_predicate = [NSPredicate predicateWithFormat:@"(times_attempted = 0) OR (last_attempt = NULL)", [NSDate dateWithTimeIntervalSinceNow:-10]];
    [fetch_request setPredicate:search_predicate];

    // only fetch 3, we'll take one of them
    [fetch_request setFetchLimit:3];
    
    NSError * error;
    NSArray * objects = [_managedObjectContext executeFetchRequest:fetch_request
                                                             error:&error];
    
    if([objects count] > 0)
    {
        ArtikelWord * match = objects[arc4random_uniform((unsigned int)[objects count])];
        return match;
    }
    
    return nil;
}

// fetches a word with a high fail rate
-(ArtikelWord *) fetchDifficultWord:(BOOL) with_time_limit
{
    NSFetchRequest * fetch_request = [[NSFetchRequest alloc] init];
    NSEntityDescription * entity_description = [NSEntityDescription entityForName:@"Word"
                                                           inManagedObjectContext:_managedObjectContext];
    [fetch_request setEntity:entity_description];

    
    if(with_time_limit)
    {
        // 5 minute gaps between attempts (includes app downtime)
        NSPredicate * search_predicate = [NSPredicate predicateWithFormat:@"(last_attempt < %@)", [NSDate dateWithTimeIntervalSinceNow:-60 * 5]];
        [fetch_request setPredicate:search_predicate];
    }
    
    // Sort based on their failure rate in a descending order
    NSSortDescriptor * sort_descriptor = [[NSSortDescriptor alloc] initWithKey:@"fail_rate" ascending:NO];
    NSArray * sort_descriptors_array = @[sort_descriptor];
    [fetch_request setSortDescriptors:sort_descriptors_array];
    
    // only fetch 3, we'll take one of them
    [fetch_request setFetchLimit:3];
    
    NSError * error;
    NSArray * objects = [_managedObjectContext executeFetchRequest:fetch_request
                                                             error:&error];
    
    ArtikelWord * match;
    
    if([objects count] > 0)
    {
        match = objects[arc4random_uniform((unsigned int)[objects count])];
        return match;
    }
    
    return nil;
}

// fetches a word that the user has not attempted often
-(ArtikelWord *) fetchRarelyAttemptedWord:(BOOL) with_time_limit
{
    NSFetchRequest * fetch_request = [[NSFetchRequest alloc] init];
    NSEntityDescription * entity_description = [NSEntityDescription entityForName:@"Word"
                                                           inManagedObjectContext:_managedObjectContext];
    [fetch_request setEntity:entity_description];
    
    if(with_time_limit)
    {
        // 5 minute gaps between attempts (includes app downtime)
        NSPredicate * search_predicate = [NSPredicate predicateWithFormat:@"(last_attempt < %@)", [NSDate dateWithTimeIntervalSinceNow:-60 * 5]];
        [fetch_request setPredicate:search_predicate];
    }
    
    // Sort words based on how many attempts in a ascending order
    NSSortDescriptor * sort_descriptor = [[NSSortDescriptor alloc] initWithKey:@"times_attempted" ascending:YES];
    NSArray * sort_descriptors_array = @[sort_descriptor];
    [fetch_request setSortDescriptors:sort_descriptors_array];
    
    // only fetch 3, we'll take one of them
    [fetch_request setFetchLimit:3];
    
    NSError * error;
    NSArray * objects = [_managedObjectContext executeFetchRequest:fetch_request
                                                             error:&error];
    
    ArtikelWord * match;
    
    if([objects count] > 0)
    {
        match = objects[arc4random_uniform((unsigned int)[objects count])];
        return match;
    }
    
    return nil;
}

// Returns the current word
-(ArtikelWord *) current
{
    // incase words have been removed
    if([self count] <= 0){
        [self addDefaultWords];
        
        _currentWord = nil;
    }
    
    if(_currentWord == nil || ![self containsWordObject:_currentWord])
    {
        _currentWord = [self next];
    }
    
    return _currentWord;
}

// Returns the number of words
-(NSUInteger) count
{
    NSFetchRequest * fetch_request = [[NSFetchRequest alloc] init];
    NSEntityDescription * entity_description = [NSEntityDescription entityForName:@"Word"
                                                           inManagedObjectContext:_managedObjectContext];
    
    [fetch_request setEntity:entity_description];
    
    NSError * error;
    
    NSUInteger count = [_managedObjectContext countForFetchRequest:fetch_request error:&error];
    
    if(count == NSNotFound)
    {
        [NSException raise:@"Error attempting to resolve the number of objects in the model" format:@""];
    }
    
    return count;
}

@end
