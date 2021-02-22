//
//  MainViewControllerTests.swift
//  QulixSystemsTestTaskTests
//
//  Created by 1 on 2/21/21.
//

import XCTest
@testable import QulixSystemsTestTask

class MainViewControllerTests: XCTestCase {
    
    var sut: MainViewController!

    override func setUpWithError() throws {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "MainViewController")
        sut = vc as? MainViewController
        
        sut.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testWhenViewIsLoadedTableViewNotNil() {
        XCTAssertNotNil(sut.tableView, "tableView is nil")
    }
    
    func testWhenViewIsLoadedTableViewDelegateIsSet() {
        XCTAssertTrue(sut.tableView.delegate is MainViewController)
    }
    
    func testWhenViewIsLoadedTableViewDataSourceIsSet() {
        XCTAssertTrue(sut.tableView.dataSource is MainViewController)
    }
    
    func testNumberOfRowsInPhotosProperty() {
        let tableView = UITableView()
        tableView.dataSource = sut
        
        sut.photos.append(Photo())
        
        XCTAssertEqual(tableView.numberOfRows(inSection: 0), sut.photos.count)
        
        sut.photos.append(Photo())
        tableView.reloadData()
        
        XCTAssertEqual(tableView.numberOfRows(inSection: 0), sut.photos.count)
    }
}
