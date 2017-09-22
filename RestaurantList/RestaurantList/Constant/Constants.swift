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
    static let ImageName = "imageName"
  }
  // MARK : - JSON Serializaion Error Description 
  struct SerializaionErrorDesc {
    // MARK : - Error Messages
    static let NameMissing = "Name is missing"
    static let StatusMissing = "Status is missing"
    static let SortingValuesMissing = "SortingValues is missing"
    static let BestMatchMissing = "BestMatch is missing"
    static let NewestMissing = "Newest is missing"
    static let RatingAverageMissing = "RatingAverage is missing"
    static let DistanceMissing = "Distance is missing"
    static let PopularityMissing = "Popularity is missing"
    static let AverageProductPriceMissing = "AverageProductPrice is missing"
    static let DeliveryCostsMissing = "DeliveryCosts is missing"
    static let MinCostMissing = "MinCost is missing"
    static let ImageNameMissing = "ImageName is missing"
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
    static let OrderAhead = "order ahead"
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
    static let HeartOutline    = "ic_heart_outline"
    static let HeartFilled     = "ic_heart_filled"
  }
  static let GermanLocale = "de_DE"
  static let TextFieldLeftPadding: CGFloat = 10
  static let CoreDataModelName = "FavoriteRestaurant"
  static let AssertDataInconsistency = "Favorite.findRestaurantAndUpdate -- database inconsistency"
  static let NameSearchPredicate = "name = %@"
  // MARK : - Toast Message
  struct ToastMsg {
    static let Duration = 0.5
    static let FavoriteMarked = "Restaurant favorited"
    static let FavoriteUnMarked = "Restaurant removed from favorites"
  }
}
