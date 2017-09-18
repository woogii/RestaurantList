//
//  Constants.swift
//  RestaurantList
//
//  Created by siwook on 2017. 9. 18..
//  Copyright © 2017년 siwook. All rights reserved.
//

import Foundation

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

}
