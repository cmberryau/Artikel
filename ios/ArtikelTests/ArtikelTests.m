//
//  ArtikelTests.m
//  ArtikelTests
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

#import <XCTest/XCTest.h>

#import "ArtikelWord.h"

@interface ArtikelTests : XCTestCase

@property (strong, nonatomic) NSManagedObjectContext * managedObjectContext;

- (void)testArtikelWordNormalChars;
- (void)testArtikelWordNumericalChars;
- (void)testArtikelWordSpecialChars;
- (void)testArtikelNullCases;

@end

@implementation ArtikelTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    NSManagedObjectModel * object_model = [NSManagedObjectModel mergedModelFromBundles:nil];
    XCTAssertNotNil(object_model);
    
    NSPersistentStoreCoordinator * persistent_store_coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:object_model];
    XCTAssertNotNil(persistent_store_coordinator);
    
    NSPersistentStore * persistent_store = [persistent_store_coordinator addPersistentStoreWithType:NSInMemoryStoreType configuration:nil URL:nil options:nil error:nil];
    XCTAssertNotNil(persistent_store);
    
    self.managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    XCTAssertNotNil(self.managedObjectContext);
    self.managedObjectContext.persistentStoreCoordinator = persistent_store_coordinator;
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testArtikelWordNormalChars
{
    ArtikelWord * word = nil;
    NSString * test_string = @"die Katze";
    word = [ArtikelWord wordWithString:test_string context:self.managedObjectContext];
    XCTAssertNotNil(word);
    
    if (![word.article isEqualToString:@"die"]) {
        XCTFail(@"%@ did not result in die as the article, instead resulted in %@", test_string, word.article);

    }
    
    if (![word.characters isEqualToString:@"Katze"]) {
        XCTFail(@"%@ did not result in Katze as the characters, instead resulted in %@", test_string, word.characters);
    }
    
    word = nil;
    NSString * test_article = @"die";
    NSString * test_characters = @"Katze";
    word = [ArtikelWord wordWithArticleAndCharacters:test_article characters:test_characters context:self.managedObjectContext];
    XCTAssertNotNil(word);
    
    if (![word.article isEqualToString:@"die"]) {
        XCTFail(@"%@ did not result in die as the article, instead resulted in %@", test_string, word.article);

    }
    
    if (![word.characters isEqualToString:@"Katze"]) {
        XCTFail(@"%@ did not result in Katze as the characters, instead resulted in %@", test_string, word.characters);
    }
    
    word = nil;
    test_string = @"die katze";
    word = [ArtikelWord wordWithString:test_string context:self.managedObjectContext];
    XCTAssertNotNil(word);
    
    if (![word.article isEqualToString:@"die"]) {
        XCTFail(@"%@ did not result in die as the article, instead resulted in %@", test_string, word.article);

    }
    
    if (![word.characters isEqualToString:@"Katze"]) {
        XCTFail(@"%@ did not result in Katze as the characters, instead resulted in %@", test_string, word.characters);
    }
    
    word = nil;
    test_article = @"die";
    test_characters = @"katze";
    word = [ArtikelWord wordWithArticleAndCharacters:test_article characters:test_characters context:self.managedObjectContext];
    XCTAssertNotNil(word);
    
    if (![word.article isEqualToString:@"die"]) {
        XCTFail(@"%@ did not result in die as the article, instead resulted in %@", test_string, word.article);

    }
    
    if (![word.characters isEqualToString:@"Katze"]) {
        XCTFail(@"%@ did not result in Katze as the characters, instead resulted in %@", test_string, word.characters);
    }
 
    word = nil;
    test_string = @" die Katze";
    word = [ArtikelWord wordWithString:test_string context:self.managedObjectContext];
    XCTAssertNotNil(word);
    
    if (![word.article isEqualToString:@"die"]) {
        XCTFail(@"%@ did not result in die as the article, instead resulted in %@", test_string, word.article);

    }
    
    if (![word.characters isEqualToString:@"Katze"]) {
        XCTFail(@"%@ did not result in Katze as the characters, instead resulted in %@", test_string, word.characters);
    }

    word = nil;
    test_article = @" die";
    test_characters = @"Katze";
    word = [ArtikelWord wordWithArticleAndCharacters:test_article characters:test_characters context:self.managedObjectContext];
    XCTAssertNotNil(word);
    
    if (![word.article isEqualToString:@"die"]) {
        XCTFail(@"%@ did not result in die as the article, instead resulted in %@", test_string, word.article);

    }
    
    if (![word.characters isEqualToString:@"Katze"]) {
        XCTFail(@"%@ did not result in Katze as the characters, instead resulted in %@", test_string, word.characters);
    }
    
    word = nil;
    test_string = @"die Katze ";
    word = [ArtikelWord wordWithString:test_string context:self.managedObjectContext];
    XCTAssertNotNil(word);
    
    if (![word.article isEqualToString:@"die"]) {
        XCTFail(@"%@ did not result in die as the article, instead resulted in %@", test_string, word.article);

    }
    
    if (![word.characters isEqualToString:@"Katze"]) {
        XCTFail(@"%@ did not result in Katze as the characters, instead resulted in %@", test_string, word.characters);
    }
    
    word = nil;
    test_article = @"die";
    test_characters = @"Katze ";
    word = [ArtikelWord wordWithArticleAndCharacters:test_article characters:test_characters context:self.managedObjectContext];
    XCTAssertNotNil(word);
    
    if (![word.article isEqualToString:@"die"]) {
        XCTFail(@"%@ did not result in die as the article, instead resulted in %@", test_string, word.article);

    }
    
    if (![word.characters isEqualToString:@"Katze"]) {
        XCTFail(@"%@ did not result in Katze as the characters, instead resulted in %@", test_string, word.characters);
    }
    
    word = nil;
    test_string = @" die katze";
    word = [ArtikelWord wordWithString:test_string context:self.managedObjectContext];
    XCTAssertNotNil(word);
    
    if (![word.article isEqualToString:@"die"]) {
        XCTFail(@"%@ did not result in die as the article, instead resulted in %@", test_string, word.article);

    }
    
    if (![word.characters isEqualToString:@"Katze"]) {
        XCTFail(@"%@ did not result in Katze as the characters, instead resulted in %@", test_string, word.characters);
    }
    
    word = nil;
    test_article = @" die";
    test_characters = @"katze";
    word = [ArtikelWord wordWithArticleAndCharacters:test_article characters:test_characters context:self.managedObjectContext];
    XCTAssertNotNil(word);
    
    if (![word.article isEqualToString:@"die"]) {
        XCTFail(@"%@ did not result in die as the article, instead resulted in %@", test_string, word.article);
    }
    
    if (![word.characters isEqualToString:@"Katze"]) {
        XCTFail(@"%@ did not result in Katze as the characters, instead resulted in %@", test_string, word.characters);
    }
    
    word = nil;
    test_string = @"die katze ";
    word = [ArtikelWord wordWithString:test_string context:self.managedObjectContext];
    XCTAssertNotNil(word);
    
    if (![word.article isEqualToString:@"die"]) {
        XCTFail(@"%@ did not result in die as the article, instead resulted in %@", test_string, word.article);

    }
    
    if (![word.characters isEqualToString:@"Katze"]) {
        XCTFail(@"%@ did not result in Katze as the characters, instead resulted in %@", test_string, word.characters);
    }
    
    word = nil;
    test_article = @"die";
    test_characters = @"katze ";
    word = [ArtikelWord wordWithArticleAndCharacters:test_article characters:test_characters context:self.managedObjectContext];
    XCTAssertNotNil(word);
    
    if (![word.article isEqualToString:@"die"]) {
        XCTFail(@"%@ did not result in die as the article, instead resulted in %@", test_string, word.article);

    }
    
    if (![word.characters isEqualToString:@"Katze"]) {
        XCTFail(@"%@ did not result in Katze as the characters, instead resulted in %@", test_string, word.characters);
    }
    
    word = nil;
    test_string = @"die KATZE";
    word = [ArtikelWord wordWithString:test_string context:self.managedObjectContext];
    XCTAssertNotNil(word);
    
    if (![word.article isEqualToString:@"die"]) {
        XCTFail(@"%@ did not result in die as the article, instead resulted in %@", test_string, word.article);

    }
    
    if (![word.characters isEqualToString:@"Katze"]) {
        XCTFail(@"%@ did not result in Katze as the characters, instead resulted in %@", test_string, word.characters);
    }
    
    word = nil;
    test_article = @"die";
    test_characters = @"KATZE";
    word = [ArtikelWord wordWithArticleAndCharacters:test_article characters:test_characters context:self.managedObjectContext];
    XCTAssertNotNil(word);
    
    if (![word.article isEqualToString:@"die"]) {
        XCTFail(@"%@ did not result in die as the article, instead resulted in %@", test_string, word.article);

    }
    
    if (![word.characters isEqualToString:@"Katze"]) {
        XCTFail(@"%@ did not result in Katze as the characters, instead resulted in %@", test_string, word.characters);
    }
    
    word = nil;
    test_string = @"DIE Katze";
    word = [ArtikelWord wordWithString:test_string context:self.managedObjectContext];
    XCTAssertNotNil(word);
    
    if (![word.article isEqualToString:@"die"]) {
        XCTFail(@"%@ did not result in die as the article, instead resulted in %@", test_string, word.article);

    }
    
    if (![word.characters isEqualToString:@"Katze"]) {
        XCTFail(@"%@ did not result in Katze as the characters, instead resulted in %@", test_string, word.characters);
    }
    
    word = nil;
    test_article = @"DIE";
    test_characters = @"Katze";
    word = [ArtikelWord wordWithArticleAndCharacters:test_article characters:test_characters context:self.managedObjectContext];
    XCTAssertNotNil(word);
    
    if (![word.article isEqualToString:@"die"]) {
        XCTFail(@"%@ did not result in die as the article, instead resulted in %@", test_string, word.article);

    }
    
    if (![word.characters isEqualToString:@"Katze"]) {
        XCTFail(@"%@ did not result in Katze as the characters, instead resulted in %@", test_string, word.characters);
    }

    word = nil;
    test_string = @"DIE katze";
    word = [ArtikelWord wordWithString:test_string context:self.managedObjectContext];
    XCTAssertNotNil(word);
    
    if (![word.article isEqualToString:@"die"]) {
        XCTFail(@"%@ did not result in die as the article, instead resulted in %@", test_string, word.article);

    }
    
    if (![word.characters isEqualToString:@"Katze"]) {
        XCTFail(@"%@ did not result in Katze as the characters, instead resulted in %@", test_string, word.characters);
    }
    
    word = nil;
    test_article = @"DIE";
    test_characters = @"katze";
    word = [ArtikelWord wordWithArticleAndCharacters:test_article characters:test_characters context:self.managedObjectContext];
    XCTAssertNotNil(word);
    
    if (![word.article isEqualToString:@"die"]) {
        XCTFail(@"%@ did not result in die as the article, instead resulted in %@", test_string, word.article);

    }
    
    if (![word.characters isEqualToString:@"Katze"]) {
        XCTFail(@"%@ did not result in Katze as the characters, instead resulted in %@", test_string, word.characters);
    }
    
    word = nil;
    test_string = @"die KaTzE";
    word = [ArtikelWord wordWithString:test_string context:self.managedObjectContext];
    XCTAssertNotNil(word);
    
    if (![word.article isEqualToString:@"die"]) {
        XCTFail(@"%@ did not result in die as the article, instead resulted in %@", test_string, word.article);

    }
    
    if (![word.characters isEqualToString:@"Katze"]) {
        XCTFail(@"%@ did not result in Katze as the characters, instead resulted in %@", test_string, word.characters);
    }
    
    word = nil;
    test_article = @"die";
    test_characters = @"KaTzE";
    word = [ArtikelWord wordWithArticleAndCharacters:test_article characters:test_characters context:self.managedObjectContext];
    XCTAssertNotNil(word);
    
    if (![word.article isEqualToString:@"die"]) {
        XCTFail(@"%@ did not result in die as the article, instead resulted in %@", test_string, word.article);

    }
    
    if (![word.characters isEqualToString:@"Katze"]) {
        XCTFail(@"%@ did not result in Katze as the characters, instead resulted in %@", test_string, word.characters);
    }
    
    word = nil;
    test_string = @"die kAtZe";
    word = [ArtikelWord wordWithString:test_string context:self.managedObjectContext];
    XCTAssertNotNil(word);
    
    if (![word.article isEqualToString:@"die"]) {
        XCTFail(@"%@ did not result in die as the article, instead resulted in %@", test_string, word.article);

    }
    
    if (![word.characters isEqualToString:@"Katze"]) {
        XCTFail(@"%@ did not result in Katze as the characters, instead resulted in %@", test_string, word.characters);
    }
    
    word = nil;
    test_article = @"die";
    test_characters = @"kAtZe";
    word = [ArtikelWord wordWithArticleAndCharacters:test_article characters:test_characters context:self.managedObjectContext];
    XCTAssertNotNil(word);
    
    if (![word.article isEqualToString:@"die"]) {
        XCTFail(@"%@ did not result in die as the article, instead resulted in %@", test_string, word.article);

    }
    
    if (![word.characters isEqualToString:@"Katze"]) {
        XCTFail(@"%@ did not result in Katze as the characters, instead resulted in %@", test_string, word.characters);
    }
    
    word = nil;
    test_string = @"DIE KaTzE";
    word = [ArtikelWord wordWithString:test_string context:self.managedObjectContext];
    XCTAssertNotNil(word);
    
    if (![word.article isEqualToString:@"die"]) {
        XCTFail(@"%@ did not result in die as the article, instead resulted in %@", test_string, word.article);

    }
    
    if (![word.characters isEqualToString:@"Katze"]) {
        XCTFail(@"%@ did not result in Katze as the characters, instead resulted in %@", test_string, word.characters);
    }

    word = nil;
    test_article = @"DIE";
    test_characters = @"KaTzE";
    word = [ArtikelWord wordWithArticleAndCharacters:test_article characters:test_characters context:self.managedObjectContext];
    XCTAssertNotNil(word);
    
    if (![word.article isEqualToString:@"die"]) {
        XCTFail(@"%@ did not result in die as the article, instead resulted in %@", test_string, word.article);

    }
    
    if (![word.characters isEqualToString:@"Katze"]) {
        XCTFail(@"%@ did not result in Katze as the characters, instead resulted in %@", test_string, word.characters);
    }
    
    word = nil;
    test_string = @"DIE kAtZe";
    word = [ArtikelWord wordWithString:test_string context:self.managedObjectContext];
    XCTAssertNotNil(word);
    
    if (![word.article isEqualToString:@"die"]) {
        XCTFail(@"%@ did not result in die as the article, instead resulted in %@", test_string, word.article);

    }
    
    if (![word.characters isEqualToString:@"Katze"]) {
        XCTFail(@"%@ did not result in Katze as the characters, instead resulted in %@", test_string, word.characters);
    }
    
    word = nil;
    test_article = @"DIE";
    test_characters = @"kAtZe";
    word = [ArtikelWord wordWithArticleAndCharacters:test_article characters:test_characters context:self.managedObjectContext];
    XCTAssertNotNil(word);
    
    if (![word.article isEqualToString:@"die"]) {
        XCTFail(@"%@ did not result in die as the article, instead resulted in %@", test_string, word.article);

    }
    
    if (![word.characters isEqualToString:@"Katze"]) {
        XCTFail(@"%@ did not result in Katze as the characters, instead resulted in %@", test_string, word.characters);
    }

    word = nil;
    word = [ArtikelWord wordWithString:@"" context:self.managedObjectContext];
    XCTAssertNil(word);
    
    word = nil;
    word = [ArtikelWord wordWithString:@" " context:self.managedObjectContext];
    XCTAssertNil(word);
    
    word = nil;
    word = [ArtikelWord wordWithString:@"die" context:self.managedObjectContext];
    XCTAssertNil(word);

    word = nil;
    word = [ArtikelWord wordWithString:@"DIE" context:self.managedObjectContext];
    XCTAssertNil(word);

    word = nil;
    word = [ArtikelWord wordWithString:@"die " context:self.managedObjectContext];
    XCTAssertNil(word);
    
    word = nil;
    word = [ArtikelWord wordWithString:@"DIE " context:self.managedObjectContext];
    XCTAssertNil(word);
    
    word = nil;
    word = [ArtikelWord wordWithString:@" die" context:self.managedObjectContext];
    XCTAssertNil(word);
    
    word = nil;
    word = [ArtikelWord wordWithString:@" DIE" context:self.managedObjectContext];
    XCTAssertNil(word);

    word = nil;
    word = [ArtikelWord wordWithString:@" die " context:self.managedObjectContext];
    XCTAssertNil(word);
    
    word = nil;
    word = [ArtikelWord wordWithString:@" DIE " context:self.managedObjectContext];
    XCTAssertNil(word);
    
    word = nil;
    word = [ArtikelWord wordWithString:@"katze" context:self.managedObjectContext];
    XCTAssertNil(word);
    
    word = nil;
    word = [ArtikelWord wordWithString:@"KATZE" context:self.managedObjectContext];
    XCTAssertNil(word);

    word = nil;
    word = [ArtikelWord wordWithString:@"katze " context:self.managedObjectContext];
    XCTAssertNil(word);
    
    word = nil;
    word = [ArtikelWord wordWithString:@"KATZE " context:self.managedObjectContext];
    XCTAssertNil(word);

    word = nil;
    word = [ArtikelWord wordWithString:@" katze" context:self.managedObjectContext];
    XCTAssertNil(word);
    
    word = nil;
    word = [ArtikelWord wordWithString:@" KATZE" context:self.managedObjectContext];
    XCTAssertNil(word);

    word = nil;
    word = [ArtikelWord wordWithString:@" katze " context:self.managedObjectContext];
    XCTAssertNil(word);
    
    word = nil;
    word = [ArtikelWord wordWithString:@" KATZE " context:self.managedObjectContext];
    XCTAssertNil(word);
    
    word = nil;
    word = [ArtikelWord wordWithString:@"diekatze" context:self.managedObjectContext];
    XCTAssertNil(word);
    
    word = nil;
    word = [ArtikelWord wordWithString:@"dieKatze" context:self.managedObjectContext];
    XCTAssertNil(word);
    
    word = nil;
    word = [ArtikelWord wordWithString:@"dieKATZE" context:self.managedObjectContext];
    XCTAssertNil(word);
}

- (void)testArtikelWordNumericalChars
{
    ArtikelWord * word = nil;
    NSString * test_string = @"0123456789";
    word = [ArtikelWord wordWithString:test_string context:self.managedObjectContext];
    XCTAssertNil(word);
    
    word = nil;
    test_string = @"der 0123456789";
    word = [ArtikelWord wordWithString:test_string context:self.managedObjectContext];
    XCTAssertNil(word);
    
    word = nil;
    NSString * test_article = @"der";
    NSString * test_characters = @"0123456789";
    word = [ArtikelWord wordWithArticleAndCharacters:test_article characters:test_characters context:self.managedObjectContext];
    XCTAssertNil(word);
    
    word = nil;
    test_string = @"die 0123456789";
    word = [ArtikelWord wordWithString:test_string context:self.managedObjectContext];
    XCTAssertNil(word);
    
    word = nil;
    test_article = @"die";
    test_characters = @"0123456789";
    word = [ArtikelWord wordWithArticleAndCharacters:test_article characters:test_characters context:self.managedObjectContext];
    XCTAssertNil(word);
    
    word = nil;
    test_string = @"das 0123456789";
    word = [ArtikelWord wordWithString:test_string context:self.managedObjectContext];
    XCTAssertNil(word);

    word = nil;
    test_article = @"das";
    test_characters = @"0123456789";
    word = [ArtikelWord wordWithArticleAndCharacters:test_article characters:test_characters context:self.managedObjectContext];
    XCTAssertNil(word);
    
    word = nil;
    test_string = @"DER 0123456789";
    word = [ArtikelWord wordWithString:test_string context:self.managedObjectContext];
    XCTAssertNil(word);
    
    word = nil;
    test_article = @"DER";
    test_characters = @"0123456789";
    word = [ArtikelWord wordWithArticleAndCharacters:test_article characters:test_characters context:self.managedObjectContext];
    XCTAssertNil(word);
    
    word = nil;
    test_string = @"DIE 0123456789";
    word = [ArtikelWord wordWithString:test_string context:self.managedObjectContext];
    XCTAssertNil(word);
    
    word = nil;
    test_article = @"DIE";
    test_characters = @"0123456789";
    word = [ArtikelWord wordWithArticleAndCharacters:test_article characters:test_characters context:self.managedObjectContext];
    XCTAssertNil(word);
    
    word = nil;
    test_string = @"DAS 0123456789";
    word = [ArtikelWord wordWithString:test_string context:self.managedObjectContext];
    XCTAssertNil(word);
    
    word = nil;
    test_article = @"DAS";
    test_characters = @"0123456789";
    word = [ArtikelWord wordWithArticleAndCharacters:test_article characters:test_characters context:self.managedObjectContext];
    XCTAssertNil(word);

    word = nil;
    test_string = @"abc0123456789";
    word = [ArtikelWord wordWithString:test_string context:self.managedObjectContext];
    XCTAssertNil(word);
    
    word = nil;
    test_string = @"ABC0123456789";
    word = [ArtikelWord wordWithString:test_string context:self.managedObjectContext];
    XCTAssertNil(word);
    
    word = nil;
    test_string = @"0123456789abc";
    word = [ArtikelWord wordWithString:test_string context:self.managedObjectContext];
    XCTAssertNil(word);
    
    word = nil;
    test_string = @"0123456789ABC";
    word = [ArtikelWord wordWithString:test_string context:self.managedObjectContext];
    XCTAssertNil(word);
    
    word = nil;
    test_string = @"der abc0123456789";
    word = [ArtikelWord wordWithString:test_string context:self.managedObjectContext];
    XCTAssertNil(word);
    
    word = nil;
    test_article = @"der";
    test_characters = @"abc0123456789";
    word = [ArtikelWord wordWithArticleAndCharacters:test_article characters:test_characters context:self.managedObjectContext];
    XCTAssertNil(word);
    
    word = nil;
    test_string = @"die abc0123456789";
    word = [ArtikelWord wordWithString:test_string context:self.managedObjectContext];
    XCTAssertNil(word);

    word = nil;
    test_article = @"die";
    test_characters = @"abc0123456789";
    word = [ArtikelWord wordWithArticleAndCharacters:test_article characters:test_characters context:self.managedObjectContext];
    XCTAssertNil(word);
    
    word = nil;
    test_string = @"das abc0123456789";
    word = [ArtikelWord wordWithString:test_string context:self.managedObjectContext];
    XCTAssertNil(word);

    word = nil;
    test_article = @"das";
    test_characters = @"abc0123456789";
    word = [ArtikelWord wordWithArticleAndCharacters:test_article characters:test_characters context:self.managedObjectContext];
    XCTAssertNil(word);
    
    word = nil;
    test_string = @"DER abc0123456789";
    word = [ArtikelWord wordWithString:test_string context:self.managedObjectContext];
    XCTAssertNil(word);

    word = nil;
    test_article = @"DER";
    test_characters = @"abc0123456789";
    word = [ArtikelWord wordWithArticleAndCharacters:test_article characters:test_characters context:self.managedObjectContext];
    XCTAssertNil(word);
    
    word = nil;
    test_string = @"DIE abc0123456789";
    word = [ArtikelWord wordWithString:test_string context:self.managedObjectContext];
    XCTAssertNil(word);
    
    word = nil;
    test_article = @"DIE";
    test_characters = @"abc0123456789";
    word = [ArtikelWord wordWithArticleAndCharacters:test_article characters:test_characters context:self.managedObjectContext];
    XCTAssertNil(word);
    
    word = nil;
    test_string = @"DAS abc0123456789";
    word = [ArtikelWord wordWithString:test_string context:self.managedObjectContext];
    XCTAssertNil(word);
    
    word = nil;
    test_article = @"DAS";
    test_characters = @"abc0123456789";
    word = [ArtikelWord wordWithArticleAndCharacters:test_article characters:test_characters context:self.managedObjectContext];
    XCTAssertNil(word);
    
    word = nil;
    test_string = @"der Abc0123456789";
    word = [ArtikelWord wordWithString:test_string context:self.managedObjectContext];
    XCTAssertNil(word);
    
    word = nil;
    test_article = @"der";
    test_characters = @"Abc0123456789";
    word = [ArtikelWord wordWithArticleAndCharacters:test_article characters:test_characters context:self.managedObjectContext];
    XCTAssertNil(word);
    
    word = nil;
    test_string = @"die Abc0123456789";
    word = [ArtikelWord wordWithString:test_string context:self.managedObjectContext];
    XCTAssertNil(word);

    word = nil;
    test_article = @"die";
    test_characters = @"Abc0123456789";
    word = [ArtikelWord wordWithArticleAndCharacters:test_article characters:test_characters context:self.managedObjectContext];
    XCTAssertNil(word);
    
    word = nil;
    test_string = @"das Abc0123456789";
    word = [ArtikelWord wordWithString:test_string context:self.managedObjectContext];
    XCTAssertNil(word);

    word = nil;
    test_article = @"das";
    test_characters = @"Abc0123456789";
    word = [ArtikelWord wordWithArticleAndCharacters:test_article characters:test_characters context:self.managedObjectContext];
    XCTAssertNil(word);
    
    word = nil;
    test_string = @"DER Abc0123456789";
    word = [ArtikelWord wordWithString:test_string context:self.managedObjectContext];
    XCTAssertNil(word);
    
    word = nil;
    test_article = @"DER";
    test_characters = @"Abc0123456789";
    word = [ArtikelWord wordWithArticleAndCharacters:test_article characters:test_characters context:self.managedObjectContext];
    XCTAssertNil(word);
    
    word = nil;
    test_string = @"DIE Abc0123456789";
    word = [ArtikelWord wordWithString:test_string context:self.managedObjectContext];
    XCTAssertNil(word);
    
    word = nil;
    test_article = @"DIE";
    test_characters = @"Abc0123456789";
    word = [ArtikelWord wordWithArticleAndCharacters:test_article characters:test_characters context:self.managedObjectContext];
    XCTAssertNil(word);
    
    word = nil;
    test_string = @"DAS Abc0123456789";
    word = [ArtikelWord wordWithString:test_string context:self.managedObjectContext];
    XCTAssertNil(word);

    word = nil;
    test_article = @"DAS";
    test_characters = @"Abc0123456789";
    word = [ArtikelWord wordWithArticleAndCharacters:test_article characters:test_characters context:self.managedObjectContext];
    XCTAssertNil(word);
}

-(void)testArtikelWordSpecialChars
{
    ArtikelWord * word = nil;
    NSString * test_string = @"die Tür";
    word = [ArtikelWord wordWithString:test_string context:self.managedObjectContext];
    XCTAssertNotNil(word);
    
    if (![word.article isEqualToString:@"die"]) {
        XCTFail(@"%@ did not result in die as the article, instead resulted in %@", test_string, word.article);
    }
    
    if (![word.characters isEqualToString:@"Tür"]) {
        XCTFail(@"%@ did not result in Tür as the characters, instead resulted in %@", test_string, word.characters);
    }
    
    word = nil;
    NSString * test_article = @"die";
    NSString * test_characters = @"Tür";
    word = [ArtikelWord wordWithArticleAndCharacters:test_article characters:test_characters context:self.managedObjectContext];
    XCTAssertNotNil(word);
    
    if (![word.article isEqualToString:@"die"]) {
        XCTFail(@"%@ did not result in die as the article, instead resulted in %@", test_string, word.article);
    }
    
    if (![word.characters isEqualToString:@"Tür"]) {
        XCTFail(@"%@ did not result in Tür as the characters, instead resulted in %@", test_string, word.characters);
    }
    
    word = nil;
    test_string = @"die tür";
    word = [ArtikelWord wordWithString:test_string context:self.managedObjectContext];
    XCTAssertNotNil(word);
    
    if (![word.article isEqualToString:@"die"]) {
        XCTFail(@"%@ did not result in die as the article, instead resulted in %@", test_string, word.article);
    }
    
    if (![word.characters isEqualToString:@"Tür"]) {
        XCTFail(@"%@ did not result in Tür as the characters, instead resulted in %@", test_string, word.characters);
    }
    
    word = nil;
    test_article = @"die";
    test_characters = @"tür";
    word = [ArtikelWord wordWithArticleAndCharacters:test_article characters:test_characters context:self.managedObjectContext];
    XCTAssertNotNil(word);
    
    if (![word.article isEqualToString:@"die"]) {
        XCTFail(@"%@ did not result in die as the article, instead resulted in %@", test_string, word.article);
    }
    
    if (![word.characters isEqualToString:@"Tür"]) {
        XCTFail(@"%@ did not result in Tür as the characters, instead resulted in %@", test_string, word.characters);
    }
    
    word = nil;
    test_string = @"die TÜR";
    word = [ArtikelWord wordWithString:test_string context:self.managedObjectContext];
    XCTAssertNotNil(word);
    
    if (![word.article isEqualToString:@"die"]) {
        XCTFail(@"%@ did not result in die as the article, instead resulted in %@", test_string, word.article);
    }
    
    if (![word.characters isEqualToString:@"Tür"]) {
        XCTFail(@"%@ did not result in Tür as the characters, instead resulted in %@", test_string, word.characters);
    }
    
    word = nil;
    test_article = @"die";
    test_characters = @"TÜR";
    word = [ArtikelWord wordWithArticleAndCharacters:test_article characters:test_characters context:self.managedObjectContext];
    XCTAssertNotNil(word);
    
    if (![word.article isEqualToString:@"die"]) {
        XCTFail(@"%@ did not result in die as the article, instead resulted in %@", test_string, word.article);
        
    }
    
    if (![word.characters isEqualToString:@"Tür"]) {
        XCTFail(@"%@ did not result in Tür as the characters, instead resulted in %@", test_string, word.characters);
    }
    
    word = nil;
    test_string = @"DIE Tür";
    word = [ArtikelWord wordWithString:test_string context:self.managedObjectContext];
    XCTAssertNotNil(word);
    
    if (![word.article isEqualToString:@"die"]) {
        XCTFail(@"%@ did not result in die as the article, instead resulted in %@", test_string, word.article);

    }
    
    if (![word.characters isEqualToString:@"Tür"]) {
        XCTFail(@"%@ did not result in Tür as the characters, instead resulted in %@", test_string, word.characters);
    }
    
    word = nil;
    test_article = @"DIE";
    test_characters = @"Tür";
    word = [ArtikelWord wordWithArticleAndCharacters:test_article characters:test_characters context:self.managedObjectContext];
    XCTAssertNotNil(word);
    
    if (![word.article isEqualToString:@"die"]) {
        XCTFail(@"%@ did not result in die as the article, instead resulted in %@", test_string, word.article);
        
    }
    
    if (![word.characters isEqualToString:@"Tür"]) {
        XCTFail(@"%@ did not result in Tür as the characters, instead resulted in %@", test_string, word.characters);
    }
    
    word = nil;
    test_string = @"DIE tür";
    word = [ArtikelWord wordWithString:test_string context:self.managedObjectContext];
    XCTAssertNotNil(word);
    
    if (![word.article isEqualToString:@"die"]) {
        XCTFail(@"%@ did not result in die as the article, instead resulted in %@", test_string, word.article);

    }
    
    if (![word.characters isEqualToString:@"Tür"]) {
        XCTFail(@"%@ did not result in Tür as the characters, instead resulted in %@", test_string, word.characters);
    }
    
    word = nil;
    test_article = @"DIE";
    test_characters = @"tür";
    word = [ArtikelWord wordWithArticleAndCharacters:test_article characters:test_characters context:self.managedObjectContext];
    XCTAssertNotNil(word);
    
    if (![word.article isEqualToString:@"die"]) {
        XCTFail(@"%@ did not result in die as the article, instead resulted in %@", test_string, word.article);
        
    }
    
    if (![word.characters isEqualToString:@"Tür"]) {
        XCTFail(@"%@ did not result in Tür as the characters, instead resulted in %@", test_string, word.characters);
    }
    
    word = nil;
    test_string = @"die TüR";
    word = [ArtikelWord wordWithString:test_string context:self.managedObjectContext];
    XCTAssertNotNil(word);
    
    if (![word.article isEqualToString:@"die"]) {
        XCTFail(@"%@ did not result in die as the article, instead resulted in %@", test_string, word.article);

    }
    
    if (![word.characters isEqualToString:@"Tür"]) {
        XCTFail(@"%@ did not result in Tür as the characters, instead resulted in %@", test_string, word.characters);
    }
    
    word = nil;
    test_article = @"die";
    test_characters = @"TüR";
    word = [ArtikelWord wordWithArticleAndCharacters:test_article characters:test_characters context:self.managedObjectContext];
    XCTAssertNotNil(word);
    
    if (![word.article isEqualToString:@"die"]) {
        XCTFail(@"%@ did not result in die as the article, instead resulted in %@", test_string, word.article);
        
    }
    
    if (![word.characters isEqualToString:@"Tür"]) {
        XCTFail(@"%@ did not result in Tür as the characters, instead resulted in %@", test_string, word.characters);
    }

    word = nil;
    test_string = @"die tüR";
    word = [ArtikelWord wordWithString:test_string context:self.managedObjectContext];
    XCTAssertNotNil(word);
    
    if (![word.article isEqualToString:@"die"]) {
        XCTFail(@"%@ did not result in die as the article, instead resulted in %@", test_string, word.article);

    }
    
    if (![word.characters isEqualToString:@"Tür"]) {
        XCTFail(@"%@ did not result in Tür as the characters, instead resulted in %@", test_string, word.characters);
    }
    
    word = nil;
    test_article = @"die";
    test_characters = @"tüR";
    word = [ArtikelWord wordWithArticleAndCharacters:test_article characters:test_characters context:self.managedObjectContext];
    XCTAssertNotNil(word);
    
    if (![word.article isEqualToString:@"die"]) {
        XCTFail(@"%@ did not result in die as the article, instead resulted in %@", test_string, word.article);
        
    }
    
    if (![word.characters isEqualToString:@"Tür"]) {
        XCTFail(@"%@ did not result in Tür as the characters, instead resulted in %@", test_string, word.characters);
    }
    
    word = nil;
    test_string = @"die tÜr";
    word = [ArtikelWord wordWithString:test_string context:self.managedObjectContext];
    XCTAssertNotNil(word);
    
    if (![word.article isEqualToString:@"die"]) {
        XCTFail(@"%@ did not result in die as the article, instead resulted in %@", test_string, word.article);

    }
    
    if (![word.characters isEqualToString:@"Tür"]) {
        XCTFail(@"%@ did not result in Tür as the characters, instead resulted in %@", test_string, word.characters);
    }
    
    word = nil;
    test_article = @"die";
    test_characters = @"tÜr";
    word = [ArtikelWord wordWithArticleAndCharacters:test_article characters:test_characters context:self.managedObjectContext];
    XCTAssertNotNil(word);
    
    if (![word.article isEqualToString:@"die"]) {
        XCTFail(@"%@ did not result in die as the article, instead resulted in %@", test_string, word.article);
        
    }
    
    if (![word.characters isEqualToString:@"Tür"]) {
        XCTFail(@"%@ did not result in Tür as the characters, instead resulted in %@", test_string, word.characters);
    }
    
    word = nil;
    test_string = @"DiE TüR";
    word = [ArtikelWord wordWithString:test_string context:self.managedObjectContext];
    XCTAssertNotNil(word);
    
    if (![word.article isEqualToString:@"die"]) {
        XCTFail(@"%@ did not result in die as the article, instead resulted in %@", test_string, word.article);

    }
    
    if (![word.characters isEqualToString:@"Tür"]) {
        XCTFail(@"%@ did not result in Tür as the characters, instead resulted in %@", test_string, word.characters);
    }
    
    word = nil;
    test_article = @"DiE";
    test_characters = @"TüR";
    word = [ArtikelWord wordWithArticleAndCharacters:test_article characters:test_characters context:self.managedObjectContext];
    XCTAssertNotNil(word);
    
    if (![word.article isEqualToString:@"die"]) {
        XCTFail(@"%@ did not result in die as the article, instead resulted in %@", test_string, word.article);
        
    }
    
    if (![word.characters isEqualToString:@"Tür"]) {
        XCTFail(@"%@ did not result in Tür as the characters, instead resulted in %@", test_string, word.characters);
    }
    
    word = nil;
    test_string = @"diE tüR";
    word = [ArtikelWord wordWithString:test_string context:self.managedObjectContext];
    XCTAssertNotNil(word);
    
    if (![word.article isEqualToString:@"die"]) {
        XCTFail(@"%@ did not result in die as the article, instead resulted in %@", test_string, word.article);

    }
    
    if (![word.characters isEqualToString:@"Tür"]) {
        XCTFail(@"%@ did not result in Tür as the characters, instead resulted in %@", test_string, word.characters);
    }
    
    word = nil;
    test_article = @"diE";
    test_characters = @"tüR";
    word = [ArtikelWord wordWithArticleAndCharacters:test_article characters:test_characters context:self.managedObjectContext];
    XCTAssertNotNil(word);
    
    if (![word.article isEqualToString:@"die"]) {
        XCTFail(@"%@ did not result in die as the article, instead resulted in %@", test_string, word.article);
        
    }
    
    if (![word.characters isEqualToString:@"Tür"]) {
        XCTFail(@"%@ did not result in Tür as the characters, instead resulted in %@", test_string, word.characters);
    }
    
    word = nil;
    test_string = @"dIe tÜr";
    word = [ArtikelWord wordWithString:test_string context:self.managedObjectContext];
    XCTAssertNotNil(word);
    
    if (![word.article isEqualToString:@"die"]) {
        XCTFail(@"%@ did not result in die as the article, instead resulted in %@", test_string, word.article);

    }
    
    if (![word.characters isEqualToString:@"Tür"]) {
        XCTFail(@"%@ did not result in Tür as the characters, instead resulted in %@", test_string, word.characters);
    }
    
    word = nil;
    test_article = @"dIe";
    test_characters = @"tÜr";
    word = [ArtikelWord wordWithArticleAndCharacters:test_article characters:test_characters context:self.managedObjectContext];
    XCTAssertNotNil(word);
    
    if (![word.article isEqualToString:@"die"]) {
        XCTFail(@"%@ did not result in die as the article, instead resulted in %@", test_string, word.article);
        
    }
    
    if (![word.characters isEqualToString:@"Tür"]) {
        XCTFail(@"%@ did not result in Tür as the characters, instead resulted in %@", test_string, word.characters);
    }
    
    word = nil;
    word = [ArtikelWord wordWithString:@"tür" context:self.managedObjectContext];
    XCTAssertNil(word);
    
    word = nil;
    word = [ArtikelWord wordWithString:@"TÜR" context:self.managedObjectContext];
    XCTAssertNil(word);
    
    word = nil;
    word = [ArtikelWord wordWithString:@"tür " context:self.managedObjectContext];
    XCTAssertNil(word);
    
    word = nil;
    word = [ArtikelWord wordWithString:@"TÜR " context:self.managedObjectContext];
    XCTAssertNil(word);
    
    word = nil;
    word = [ArtikelWord wordWithString:@" tür" context:self.managedObjectContext];
    XCTAssertNil(word);
    
    word = nil;
    word = [ArtikelWord wordWithString:@" TÜR" context:self.managedObjectContext];
    XCTAssertNil(word);
    
    word = nil;
    word = [ArtikelWord wordWithString:@" tür " context:self.managedObjectContext];
    XCTAssertNil(word);
    
    word = nil;
    word = [ArtikelWord wordWithString:@" TÜR " context:self.managedObjectContext];
    XCTAssertNil(word);
    
    word = nil;
    word = [ArtikelWord wordWithString:@"dietür" context:self.managedObjectContext];
    XCTAssertNil(word);
    
    word = nil;
    word = [ArtikelWord wordWithString:@"dieTür" context:self.managedObjectContext];
    XCTAssertNil(word);
    
    word = nil;
    word = [ArtikelWord wordWithString:@"dieTÜR" context:self.managedObjectContext];
    XCTAssertNil(word);
    
    word = nil;
    word = [ArtikelWord wordWithString:@"die $%#" context:self.managedObjectContext];
    XCTAssertNil(word);
    
    word = nil;
    word = [ArtikelWord wordWithString:@"DIE $%#" context:self.managedObjectContext];
    XCTAssertNil(word);
    
    word = nil;
    word = [ArtikelWord wordWithString:@"$%#" context:self.managedObjectContext];
    XCTAssertNil(word);
}

-(void)testArtikelNullCases
{
    ArtikelWord * word = nil;
    NSString * test_string = nil;
    word = [ArtikelWord wordWithString:test_string context:self.managedObjectContext];
    XCTAssertNil(word);
    
    word = nil;
    NSString * test_article = nil;
    NSString * test_characters = @"0123456789";
    word = [ArtikelWord wordWithArticleAndCharacters:test_article characters:test_characters context:self.managedObjectContext];
    XCTAssertNil(word);

    word = nil;
    test_article = @"die";
    test_characters = nil;
    word = [ArtikelWord wordWithArticleAndCharacters:test_article characters:test_characters context:self.managedObjectContext];
    XCTAssertNil(word);
    
    word = nil;
    test_article = nil;
    test_characters = nil;
    word = [ArtikelWord wordWithArticleAndCharacters:test_article characters:test_characters context:self.managedObjectContext];
    XCTAssertNil(word);
}

@end
