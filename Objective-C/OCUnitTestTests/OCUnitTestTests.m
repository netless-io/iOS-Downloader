//
//  OCUnitTestTests.m
//  OCUnitTestTests
//
//  Created by yleaf on 2021/7/24.
//

#import <XCTest/XCTest.h>

@interface Downloader : NSObject

- (void)download:(NSURL *)url completionHandler:(void (^)(BOOL success, NSURLResponse *response, NSError * error))completionHandler;

@end

@implementation Downloader


- (void)download:(NSURL *)url completionHandler:(void (^)(BOOL success, NSURLResponse *response, NSError * error))completionHandler {
    
}

@end

@interface OCUnitTestTests : XCTestCase
@property (nonnull, strong) Downloader *d;
@end


@implementation OCUnitTestTests

static NSTimeInterval kWaitTime = 30;

- (void)setUp {
    self.d = [[Downloader alloc] init];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testDownload {
    XCTestExpectation *expectation = [self expectationWithDescription:[NSString stringWithFormat:@"%s", __func__]];
    
    
    NSURL *url = [NSURL URLWithString:@"https://api.github.com/users"];
    [self.d download:url completionHandler:^(BOOL success, NSURLResponse *response, NSError *error) {
        if (success) {
            [expectation fulfill];
        } else {
            XCTFail("");
        }
    }];
    
    [self waitForExpectationsWithTimeout:kWaitTime handler:^(NSError * _Nullable error) {
            
    }];
}


- (void)testDownloadFail {
    XCTestExpectation *expectation = [self expectationWithDescription:[NSString stringWithFormat:@"%s", __func__]];
    
    
    NSURL *url = [NSURL URLWithString:@"https://api.github.com/user"];
    [self.d download:url completionHandler:^(BOOL success, NSURLResponse *response, NSError *error) {
        if (!success) {
            [expectation fulfill];
        } else {
            XCTFail("");
        }
    }];
    
    [self waitForExpectationsWithTimeout:kWaitTime handler:^(NSError * _Nullable error) {
            
    }];
}

- (void)testDownloadFailTwo {
    XCTestExpectation *expectation = [self expectationWithDescription:[NSString stringWithFormat:@"%s", __func__]];
    
    
    NSURL *url = [NSURL URLWithString:@"https://api.github.com/user1111"];
    [self.d download:url completionHandler:^(BOOL success, NSURLResponse *response, NSError *error) {
        if (!success) {
            [expectation fulfill];
        } else {
            XCTFail("");
        }
    }];
    
    [self waitForExpectationsWithTimeout:kWaitTime handler:^(NSError * _Nullable error) {
            
    }];
}

- (void)testRemovePreviousDownload {
    XCTestExpectation *expectation = [self expectationWithDescription:[NSString stringWithFormat:@"%s", __func__]];
    
    
    NSURL *url = [NSURL URLWithString:@"https://api.github.com/users"];
    
    int count = arc4random_uniform(10);
    
    for (int i = 0; i < count; i++) {
        [self.d download:url completionHandler:^(BOOL success, NSURLResponse *response, NSError *error) {
            XCTFail("");
        }];
    }
    
    [self.d download:url completionHandler:^(BOOL success, NSURLResponse *response, NSError *error) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [expectation fulfill];
        });
    }];
    
    [self waitForExpectationsWithTimeout:kWaitTime handler:^(NSError * _Nullable error) {
            
    }];
}

@end
