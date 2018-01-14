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
@dynamic date_created;

@synthesize managedObjectContext;

// initialises a word using a complete string
+(ArtikelWord *) wordWithString:(NSString*) string context:(NSManagedObjectContext *)context
{
    if(string == nil)
        return nil;
    
    if(context == nil)
        [NSException raise:@"Passed NSMangedObjectContext cannot be null" format:@""];
    
    NSString * trimmed_string = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    ArtikelWord * word = nil;
    NSError * error = nil;
    NSRegularExpression * regex = [NSRegularExpression regularExpressionWithPattern:@"^\\b([d]([e][r]|[i][e]|[a][s])) (?u)([a-z]|[ß]|[ü]|[ä]|[ö])([a-z]|[ß]|[ü]|[ä]|[ö]|[-]|[ ])+$\\b"
                                   options:NSRegularExpressionCaseInsensitive
                                   error: &error];
    
    NSUInteger regex_matches = [regex numberOfMatchesInString:trimmed_string
                                options:0
                                range:NSMakeRange(0, [trimmed_string length])];
    
    if(regex_matches == 1)
    {
        NSArray * strings = [trimmed_string componentsSeparatedByString:@" "];
        NSString * characters = [[strings objectAtIndex:1] capitalizedString];
        
        if([strings count] > 2)
        {
            for(NSUInteger i = 0; i < [strings count] - 2; ++i)
            {
                // perform a bit more sanitisation
                NSString * characters_part = [[strings objectAtIndex:i + 2] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
                
                if([characters_part length] > 0)
                {
                    characters = [characters stringByAppendingString:@" "];
                    characters = [characters stringByAppendingString:[characters_part capitalizedString]];
                }
            }
        }
        
        word = [NSEntityDescription insertNewObjectForEntityForName:@"Word" inManagedObjectContext:context];
        [word setArticle: [[strings objectAtIndex:0] lowercaseString]];
        [word setCharacters:characters];
        [word setTimes_attempted:0];
        [word setTimes_failed:0];
        [word setFail_rate:0];
        [word setDate_created: [NSDate dateWithTimeIntervalSinceNow:0]];
    }
    
    word.managedObjectContext = context;
    
    return word;
}

// initialises a word using a seperate article and character string
+(ArtikelWord *) wordWithArticleAndCharacters:(NSString*) article characters:(NSString *) characters context:(NSManagedObjectContext *)context
{
    if(article == nil || characters == nil)
        return nil;
    
    if(context == nil)
        [NSException raise:@"Passed NSMangedObjectContext cannot be null" format:@""];
    
    NSString * wordString = [article stringByAppendingString:@" "];
    wordString = [wordString stringByAppendingString:characters];
    
    return [self wordWithString:wordString context:context];
}

// returns true if article given is the correct article and performs internal logic for model update
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
