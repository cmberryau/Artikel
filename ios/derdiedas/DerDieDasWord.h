//
//  DerDieDasWord.h
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

@interface DerDieDasWord : NSManagedObject

@property (nonatomic, strong) NSString * article;
@property (nonatomic, strong) NSString * characters;
@property (nonatomic, strong) NSNumber * times_attempted;
@property (nonatomic, strong) NSNumber * times_failed;
@property (nonatomic, strong) NSNumber * fail_rate;
@property (nonatomic, strong) NSDate * last_attempt;

@property (strong, nonatomic) NSManagedObjectContext * managedObjectContext;

// Inits a word with a complete string
+(DerDieDasWord *) wordWithString:(NSString*) string context:(NSManagedObjectContext *)context;

// Inits a word with a seperate article and character string
+(DerDieDasWord *) wordWithArticleAndCharacters:(NSString*) article
                                     characters:(NSString *)characters
                                     context:(NSManagedObjectContext *)context;

// Returns true if article given is the correct article
// and performs internal logic for model update
-(BOOL) attemptToAnswer:(NSString *) article_given;

@end
