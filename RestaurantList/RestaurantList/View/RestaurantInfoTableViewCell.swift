//
//  RestaurantInfoTableViewCell.swift
//  RestaurantList
//
//  Created by siwook on 2017. 9. 18..
//  Copyright © 2017년 siwook. All rights reserved.
//

import UIKit
import Cosmos

// MARK : - RestaurantInfoTableViewCell: UITableViewCell
class RestaurantInfoTableViewCell: UITableViewCell {
  // MARK : - Property
  @IBOutlet weak var restaurantImageView: UIImageView!
  @IBOutlet weak var openStatusLabel: UILabel!
  @IBOutlet weak var deliveryCostLabel: UILabel!
  @IBOutlet weak var minimumCostLabel: UILabel!
  @IBOutlet weak var distanceLabel: UILabel!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var openStatusSeparatorView: UIView!

  @IBOutlet var ratingAverageView: CosmosView!

  var restaurantInfo: Restaurant! {
    didSet {
      updateUI()
    }
  }
  // MARK : - Update Cell UI
  private func updateUI() {
    setRestaurantImageView()
    setOpenStatusLabel()
    setRatingAverageView()
    nameLabel.text = restaurantInfo.name
    restaurantImageView.image = #imageLiteral(resourceName: "img_restaurant_one")
    openStatusLabel.text = restaurantInfo.status
    deliveryCostLabel.text = "\(restaurantInfo.deliveryCosts)"
    distanceLabel.text = "\(restaurantInfo.distance)"
    minimumCostLabel.text = "\(restaurantInfo.minCost)"
    ratingAverageView.rating = Double(restaurantInfo.ratingAverage)
  }
  private func setRatingAverageView() {
    ratingAverageView.rating = restaurantInfo.ratingAverage
  }
  private func setRestaurantImageView() {
  }
  private func setOpenStatusLabel() {
    func displayOpenStatusViewsBasedOn(isHiddenValue: Bool) {
      openStatusLabel.isHidden = isHiddenValue
      openStatusSeparatorView.isHidden = isHiddenValue
    }
    if restaurantInfo.status == Constants.Closed {
      openStatusLabel.textColor = UIColor.red
      displayOpenStatusViewsBasedOn(isHiddenValue: false)
    } else {
      openStatusLabel.textColor = UIColor.lightGray
      displayOpenStatusViewsBasedOn(isHiddenValue: true)
    }
  }

}
