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
  var restaurantList: [Restaurant]?
  // MARK : - View Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    fetchRestaurantList()
  }
  private func fetchRestaurantList() {
    let bundle = Bundle(for: type(of: self))
    restaurantList = Restaurant.fetchRestaurantList(fileName: Constants.SampleResource.FileName,
                                                    bundle: bundle)
  }

}
