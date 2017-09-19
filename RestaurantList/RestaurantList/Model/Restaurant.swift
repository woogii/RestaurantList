//
//  Restaurant.swift
//  RestaurantList
//
//  Created by siwook on 2017. 9. 18..
//  Copyright © 2017년 siwook. All rights reserved.
//

import Foundation

// MARK : - Restaurant

struct Restaurant {

  // MARK : - Property
  var name: String
  var status: String
  var bestMatch: Float
  var newest: Float
  var ratingAverage: Double
  var distance: Int
  var popularity: Float
  var averageProductPrice: Float
  var deliveryCosts: Int
  var minCost: Int

  // MARK : - SerializationError
  enum SerializaionError: Error {
    case missing(String)
    case invalid(String, Any)
  }
  // MARK : - Initialization
  // swiftlint:disable:next cyclomatic_complexity
  init(dictionary: [String:Any]) throws {
    guard let name = dictionary[Constants.JSONParsingKeys.Name] as? String else {
      throw SerializaionError.missing(Constants.SerializaionErrorDesc.NameMissing)
    }

    guard let status = dictionary[Constants.JSONParsingKeys.Status] as? String else {
      throw SerializaionError.missing(Constants.SerializaionErrorDesc.StatusMissing)
    }

    guard let sortingValues = dictionary[Constants.JSONParsingKeys.SortingValues] as? [String:Any] else {
      throw SerializaionError.missing(Constants.SerializaionErrorDesc.SortingValuesMissing)
    }

    guard let bestMatch = sortingValues[Constants.JSONParsingKeys.BestMatch] as? Float else {
      throw SerializaionError.missing(Constants.SerializaionErrorDesc.BestMatchMissing)
    }

    guard let newest = sortingValues[Constants.JSONParsingKeys.Newest] as? Float else {
      throw SerializaionError.missing(Constants.SerializaionErrorDesc.NewestMissing)
    }

    guard let ratingAverage = sortingValues[Constants.JSONParsingKeys.RatingAverage] as? Double else {
      throw SerializaionError.missing(Constants.SerializaionErrorDesc.RatingAverageMissing)
    }

    guard case (0.0...5.0) = ratingAverage else {
      throw SerializaionError.invalid(Constants.SerializaionErrorDesc.RatingAverageInvalid, ratingAverage)
    }

    guard let distance = sortingValues[Constants.JSONParsingKeys.Distance] as? Int else {
      throw SerializaionError.missing(Constants.SerializaionErrorDesc.DistanceMissing)
    }

    guard let popularity = sortingValues[Constants.JSONParsingKeys.Popularity] as? Float else {
      throw SerializaionError.missing(Constants.SerializaionErrorDesc.PopularityMissing)
    }

    guard let averageProductPrice = sortingValues[Constants.JSONParsingKeys.AverageProductPrice] as? Float else {
      throw SerializaionError.missing(Constants.SerializaionErrorDesc.AverageProductPriceMissing)
    }

    guard let deliveryCosts = sortingValues[Constants.JSONParsingKeys.DeliveryCosts] as? Int else {
      throw SerializaionError.missing(Constants.SerializaionErrorDesc.DeliveryCostsMissing)
    }

    guard let minCost = sortingValues[Constants.JSONParsingKeys.MinCost] as?  Int else {
      throw SerializaionError.missing(Constants.SerializaionErrorDesc.MinCostMissing)
    }

    self.name = name
    self.status = status
    self.bestMatch = bestMatch
    self.newest = newest
    self.ratingAverage = ratingAverage
    self.distance = distance
    self.popularity = popularity
    self.averageProductPrice = averageProductPrice
    self.deliveryCosts = deliveryCosts
    self.minCost = minCost

  }
  // MARK : - Fetch Restaurant list from JSON file
  static func fetchRestaurantList(fileName: String, bundle: Bundle) -> [Restaurant]? {

    guard let path = bundle.path(forResource: fileName,
                                 ofType: Constants.SampleResource.Extension) else {
      return nil
    }

    do {
      let data = try Data(contentsOf: URL(fileURLWithPath: path))
      guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] else {
        return nil
      }
      guard let restaurantDictArray = json[Constants.JSONParsingKeys.Restaurants] as? [[String:Any]] else {
        return nil
      }
      var restauRant = [Restaurant]()
      for case let restaurantDict in restaurantDictArray {
        let restaurantInfo = try Restaurant(dictionary: restaurantDict)
        restauRant.append(restaurantInfo)
      }
      return restauRant
    } catch let error as NSError {
      print("\(error.userInfo), \(error.localizedDescription)")
      return nil
    }

  }

}
