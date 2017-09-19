//
//  ViewController.swift
//  RestaurantList
//
//  Created by siwook on 2017. 9. 18..
//  Copyright © 2017년 siwook. All rights reserved.
//

import UIKit

// MARK : - RestaurantListViewController: UIViewController
class RestaurantListViewController: UIViewController {

  // MARK : - Property
  var restaurantList = [Restaurant]()
  // MARK : - View Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    fetchRestaurantList()
  }
  // MARK : - Fetch the list of restaurant  
  private func fetchRestaurantList() {
    let bundle = Bundle(for: type(of: self))
    guard let fetchedList = Restaurant.fetchRestaurantList(fileName: Constants.SampleResource.FileName,
                                                           bundle: bundle) else {
      return
    }
    restaurantList = fetchedList
  }

}

// MARK : - RestaurantListViewController: UITableViewDelegate, UITableViewDataSource
extension RestaurantListViewController: UITableViewDelegate, UITableViewDataSource {
  // MARK : - UITableViewDataSource Methods
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return restaurantList.count
  }
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier:
                                                   Constants.CellIDs.RestaurantInfoTableViewCell,
                                                   for: indexPath) as? RestaurantInfoTableViewCell else {
                                                    return RestaurantInfoTableViewCell()
    }
    configureCell(cell, at:indexPath)
    return cell
  }
  private func configureCell(_ cell: RestaurantInfoTableViewCell, at indexPath: IndexPath) {
  }
}
