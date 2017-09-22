//
//  ViewController.swift
//  RestaurantList
//
//  Created by siwook on 2017. 9. 18..
//  Copyright © 2017년 siwook. All rights reserved.
//

import UIKit
import CoreData
import Toaster

// MARK : - RestaurantListViewController: UIViewController
class RestaurantListViewController: UIViewController {

  // MARK : - Property
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var sortingTypeImageView: UIImageView!
  @IBOutlet weak var sortingTypeLabel: UILabel!
  @IBOutlet weak var menuContainerView: UIView!
  @IBOutlet weak var searchFieldContainerView: UIView!
  @IBOutlet weak var searchTextField: UITextField!
  @IBOutlet weak var sortingButton: UIButton!
  fileprivate var restaurantList = [Restaurant]()
  fileprivate var filteredRestaurantList = [Restaurant]()
  fileprivate var enteredSearchKeyword: String = ""
  var managedContext: NSManagedObjectContext!
  var favoriteRestaurantList = [FavoriteRestaurant]()
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
  // MARK : - Actions
  @IBAction func tappedSearchButton(_ sender: Any) {
    displaySearchViewsBasedOn(isHidden: false)
    configureSearchTextField()
  }
  @IBAction func tappedSearchCancelButton(_ sender: Any) {
    displaySearchViewsBasedOn(isHidden: true)
    reconfigureSearchRelatedUI()
  }
  @IBAction func tappedSortingButton(_ sender: Any) {
  }
  // MARK : - Reconfigure SearchUI
  private func reconfigureSearchRelatedUI() {
    searchTextField.resignFirstResponder()
    searchTextField.text = ""
    enteredSearchKeyword = ""
    tableView.reloadData()
  }
  // MARK : - Configure SearchTextField
  private func configureSearchTextField() {
    searchTextField.becomeFirstResponder()
    searchTextField.setLeftPaddingPoints(Constants.TextFieldLeftPadding)
  }
  // MARK : - Display SearchView and MenuView
  private func displaySearchViewsBasedOn(isHidden: Bool) {
    searchFieldContainerView.isHidden = isHidden
    menuContainerView.isHidden = !isHidden
  }
  // MARK : - Check Filtering Operation
  fileprivate func isFiltering() -> Bool {
    return !searchFieldContainerView.isHidden && !searchKeywordIsEmpty()
  }
  fileprivate func searchKeywordIsEmpty() -> Bool {
    // Returns true if the text is empty
    return enteredSearchKeyword.isEmpty
  }
}

// MARK : - RestaurantListViewController: UITableViewDelegate, UITableViewDataSource
extension RestaurantListViewController: UITableViewDelegate, UITableViewDataSource {
  // MARK : - UITableViewDataSource Methods
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if isFiltering() {
      return filteredRestaurantList.count
    }
    return restaurantList.count
  }
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIDs.RestaurantInfoTableViewCell,
                                                   for: indexPath) as? RestaurantInfoTableViewCell else {
      return RestaurantInfoTableViewCell()
    }
    configureCell(cell, at:indexPath)
    return cell
  }
  private func configureCell(_ cell: RestaurantInfoTableViewCell, at indexPath: IndexPath) {
    filterList(cell, at: indexPath)
  }
  // MARK : - Configure Cell Based on Filtered Data Source
  private func filterList(_ cell: RestaurantInfoTableViewCell, at indexPath: IndexPath) {
    if !isFiltering() {
      let restaurant = restaurantList[indexPath.row]
      cell.restaurantInfo = restaurant
      setFavoriteButtonAction(cell, at: indexPath)
    } else {
      let filteredRestaurant = filteredRestaurantList[indexPath.row]
      cell.restaurantInfo = filteredRestaurant
      setFilteredListFavoriteButtonAction(cell, at: indexPath, filteredRestaurant: filteredRestaurant)
    }
  }
  private func displayToastMessageBasedOn(isFavorite: Bool) {
    let message: String
    if isFavorite {
      message = Constants.ToastMsg.FavoriteMarked
    } else {
      message = Constants.ToastMsg.FavoriteUnMarked
    }
    let toast = Toast(text: message, delay: 0.0, duration: Constants.ToastMsg.Duration)
    toast.show()
  }
  // MARK : - Set Favorite Button Action in the List
  private func setFavoriteButtonAction(_ cell: RestaurantInfoTableViewCell,
                                       at indexPath: IndexPath) {
    cell.favoriteButtonTapAction = { [unowned self] in
      // Toggle isFavorite Property
      self.restaurantList[indexPath.row].isFavorite = !self.restaurantList[indexPath.row].isFavorite
      // Trigger Cell UI Update
      cell.restaurantInfo = self.restaurantList[indexPath.row]
      // Display Toast Message 
      self.displayToastMessageBasedOn(isFavorite: self.restaurantList[indexPath.row].isFavorite)
      // Update Database
      let updatedRestaurant = self.restaurantList[indexPath.row]
      self.updateFavoriteRestaurantDatabase(updatedRestaurant)
      self.printDatabaseStatistics()
    }
  }
  // MARK : - Set Favorite Button Action in the Filtered List
  private func setFilteredListFavoriteButtonAction(_ cell: RestaurantInfoTableViewCell,
                                                   at indexPath: IndexPath, filteredRestaurant: Restaurant) {
    cell.favoriteButtonTapAction = { [unowned self] in
      // Find an index to update the isFavorite property
      if let index = self.restaurantList.index(where: { (restaurant) -> Bool in
        // Suppose that the name of the restaurant is unique
        return restaurant.name == filteredRestaurant.name }
      ) {
        // Toggle Non-Filtered Restaurant isFavorite Property
        self.restaurantList[index].isFavorite = !self.filteredRestaurantList[indexPath.row].isFavorite
        // Toggle Filtered Restaurant isFavorite Property
        self.filteredRestaurantList[indexPath.row].isFavorite = !self.filteredRestaurantList[indexPath.row].isFavorite
        // Trigger Cell UI Update
        cell.restaurantInfo = self.filteredRestaurantList[indexPath.row]
        // Display Toast Message
        self.displayToastMessageBasedOn(isFavorite: self.restaurantList[indexPath.row].isFavorite)
        // Update Database
        let updatedRestaurant = self.restaurantList[indexPath.row]
        self.updateFavoriteRestaurantDatabase(updatedRestaurant)
        self.printDatabaseStatistics()
      }
    }
  }
  private func updateFavoriteRestaurantDatabase(_ restaurant: Restaurant) {
    FavoriteRestaurant.findRestaurantAndUpdate(matching: restaurant, in: managedContext)
  }
  private func printDatabaseStatistics() {
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>.init(entityName: Constants.CoreDataModelName)
    if let favorite = try? managedContext.fetch(fetchRequest) {
      print("favorite count : \(favorite.count)")
    }
  }
}

// MARK : - RestaurantListViewController: UITextFieldDelegate
extension RestaurantListViewController : UITextFieldDelegate {
  // MARK : - UITextFieldDelegate Methods
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange,
                 replacementString string: String) -> Bool {
    if string.isEmpty {
      enteredSearchKeyword = String(enteredSearchKeyword.characters.dropLast())
    } else {
      enteredSearchKeyword = (textField.text ?? "") + string
    }
    filterRestaurantListForSearchText(enteredSearchKeyword)
    return true
  }
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    if textField == searchTextField {
      searchTextField.resignFirstResponder()
      return false
    }
    return true
  }
  // MARK : - Filter List with Keyword
  func filterRestaurantListForSearchText(_ searchKeyword: String) {
    filteredRestaurantList = restaurantList.filter { restaurant -> Bool in
      return restaurant.name.lowercased().contains(searchKeyword.lowercased())
    }
    tableView.reloadData()
  }
}
