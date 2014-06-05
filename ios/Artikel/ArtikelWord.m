//
//  ArtikelWord.m
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

#import "ArtikelWord.h"

@implementation ArtikelWord

@dynamic article;
@dynamic characters;
@dynamic times_attempted;
@dynamic times_failed;
@dynamic fail_rate;
@dynamic last_attempt;

@synthesize managedObjectContext;

// Inits a word with a complete string
+(ArtikelWord *) wordWithString:(NSString*) string context:(NSManagedObjectContext *)context
{
    if(string == nil)
        return nil;
    
    if(context == nil)
        [NSException raise:@"Passed NSMangedObjectContext cannot be null" format:@""];
    
    NSString * trimmed_string = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    ArtikelWord * word = nil;
    NSError * error = nil;
    NSRegularExpression * regex = [NSRegularExpression regularExpressionWithPattern:@"^\\b([dD]([eE][rR]|[iI][eE]|[aA][sS])) (?u)[^\\W\\d_]+$\\b"
                                   options:0
                                   error: &error];
    
    NSUInteger regex_matches = [regex numberOfMatchesInString:trimmed_string
                                options:0
                                range:NSMakeRange(0, [trimmed_string length])];

    if(regex_matches == 1)
    {
        NSArray * strings = [trimmed_string componentsSeparatedByString:@" "];
        
        word = [NSEntityDescription insertNewObjectForEntityForName:@"Word" inManagedObjectContext:context];
        
        [word setArticle: [[strings objectAtIndex:0] lowercaseString]];
        [word setCharacters: [[strings objectAtIndex:1] capitalizedString]];
        [word setTimes_attempted:0];
        [word setTimes_failed:0];
        [word setFail_rate:0];
    }
    
    word.managedObjectContext = context;
    
    return word;
}

// Inits a word with a seperate article and character string
+(ArtikelWord *) wordWithArticleAndCharacters:(NSString*) article characters:(NSString *) characters context:(NSManagedObjectContext *)context
{
    if(article == nil || characters == nil)
        return nil;
    
    if(context == nil)
        [NSException raise:@"Passed NSMangedObjectContext cannot be null" format:@""];
    
    NSString * trimmed_article = [article stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString * trimmed_characters = [characters stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    ArtikelWord * word = nil;

    NSError * regex_error = nil;
    NSRegularExpression * article_regex = [NSRegularExpression regularExpressionWithPattern:@"^\\b([dD]([eE][rR]|[iI][eE]|[aA][sS]))$\\b"
                                                                                    options:0
                                                                                      error:&regex_error];
    
    NSInteger regex_matches = [article_regex numberOfMatchesInString:trimmed_article
                                                             options:0
                                                               range:NSMakeRange(0, [trimmed_article length])];
    
    // if the regex was not satisfied
    if(regex_matches != 1)
    {
        return word;
    }
    
    NSRegularExpression * character_regex = [NSRegularExpression regularExpressionWithPattern:@"^\\b(?u)[^\\W\\d_]+$\\b"
                                                                                      options:0
                                                                                        error: &regex_error];

    regex_matches = [character_regex numberOfMatchesInString:trimmed_characters
                                                   options:0
                                                     range:NSMakeRange(0, [trimmed_characters length])];
    
    // if the regex was not satisfied
    if(regex_matches != 1)
    {
        return word;
    }
        
    word = [NSEntityDescription insertNewObjectForEntityForName:@"Word" inManagedObjectContext:context];
    
    [word setArticle: [trimmed_article lowercaseString]];
    [word setCharacters: [trimmed_characters capitalizedString]];
    [word setTimes_attempted:0];
    [word setTimes_failed:0];
    [word setFail_rate:0];
    
    word.managedObjectContext = context;
    
    return word;
}

// Returns true if article given is the correct article
// and performs internal logic for model update
-(BOOL) attemptToAnswer:(NSString *) article_given
{
    if(article_given == nil)
        return false;
    
    BOOL result = false;
    
    [self setLast_attempt:[NSDate dateWithTimeIntervalSinceNow:0]];
    [self setTimes_attempted:@([self.times_attempted intValue]+1)];

    NSError * error;
    
    if([article_given isEqualToString:self.article])
    {
        result = true;
    }
    else
    {
        [self setTimes_failed:@([self.times_failed intValue]+1)];
    }
    
    [self.managedObjectContext save:&error];
    
    return result;
}

@end
