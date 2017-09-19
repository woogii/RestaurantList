//
//  RestaurantInfoTableViewCell.swift
//  RestaurantList
//
//  Created by siwook on 2017. 9. 18..
//  Copyright © 2017년 siwook. All rights reserved.
//

import UIKit

// MARK : - RestaurantInfoTableViewCell: UITableViewCell
class RestaurantInfoTableViewCell: UITableViewCell {
  // MARK : - Property
  @IBOutlet weak var restaurantImageView: UIImageView!
  @IBOutlet weak var openStatusLabel: UILabel!
  @IBOutlet weak var deliveryCostLabel: UILabel!
  @IBOutlet weak var minimumCostLabel: UILabel!
  @IBOutlet weak var distanceLabel: UILabel!
  var restaurantInfo: Restaurant! {
    didSet {
      updateUI()
    }
  }
  // MARK : - Update Cell UI
  func updateUI() {
  }
}
