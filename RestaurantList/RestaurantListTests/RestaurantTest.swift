//
//  RestaurantTest.swift
//  RestaurantList
//
//  Created by siwook on 2017. 9. 18..
//  Copyright © 2017년 siwook. All rights reserved.
//

import XCTest
@testable import RestaurantList

// MARK : - RestaurantTest: XCTestCase
class RestaurantTest: XCTestCase {
  // MARK : - Test Property
  var restaurantList: [Restaurant]!
  // MARK : - Set Up
  override func setUp() {
    super.setUp()
    testFetchRestaurantInfo()
  }
  // MARK : - Tear Down
  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    super.tearDown()
  }
  // MARK : - Test Restaurant Information Fetching 
  func testFetchRestaurantInfo() {
    restaurantList = Restaurant.fetchRestaurantList(fileName: "test_sample iOS",
                                     bundle: Bundle(for:RestaurantListTests.self))
    XCTAssertEqual(restaurantList.count, 19, "couldn't fetch 19 items from bundle")
  }
  func testFirstFetchedRestaurantHasExpectedValues() {
    verifyFetchedRestaurantListHasExpectedValues(index:0)
  }
  func verifyFetchedRestaurantListHasExpectedValues(index: Int) {
    let restaurant = restaurantList[index]
    XCTAssertEqual(restaurant.name, "Tanoshii Sushi")
    XCTAssertEqual(restaurant.status, "open")
    XCTAssertEqual(restaurant.bestMatch, 0.0)
  }
}
