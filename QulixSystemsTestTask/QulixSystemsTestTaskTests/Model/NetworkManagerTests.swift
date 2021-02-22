//
//  NetworkManagerTests.swift
//  QulixSystemsTestTaskTests
//
//  Created by 1 on 2/21/21.
//

import XCTest
@testable import QulixSystemsTestTask

class NetworkManagerTests: XCTestCase {
    
    var sut: NetworkManager!
    var mockURLSession: MockURLSession!

    override func setUpWithError() throws {
        mockURLSession = MockURLSession()
        sut = NetworkManager()
        sut.urlSession = mockURLSession
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testUsesCorrectHost() {
        sut.loadPhotos(with: "apple") { _ in }
        XCTAssertEqual(mockURLSession.urlComponents?.host, "www.flickr.com")
    }
    
    func testWhenCorrectDataArrives() {
        sut.loadPhotos(with: "apple") { result in
            switch result {
            case .success(let result):
                XCTAssertTrue(!(result.collection?.photos?.isEmpty ?? false))
            case .failure(let error): print(error)
            }
        }
        
    }
}

extension NetworkManagerTests {
    
    class MockURLSession: URLSessionProtocol {
        
        var url: URL?
        var response: URLResponse?
        var urlComponents: URLComponents? {
            guard let url = url else { return nil }
            return URLComponents(url: url, resolvingAgainstBaseURL: true)
        }
        
        func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
            self.url = url
            
            return URLSession.shared.dataTask(with: url)
        }
    }
}
