//
//  UnitTestTests.swift
//  UnitTestTests
//
//  Created by yleaf on 2021/5/30.
//

import XCTest

class DownloadHandler {
    
    public func download(_ request: URLRequest, completionHandler: @escaping (Result<URLResponse, Error>) -> Void) {
        
    }
}

class UnitTestTests: XCTestCase {

    let downloader = DownloadHandler()
    let waitTime = 30.0

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testDownload() {
        let expectation = self.expectation(description: "\(#function)")
        
        let request = URLRequest(url: URL(string: "https://api.github.com/users")!)
        
        downloader.download(request) { result in
            switch result {
            case .success(_):
                print("success")
                expectation.fulfill()
            case .failure(_):
                print("failure")
                XCTFail()
            }
        }
        
        self.waitForExpectations(timeout: waitTime) { error in
            if let e = error {
                print("\(e)")
            }
        }
    }
    
    func testDownloadFail() {
        let expectation = self.expectation(description: "\(#function)")
        
        let request = URLRequest(url: URL(string: "https://api.github.com/user")!)

        downloader.download(request) { result in
            switch result {
            case .success(_):
                XCTFail()
                print("success")
            case .failure(_):
                print("failure")
                expectation.fulfill()
            }
        }
        
        self.waitForExpectations(timeout: waitTime) { error in
            if let e = error {
                print("\(e)")
            }
        }
    }
    
    func testDownloadFailTwo() throws {
        let expectation = self.expectation(description: "\(#function)")
        
        let request = URLRequest(url: URL(string: "https://api.github.com/users11111")!)
        
        downloader.download(request) { result in
            switch result {
            case .success(_):
                XCTFail()
                print("success")
            case .failure(_):
                print("failure")
                expectation.fulfill()
            }
        }
        
        
        self.waitForExpectations(timeout: waitTime) { error in
            if let e = error {
                print("\(e)")
            }
        }

    }

    func testRemovePreviousDownload() throws {
    
        let expectation = self.expectation(description: "\(#function)")
        
        let request = URLRequest(url: URL(string: "https://api.github.com/users")!)
        
        let n = Int.random(in: 1...10)
        
        for _ in 1...n {
            downloader.download(request) { _ in
                XCTFail()
            }
        }
        
        
        downloader.download(request) { _ in
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(5)) {
                expectation.fulfill()
            }
        }
        
        
        self.waitForExpectations(timeout: waitTime) { error in
            if let e = error {
                print("\(e)")
            }
        }
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
