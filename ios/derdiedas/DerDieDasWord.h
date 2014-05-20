//
//  DerDieDasWord.h
//  derdiedas
//
//  Created by Christopher Berry on 19/03/2014.
//  Copyright (c) 2014 Christopher Berry. All rights reserved.
//

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
