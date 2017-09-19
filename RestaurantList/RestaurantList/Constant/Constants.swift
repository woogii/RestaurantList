//
//  Constants.swift
//  RestaurantList
//
//  Created by siwook on 2017. 9. 18..
//  Copyright © 2017년 siwook. All rights reserved.
//

import Foundation
import UIKit

// MARK : - Constants

struct Constants {

  // MARK : - JSONResponseKeys
  struct JSONParsingKeys {

    static let Restaurants = "restaurants"
    static let Name = "name"
		static let Status = "status"
		static let SortingValues = "sortingValues"
    static let BestMatch = "bestMatch"
    static let Newest = "newest"
    static let RatingAverage = "ratingAverage"
    static let Distance = "distance"
    static let Popularity = "popularity"
    static let AverageProductPrice = "averageProductPrice"
    static let DeliveryCosts = "deliveryCosts"
    static let MinCost = "minCost"
  }
  // MARK : - JSON Serializaion Error Description 
  struct SerializaionErrorDesc {
    // MARK : - Error Messages
    static let NameMissing = "Name is missing"
    static let StatusMissing = "status"
    static let SortingValuesMissing = "sortingValues"
    static let BestMatchMissing = "bestMatch"
    static let NewestMissing = "newest"
    static let RatingAverageMissing = "ratingAverage"
    static let DistanceMissing = "distance"
    static let PopularityMissing = "popularity"
    static let AverageProductPriceMissing = "averageProductPrice"
    static let DeliveryCostsMissing = "deliveryCosts"
    static let MinCostMissing = "minCost"
    // MARK : - Invalid Messages 
    static let RatingAverageInvalid = "The value of rating average is not valid"
  }

  // MARK : - Resource Info
  struct SampleResource {
    static let FileName = "sample iOS"
    static let Extension = "json"
  }

  // MARK : - Storyboard IDs
  struct StoryboardIDs {
    static let RestaurantListVC = "RestaurantListVC"
  }
  // MARK : - Cell IDs 
  struct CellIDs {
    static let RestaurantInfoTableViewCell = "restaurantInfoTableViewCell"
  }
  // MARK : - Restaurant Information
  struct RestaurantInfo {
    static let Free = "FREE"
    static let KiloMeter = "Km"
    static let Min = "Min."
    static let Open = "open"
    static let OrderAhead = "orderAhead"
    static let Closed = "closed"
    static let DistanceFormat = "%.1f"
  }
  // MARK : - Colors
  struct Colors {
    static let LightBlue = UIColor(colorLiteralRed: 173/255.0,
                                   green: 216/255.0, blue: 230/255.0, alpha: 0.7)
  }
  // MARK : - Images {
  struct Images {
    static let RestaurantOne   = "img_restaurant_one"
    static let RestaurantTwo   = "img_restaurant_two"
    static let RestaurantThree = "img_restaurant_three"
    static let RestaurantFour  = "img_restaurant_four"
    static let RestaurantFive  = "img_restaurant_five"
    static let RestaurantSix   = "img_restaurant_six"
  }
  static let GermanLocale = "de_DE"
}
