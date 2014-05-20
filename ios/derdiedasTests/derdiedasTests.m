//
//  derdiedasTests.m
//  derdiedasTests
//
//  Created by Christopher Berry on 15/03/2014.
//  Copyright (c) 2014 Christopher Berry. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "DerDieDasWord.h"

@interface derdiedasTests : XCTestCase

@property (strong, nonatomic) NSManagedObjectContext * managedObjectContext;

- (void)testDerDieDasWordNormalChars;
- (void)testDerDieDasWordNumericalChars;
- (void)testDerDieDasWordSpecialChars;
- (void)testDerDieDasWordRepeatedSequencesAndSpaces;
- (void)testDerDieDasNullCases;

@end

@implementation derdiedasTests

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

- (void)testDerDieDasWordNormalChars
{
    DerDieDasWord * word = nil;
    NSString * test_string = @"die Katze";
    word = [DerDieDasWord initWithString:test_string context:self.managedObjectContext];
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
    word = [DerDieDasWord initWithArticleAndCharacters:test_article characters:test_characters context:self.managedObjectContext];
    if (![word.article isEqualToString:@"die"]) {
        XCTFail(@"%@ did not result in die as the article, instead resulted in %@", test_string, word.article);

    }
    
    if (![word.characters isEqualToString:@"Katze"]) {
        XCTFail(@"%@ did not result in Katze as the characters, instead resulted in %@", test_string, word.characters);
    }
    
    word = nil;
    test_string = @"die katze";
    word = [DerDieDasWord initWithString:test_string context:self.managedObjectContext];
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
    word = [DerDieDasWord initWithArticleAndCharacters:test_article characters:test_characters context:self.managedObjectContext];
    if (![word.article isEqualToString:@"die"]) {
        XCTFail(@"%@ did not result in die as the article, instead resulted in %@", test_string, word.article);

    }
    
    if (![word.characters isEqualToString:@"Katze"]) {
        XCTFail(@"%@ did not result in Katze as the characters, instead resulted in %@", test_string, word.characters);
    }
 
    word = nil;
    test_string = @" die Katze";
    word = [DerDieDasWord initWithString:test_string context:self.managedObjectContext];
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
    word = [DerDieDasWord initWithArticleAndCharacters:test_article characters:test_characters context:self.managedObjectContext];
    if (![word.article isEqualToString:@"die"]) {
        XCTFail(@"%@ did not result in die as the article, instead resulted in %@", test_string, word.article);

    }
    
    if (![word.characters isEqualToString:@"Katze"]) {
        XCTFail(@"%@ did not result in Katze as the characters, instead resulted in %@", test_string, word.characters);
    }
    
    word = nil;
    test_string = @"die Katze ";
    word = [DerDieDasWord initWithString:test_string context:self.managedObjectContext];
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
    word = [DerDieDasWord initWithArticleAndCharacters:test_article characters:test_characters context:self.managedObjectContext];
    if (![word.article isEqualToString:@"die"]) {
        XCTFail(@"%@ did not result in die as the article, instead resulted in %@", test_string, word.article);

    }
    
    if (![word.characters isEqualToString:@"Katze"]) {
        XCTFail(@"%@ did not result in Katze as the characters, instead resulted in %@", test_string, word.characters);
    }
    
    word = nil;
    test_string = @" die katze";
    word = [DerDieDasWord initWithString:test_string context:self.managedObjectContext];
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
    word = [DerDieDasWord initWithArticleAndCharacters:test_article characters:test_characters context:self.managedObjectContext];
    if (![word.article isEqualToString:@"die"]) {
        XCTFail(@"%@ did not result in die as the article, instead resulted in %@", test_string, word.article);
    }
    
    if (![word.characters isEqualToString:@"Katze"]) {
        XCTFail(@"%@ did not result in Katze as the characters, instead resulted in %@", test_string, word.characters);
    }
    
    word = nil;
    test_string = @"die katze ";
    word = [DerDieDasWord initWithString:test_string context:self.managedObjectContext];
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
    word = [DerDieDasWord initWithArticleAndCharacters:test_article characters:test_characters context:self.managedObjectContext];
    if (![word.article isEqualToString:@"die"]) {
        XCTFail(@"%@ did not result in die as the article, instead resulted in %@", test_string, word.article);

    }
    
    if (![word.characters isEqualToString:@"Katze"]) {
        XCTFail(@"%@ did not result in Katze as the characters, instead resulted in %@", test_string, word.characters);
    }
    
    word = nil;
    test_string = @"die KATZE";
    word = [DerDieDasWord initWithString:test_string context:self.managedObjectContext];
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
    word = [DerDieDasWord initWithArticleAndCharacters:test_article characters:test_characters context:self.managedObjectContext];
    if (![word.article isEqualToString:@"die"]) {
        XCTFail(@"%@ did not result in die as the article, instead resulted in %@", test_string, word.article);

    }
    
    if (![word.characters isEqualToString:@"Katze"]) {
        XCTFail(@"%@ did not result in Katze as the characters, instead resulted in %@", test_string, word.characters);
    }
    
    word = nil;
    test_string = @"DIE Katze";
    word = [DerDieDasWord initWithString:test_string context:self.managedObjectContext];
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
    word = [DerDieDasWord initWithArticleAndCharacters:test_article characters:test_characters context:self.managedObjectContext];
    if (![word.article isEqualToString:@"die"]) {
        XCTFail(@"%@ did not result in die as the article, instead resulted in %@", test_string, word.article);

    }
    
    if (![word.characters isEqualToString:@"Katze"]) {
        XCTFail(@"%@ did not result in Katze as the characters, instead resulted in %@", test_string, word.characters);
    }

    word = nil;
    test_string = @"DIE katze";
    word = [DerDieDasWord initWithString:test_string context:self.managedObjectContext];
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
    word = [DerDieDasWord initWithArticleAndCharacters:test_article characters:test_characters context:self.managedObjectContext];
    if (![word.article isEqualToString:@"die"]) {
        XCTFail(@"%@ did not result in die as the article, instead resulted in %@", test_string, word.article);

    }
    
    if (![word.characters isEqualToString:@"Katze"]) {
        XCTFail(@"%@ did not result in Katze as the characters, instead resulted in %@", test_string, word.characters);
    }
    
    word = nil;
    test_string = @"die KaTzE";
    word = [DerDieDasWord initWithString:test_string context:self.managedObjectContext];
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
    word = [DerDieDasWord initWithArticleAndCharacters:test_article characters:test_characters context:self.managedObjectContext];
    if (![word.article isEqualToString:@"die"]) {
        XCTFail(@"%@ did not result in die as the article, instead resulted in %@", test_string, word.article);

    }
    
    if (![word.characters isEqualToString:@"Katze"]) {
        XCTFail(@"%@ did not result in Katze as the characters, instead resulted in %@", test_string, word.characters);
    }
    
    word = nil;
    test_string = @"die kAtZe";
    word = [DerDieDasWord initWithString:test_string context:self.managedObjectContext];
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
    word = [DerDieDasWord initWithArticleAndCharacters:test_article characters:test_characters context:self.managedObjectContext];
    if (![word.article isEqualToString:@"die"]) {
        XCTFail(@"%@ did not result in die as the article, instead resulted in %@", test_string, word.article);

    }
    
    if (![word.characters isEqualToString:@"Katze"]) {
        XCTFail(@"%@ did not result in Katze as the characters, instead resulted in %@", test_string, word.characters);
    }
    
    word = nil;
    test_string = @"DIE KaTzE";
    word = [DerDieDasWord initWithString:test_string context:self.managedObjectContext];
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
    word = [DerDieDasWord initWithArticleAndCharacters:test_article characters:test_characters context:self.managedObjectContext];
    if (![word.article isEqualToString:@"die"]) {
        XCTFail(@"%@ did not result in die as the article, instead resulted in %@", test_string, word.article);

    }
    
    if (![word.characters isEqualToString:@"Katze"]) {
        XCTFail(@"%@ did not result in Katze as the characters, instead resulted in %@", test_string, word.characters);
    }
    
    word = nil;
    test_string = @"DIE kAtZe";
    word = [DerDieDasWord initWithString:test_string context:self.managedObjectContext];
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
    word = [DerDieDasWord initWithArticleAndCharacters:test_article characters:test_characters context:self.managedObjectContext];
    if (![word.article isEqualToString:@"die"]) {
        XCTFail(@"%@ did not result in die as the article, instead resulted in %@", test_string, word.article);

    }
    
    if (![word.characters isEqualToString:@"Katze"]) {
        XCTFail(@"%@ did not result in Katze as the characters, instead resulted in %@", test_string, word.characters);
    }

    word = nil;
    word = [DerDieDasWord initWithString:@"" context:self.managedObjectContext];
    XCTAssertNil(word);
    
    word = nil;
    word = [DerDieDasWord initWithString:@" " context:self.managedObjectContext];
    XCTAssertNil(word);
    
    word = nil;
    word = [DerDieDasWord initWithString:@"die" context:self.managedObjectContext];
    XCTAssertNil(word);

    word = nil;
    word = [DerDieDasWord initWithString:@"DIE" context:self.managedObjectContext];
    XCTAssertNil(word);

    word = nil;
    word = [DerDieDasWord initWithString:@"die " context:self.managedObjectContext];
    XCTAssertNil(word);
    
    word = nil;
    word = [DerDieDasWord initWithString:@"DIE " context:self.managedObjectContext];
    XCTAssertNil(word);
    
    word = nil;
    word = [DerDieDasWord initWithString:@" die" context:self.managedObjectContext];
    XCTAssertNil(word);
    
    word = nil;
    word = [DerDieDasWord initWithString:@" DIE" context:self.managedObjectContext];
    XCTAssertNil(word);

    word = nil;
    word = [DerDieDasWord initWithString:@" die " context:self.managedObjectContext];
    XCTAssertNil(word);
    
    word = nil;
    word = [DerDieDasWord initWithString:@" DIE " context:self.managedObjectContext];
    XCTAssertNil(word);
    
    word = nil;
    word = [DerDieDasWord initWithString:@"katze" context:self.managedObjectContext];
    XCTAssertNil(word);
    
    word = nil;
    word = [DerDieDasWord initWithString:@"KATZE" context:self.managedObjectContext];
    XCTAssertNil(word);

    word = nil;
    word = [DerDieDasWord initWithString:@"katze " context:self.managedObjectContext];
    XCTAssertNil(word);
    
    word = nil;
    word = [DerDieDasWord initWithString:@"KATZE " context:self.managedObjectContext];
    XCTAssertNil(word);

    word = nil;
    word = [DerDieDasWord initWithString:@" katze" context:self.managedObjectContext];
    XCTAssertNil(word);
    
    word = nil;
    word = [DerDieDasWord initWithString:@" KATZE" context:self.managedObjectContext];
    XCTAssertNil(word);

    word = nil;
    word = [DerDieDasWord initWithString:@" katze " context:self.managedObjectContext];
    XCTAssertNil(word);
    
    word = nil;
    word = [DerDieDasWord initWithString:@" KATZE " context:self.managedObjectContext];
    XCTAssertNil(word);
    
    word = nil;
    word = [DerDieDasWord initWithString:@"diekatze" context:self.managedObjectContext];
    XCTAssertNil(word);
    
    word = nil;
    word = [DerDieDasWord initWithString:@"dieKatze" context:self.managedObjectContext];
    XCTAssertNil(word);
    
    word = nil;
    word = [DerDieDasWord initWithString:@"dieKATZE" context:self.managedObjectContext];
    XCTAssertNil(word);
}

- (void)testDerDieDasWordNumericalChars
{
    DerDieDasWord * word = nil;
    NSString * test_string = @"0123456789";
    word = [DerDieDasWord initWithString:test_string context:self.managedObjectContext];
    XCTAssertNil(word);
    
    word = nil;
    test_string = @"der 0123456789";
    word = [DerDieDasWord initWithString:test_string context:self.managedObjectContext];
    XCTAssertNil(word);
    
    word = nil;
    NSString * test_article = @"der";
    NSString * test_characters = @"0123456789";
    word = [DerDieDasWord initWithArticleAndCharacters:test_article characters:test_characters context:self.managedObjectContext];
    XCTAssertNil(word);
    
    word = nil;
    test_string = @"die 0123456789";
    word = [DerDieDasWord initWithString:test_string context:self.managedObjectContext];
    XCTAssertNil(word);
    
    word = nil;
    test_article = @"die";
    test_characters = @"0123456789";
    word = [DerDieDasWord initWithArticleAndCharacters:test_article characters:test_characters context:self.managedObjectContext];
    XCTAssertNil(word);
    
    word = nil;
    test_string = @"das 0123456789";
    word = [DerDieDasWord initWithString:test_string context:self.managedObjectContext];
    XCTAssertNil(word);

    word = nil;
    test_article = @"das";
    test_characters = @"0123456789";
    word = [DerDieDasWord initWithArticleAndCharacters:test_article characters:test_characters context:self.managedObjectContext];
    XCTAssertNil(word);
    
    word = nil;
    test_string = @"DER 0123456789";
    word = [DerDieDasWord initWithString:test_string context:self.managedObjectContext];
    XCTAssertNil(word);
    
    word = nil;
    test_article = @"DER";
    test_characters = @"0123456789";
    word = [DerDieDasWord initWithArticleAndCharacters:test_article characters:test_characters context:self.managedObjectContext];
    XCTAssertNil(word);
    
    word = nil;
    test_string = @"DIE 0123456789";
    word = [DerDieDasWord initWithString:test_string context:self.managedObjectContext];
    XCTAssertNil(word);
    
    word = nil;
    test_article = @"DIE";
    test_characters = @"0123456789";
    word = [DerDieDasWord initWithArticleAndCharacters:test_article characters:test_characters context:self.managedObjectContext];
    XCTAssertNil(word);
    
    word = nil;
    test_string = @"DAS 0123456789";
    word = [DerDieDasWord initWithString:test_string context:self.managedObjectContext];
    XCTAssertNil(word);
    
    word = nil;
    test_article = @"DAS";
    test_characters = @"0123456789";
    word = [DerDieDasWord initWithArticleAndCharacters:test_article characters:test_characters context:self.managedObjectContext];
    XCTAssertNil(word);

    word = nil;
    test_string = @"abc0123456789";
    word = [DerDieDasWord initWithString:test_string context:self.managedObjectContext];
    XCTAssertNil(word);
    
    word = nil;
    test_string = @"ABC0123456789";
    word = [DerDieDasWord initWithString:test_string context:self.managedObjectContext];
    XCTAssertNil(word);
    
    word = nil;
    test_string = @"0123456789abc";
    word = [DerDieDasWord initWithString:test_string context:self.managedObjectContext];
    XCTAssertNil(word);
    
    word = nil;
    test_string = @"0123456789ABC";
    word = [DerDieDasWord initWithString:test_string context:self.managedObjectContext];
    XCTAssertNil(word);
    
    word = nil;
    test_string = @"der abc0123456789";
    word = [DerDieDasWord initWithString:test_string context:self.managedObjectContext];
    XCTAssertNil(word);
    
    word = nil;
    test_article = @"der";
    test_characters = @"abc0123456789";
    word = [DerDieDasWord initWithArticleAndCharacters:test_article characters:test_characters context:self.managedObjectContext];
    XCTAssertNil(word);
    
    word = nil;
    test_string = @"die abc0123456789";
    word = [DerDieDasWord initWithString:test_string context:self.managedObjectContext];
    XCTAssertNil(word);

    word = nil;
    test_article = @"die";
    test_characters = @"abc0123456789";
    word = [DerDieDasWord initWithArticleAndCharacters:test_article characters:test_characters context:self.managedObjectContext];
    XCTAssertNil(word);
    
    word = nil;
    test_string = @"das abc0123456789";
    word = [DerDieDasWord initWithString:test_string context:self.managedObjectContext];
    XCTAssertNil(word);

    word = nil;
    test_article = @"das";
    test_characters = @"abc0123456789";
    word = [DerDieDasWord initWithArticleAndCharacters:test_article characters:test_characters context:self.managedObjectContext];
    XCTAssertNil(word);
    
    word = nil;
    test_string = @"DER abc0123456789";
    word = [DerDieDasWord initWithString:test_string context:self.managedObjectContext];
    XCTAssertNil(word);

    word = nil;
    test_article = @"DER";
    test_characters = @"abc0123456789";
    word = [DerDieDasWord initWithArticleAndCharacters:test_article characters:test_characters context:self.managedObjectContext];
    XCTAssertNil(word);
    
    word = nil;
    test_string = @"DIE abc0123456789";
    word = [DerDieDasWord initWithString:test_string context:self.managedObjectContext];
    XCTAssertNil(word);
    
    word = nil;
    test_article = @"DIE";
    test_characters = @"abc0123456789";
    word = [DerDieDasWord initWithArticleAndCharacters:test_article characters:test_characters context:self.managedObjectContext];
    XCTAssertNil(word);
    
    word = nil;
    test_string = @"DAS abc0123456789";
    word = [DerDieDasWord initWithString:test_string context:self.managedObjectContext];
    XCTAssertNil(word);
    
    word = nil;
    test_article = @"DAS";
    test_characters = @"abc0123456789";
    word = [DerDieDasWord initWithArticleAndCharacters:test_article characters:test_characters context:self.managedObjectContext];
    XCTAssertNil(word);
    
    word = nil;
    test_string = @"der Abc0123456789";
    word = [DerDieDasWord initWithString:test_string context:self.managedObjectContext];
    XCTAssertNil(word);
    
    word = nil;
    test_article = @"der";
    test_characters = @"Abc0123456789";
    word = [DerDieDasWord initWithArticleAndCharacters:test_article characters:test_characters context:self.managedObjectContext];
    XCTAssertNil(word);
    
    word = nil;
    test_string = @"die Abc0123456789";
    word = [DerDieDasWord initWithString:test_string context:self.managedObjectContext];
    XCTAssertNil(word);

    word = nil;
    test_article = @"die";
    test_characters = @"Abc0123456789";
    word = [DerDieDasWord initWithArticleAndCharacters:test_article characters:test_characters context:self.managedObjectContext];
    XCTAssertNil(word);
    
    word = nil;
    test_string = @"das Abc0123456789";
    word = [DerDieDasWord initWithString:test_string context:self.managedObjectContext];
    XCTAssertNil(word);

    word = nil;
    test_article = @"das";
    test_characters = @"Abc0123456789";
    word = [DerDieDasWord initWithArticleAndCharacters:test_article characters:test_characters context:self.managedObjectContext];
    XCTAssertNil(word);
    
    word = nil;
    test_string = @"DER Abc0123456789";
    word = [DerDieDasWord initWithString:test_string context:self.managedObjectContext];
    XCTAssertNil(word);
    
    word = nil;
    test_article = @"DER";
    test_characters = @"Abc0123456789";
    word = [DerDieDasWord initWithArticleAndCharacters:test_article characters:test_characters context:self.managedObjectContext];
    XCTAssertNil(word);
    
    word = nil;
    test_string = @"DIE Abc0123456789";
    word = [DerDieDasWord initWithString:test_string context:self.managedObjectContext];
    XCTAssertNil(word);
    
    word = nil;
    test_article = @"DIE";
    test_characters = @"Abc0123456789";
    word = [DerDieDasWord initWithArticleAndCharacters:test_article characters:test_characters context:self.managedObjectContext];
    XCTAssertNil(word);
    
    word = nil;
    test_string = @"DAS Abc0123456789";
    word = [DerDieDasWord initWithString:test_string context:self.managedObjectContext];
    XCTAssertNil(word);

    word = nil;
    test_article = @"DAS";
    test_characters = @"Abc0123456789";
    word = [DerDieDasWord initWithArticleAndCharacters:test_article characters:test_characters context:self.managedObjectContext];
    XCTAssertNil(word);
}

-(void)testDerDieDasWordSpecialChars
{
    DerDieDasWord * word = nil;
    NSString * test_string = @"die Tür";
    word = [DerDieDasWord initWithString:test_string context:self.managedObjectContext];
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
    word = [DerDieDasWord initWithArticleAndCharacters:test_article characters:test_characters context:self.managedObjectContext];
    if (![word.article isEqualToString:@"die"]) {
        XCTFail(@"%@ did not result in die as the article, instead resulted in %@", test_string, word.article);
        
    }
    
    if (![word.characters isEqualToString:@"Tür"]) {
        XCTFail(@"%@ did not result in Tür as the characters, instead resulted in %@", test_string, word.characters);
    }
    
    word = nil;
    test_string = @"die tür";
    word = [DerDieDasWord initWithString:test_string context:self.managedObjectContext];
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
    word = [DerDieDasWord initWithArticleAndCharacters:test_article characters:test_characters context:self.managedObjectContext];
    if (![word.article isEqualToString:@"die"]) {
        XCTFail(@"%@ did not result in die as the article, instead resulted in %@", test_string, word.article);
        
    }
    
    if (![word.characters isEqualToString:@"Tür"]) {
        XCTFail(@"%@ did not result in Tür as the characters, instead resulted in %@", test_string, word.characters);
    }
    
    word = nil;
    test_string = @"die TÜR";
    word = [DerDieDasWord initWithString:test_string context:self.managedObjectContext];
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
    word = [DerDieDasWord initWithArticleAndCharacters:test_article characters:test_characters context:self.managedObjectContext];
    if (![word.article isEqualToString:@"die"]) {
        XCTFail(@"%@ did not result in die as the article, instead resulted in %@", test_string, word.article);
        
    }
    
    if (![word.characters isEqualToString:@"Tür"]) {
        XCTFail(@"%@ did not result in Tür as the characters, instead resulted in %@", test_string, word.characters);
    }
    
    word = nil;
    test_string = @"DIE Tür";
    word = [DerDieDasWord initWithString:test_string context:self.managedObjectContext];
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
    word = [DerDieDasWord initWithArticleAndCharacters:test_article characters:test_characters context:self.managedObjectContext];
    if (![word.article isEqualToString:@"die"]) {
        XCTFail(@"%@ did not result in die as the article, instead resulted in %@", test_string, word.article);
        
    }
    
    if (![word.characters isEqualToString:@"Tür"]) {
        XCTFail(@"%@ did not result in Tür as the characters, instead resulted in %@", test_string, word.characters);
    }
    
    word = nil;
    test_string = @"DIE tür";
    word = [DerDieDasWord initWithString:test_string context:self.managedObjectContext];
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
    word = [DerDieDasWord initWithArticleAndCharacters:test_article characters:test_characters context:self.managedObjectContext];
    if (![word.article isEqualToString:@"die"]) {
        XCTFail(@"%@ did not result in die as the article, instead resulted in %@", test_string, word.article);
        
    }
    
    if (![word.characters isEqualToString:@"Tür"]) {
        XCTFail(@"%@ did not result in Tür as the characters, instead resulted in %@", test_string, word.characters);
    }
    
    word = nil;
    test_string = @"die TüR";
    word = [DerDieDasWord initWithString:test_string context:self.managedObjectContext];
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
    word = [DerDieDasWord initWithArticleAndCharacters:test_article characters:test_characters context:self.managedObjectContext];
    if (![word.article isEqualToString:@"die"]) {
        XCTFail(@"%@ did not result in die as the article, instead resulted in %@", test_string, word.article);
        
    }
    
    if (![word.characters isEqualToString:@"Tür"]) {
        XCTFail(@"%@ did not result in Tür as the characters, instead resulted in %@", test_string, word.characters);
    }

    word = nil;
    test_string = @"die tüR";
    word = [DerDieDasWord initWithString:test_string context:self.managedObjectContext];
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
    word = [DerDieDasWord initWithArticleAndCharacters:test_article characters:test_characters context:self.managedObjectContext];
    if (![word.article isEqualToString:@"die"]) {
        XCTFail(@"%@ did not result in die as the article, instead resulted in %@", test_string, word.article);
        
    }
    
    if (![word.characters isEqualToString:@"Tür"]) {
        XCTFail(@"%@ did not result in Tür as the characters, instead resulted in %@", test_string, word.characters);
    }
    
    word = nil;
    test_string = @"die tÜr";
    word = [DerDieDasWord initWithString:test_string context:self.managedObjectContext];
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
    word = [DerDieDasWord initWithArticleAndCharacters:test_article characters:test_characters context:self.managedObjectContext];
    if (![word.article isEqualToString:@"die"]) {
        XCTFail(@"%@ did not result in die as the article, instead resulted in %@", test_string, word.article);
        
    }
    
    if (![word.characters isEqualToString:@"Tür"]) {
        XCTFail(@"%@ did not result in Tür as the characters, instead resulted in %@", test_string, word.characters);
    }
    
    word = nil;
    test_string = @"DiE TüR";
    word = [DerDieDasWord initWithString:test_string context:self.managedObjectContext];
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
    word = [DerDieDasWord initWithArticleAndCharacters:test_article characters:test_characters context:self.managedObjectContext];
    if (![word.article isEqualToString:@"die"]) {
        XCTFail(@"%@ did not result in die as the article, instead resulted in %@", test_string, word.article);
        
    }
    
    if (![word.characters isEqualToString:@"Tür"]) {
        XCTFail(@"%@ did not result in Tür as the characters, instead resulted in %@", test_string, word.characters);
    }
    
    word = nil;
    test_string = @"diE tüR";
    word = [DerDieDasWord initWithString:test_string context:self.managedObjectContext];
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
    word = [DerDieDasWord initWithArticleAndCharacters:test_article characters:test_characters context:self.managedObjectContext];
    if (![word.article isEqualToString:@"die"]) {
        XCTFail(@"%@ did not result in die as the article, instead resulted in %@", test_string, word.article);
        
    }
    
    if (![word.characters isEqualToString:@"Tür"]) {
        XCTFail(@"%@ did not result in Tür as the characters, instead resulted in %@", test_string, word.characters);
    }
    
    word = nil;
    test_string = @"dIe tÜr";
    word = [DerDieDasWord initWithString:test_string context:self.managedObjectContext];
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
    word = [DerDieDasWord initWithArticleAndCharacters:test_article characters:test_characters context:self.managedObjectContext];
    if (![word.article isEqualToString:@"die"]) {
        XCTFail(@"%@ did not result in die as the article, instead resulted in %@", test_string, word.article);
        
    }
    
    if (![word.characters isEqualToString:@"Tür"]) {
        XCTFail(@"%@ did not result in Tür as the characters, instead resulted in %@", test_string, word.characters);
    }
    
    word = nil;
    word = [DerDieDasWord initWithString:@"tür" context:self.managedObjectContext];
    XCTAssertNil(word);
    
    word = nil;
    word = [DerDieDasWord initWithString:@"TÜR" context:self.managedObjectContext];
    XCTAssertNil(word);
    
    word = nil;
    word = [DerDieDasWord initWithString:@"tür " context:self.managedObjectContext];
    XCTAssertNil(word);
    
    word = nil;
    word = [DerDieDasWord initWithString:@"TÜR " context:self.managedObjectContext];
    XCTAssertNil(word);
    
    word = nil;
    word = [DerDieDasWord initWithString:@" tür" context:self.managedObjectContext];
    XCTAssertNil(word);
    
    word = nil;
    word = [DerDieDasWord initWithString:@" TÜR" context:self.managedObjectContext];
    XCTAssertNil(word);
    
    word = nil;
    word = [DerDieDasWord initWithString:@" tür " context:self.managedObjectContext];
    XCTAssertNil(word);
    
    word = nil;
    word = [DerDieDasWord initWithString:@" TÜR " context:self.managedObjectContext];
    XCTAssertNil(word);
    
    word = nil;
    word = [DerDieDasWord initWithString:@"dietür" context:self.managedObjectContext];
    XCTAssertNil(word);
    
    word = nil;
    word = [DerDieDasWord initWithString:@"dieTür" context:self.managedObjectContext];
    XCTAssertNil(word);
    
    word = nil;
    word = [DerDieDasWord initWithString:@"dieTÜR" context:self.managedObjectContext];
    XCTAssertNil(word);
    
    word = nil;
    word = [DerDieDasWord initWithString:@"die $%#" context:self.managedObjectContext];
    XCTAssertNil(word);
    
    word = nil;
    word = [DerDieDasWord initWithString:@"DIE $%#" context:self.managedObjectContext];
    XCTAssertNil(word);
    
    word = nil;
    word = [DerDieDasWord initWithString:@"$%#" context:self.managedObjectContext];
    XCTAssertNil(word);
}

- (void)testDerDieDasWordRepeatedSequencesAndSpaces
{
    DerDieDasWord * word = nil;
    NSString * test_string = @"die die Katze";
    word = [DerDieDasWord initWithString:test_string context:self.managedObjectContext];
    XCTAssertNil(word);
    
    word = nil;
    test_string = @"die Katze Katze";
    word = [DerDieDasWord initWithString:test_string context:self.managedObjectContext];
    XCTAssertNil(word);
    
    word = nil;
    test_string = @"die K atze";
    word = [DerDieDasWord initWithString:test_string context:self.managedObjectContext];
    XCTAssertNil(word);
    
    word = nil;
    test_string = @"die Ka tze";
    word = [DerDieDasWord initWithString:test_string context:self.managedObjectContext];
    XCTAssertNil(word);
    
    word = nil;
    test_string = @"die Kat ze";
    word = [DerDieDasWord initWithString:test_string context:self.managedObjectContext];
    XCTAssertNil(word);
    
    word = nil;
    test_string = @"die Katz e";
    word = [DerDieDasWord initWithString:test_string context:self.managedObjectContext];
    XCTAssertNil(word);
    
    word = nil;
    test_string = @"d ie Katze";
    word = [DerDieDasWord initWithString:test_string context:self.managedObjectContext];
    XCTAssertNil(word);
    
    word = nil;
    test_string = @"di e Katze";
    word = [DerDieDasWord initWithString:test_string context:self.managedObjectContext];
    XCTAssertNil(word);
}

-(void)testDerDieDasNullCases
{
    DerDieDasWord * word = nil;
    NSString * test_string = nil;
    word = [DerDieDasWord initWithString:test_string context:self.managedObjectContext];
    XCTAssertNil(word);
    
    word = nil;
    NSString * test_article = nil;
    NSString * test_characters = @"0123456789";
    word = [DerDieDasWord initWithArticleAndCharacters:test_article characters:test_characters context:self.managedObjectContext];
    XCTAssertNil(word);

    word = nil;
    test_article = @"die";
    test_characters = nil;
    word = [DerDieDasWord initWithArticleAndCharacters:test_article characters:test_characters context:self.managedObjectContext];
    XCTAssertNil(word);
    
    word = nil;
    test_article = nil;
    test_characters = nil;
    word = [DerDieDasWord initWithArticleAndCharacters:test_article characters:test_characters context:self.managedObjectContext];
    XCTAssertNil(word);
}

@end