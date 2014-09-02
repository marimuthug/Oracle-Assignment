//
//  LFUserDataModelTests.m
//  LFUserDataModelTests
//
//  Created by Marimuthu Govindasamy on 30/08/14.
//  Copyright (c) 2014 Marimuthu Govindasamy. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "LFUserDataModel.h"
@interface LFUserDataModelTests : XCTestCase

@end

@implementation LFUserDataModelTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

-(void)testGetName{
    
    NSString *testData1ForName = @"Muthu";
    NSString *testData2ForName = @"Martin";
    
    [LFUserDataModel setName:testData1ForName];
    
    XCTAssertNotNil([LFUserDataModel getName], @"This is a null response");
    XCTAssertEqual([LFUserDataModel getName],testData1ForName, @"Data retrieved is wrong");
    XCTAssertNotEqual([LFUserDataModel getName], testData2ForName, @"Data retrieved is wrong");

}

-(void)testGetLatitude{
    
    NSString *testData1ForLatitude = @"20.0000";
    NSString *testData2ForLatitude = @"21.0000";
    
    [LFUserDataModel setLatitude:testData1ForLatitude];
    
    XCTAssertNotNil([LFUserDataModel getLatitude], @"This is a null response");
    XCTAssertEqualObjects([LFUserDataModel getLatitude],testData1ForLatitude, @"Data retrieved is wrong");
    XCTAssertNotEqual([LFUserDataModel getLatitude], testData2ForLatitude, @"Data retrieved is wrong");
    
}

-(void)testGetLongitude{
    
    NSString *testData1ForLongitude = @"77.0000";
    NSString *testData2ForLongitude = @"75.0000";
    
    [LFUserDataModel setLongitude:testData1ForLongitude];
    
    XCTAssertNotNil([LFUserDataModel getLongitude], @"This is a null response");
    XCTAssertEqualObjects([LFUserDataModel getLongitude],testData1ForLongitude, @"Data retrieved is wrong");
    XCTAssertNotEqual([LFUserDataModel getLongitude], testData2ForLongitude, @"Data retrieved is wrong");
    
}

-(void)testGetLastUpdatedTimestamp{
    
    NSDate *testData1ForLastUpdatedTimestamp = [NSDate date];
    NSDate *testData2ForLastUpdatedTimestamp =[NSDate dateWithTimeIntervalSince1970:0];
    
    [LFUserDataModel setLastUpdatedTimestamp:testData1ForLastUpdatedTimestamp];
    
    XCTAssertNotNil([LFUserDataModel getLastUpdatedTimestamp], @"This is a null response");
    XCTAssertEqualObjects([LFUserDataModel getLastUpdatedTimestamp],testData1ForLastUpdatedTimestamp, @"Data retrieved is wrong");
    XCTAssertNotEqual([LFUserDataModel getLastUpdatedTimestamp], testData2ForLastUpdatedTimestamp, @"Data retrieved is wrong");
    
}

@end
