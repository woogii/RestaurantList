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
  var filteredRestaurantList = [Restaurant]()
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var sortingTypeImageView: UIImageView!
  @IBOutlet weak var sortingTypeLabel: UILabel!
  @IBOutlet weak var menuContainerView: UIView!
  @IBOutlet weak var searchFieldContainerView: UIView!
  @IBOutlet weak var searchTextField: UITextField!
  @IBOutlet weak var sortingButton: UIButton!
  var enteredSearchKeyword: String = ""
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
  private func reconfigureSearchRelatedUI() {
    searchTextField.resignFirstResponder()
    enteredSearchKeyword = ""
    tableView.reloadData()
  }
  private func configureSearchTextField() {
    searchTextField.becomeFirstResponder()
    searchTextField.setLeftPaddingPoints(Constants.TextFieldLeftPadding)
  }
  private func displaySearchViewsBasedOn(isHidden: Bool) {
    searchFieldContainerView.isHidden = isHidden
    menuContainerView.isHidden = !isHidden
  }
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
    guard let cell = tableView.dequeueReusableCell(withIdentifier:
                                                   Constants.CellIDs.RestaurantInfoTableViewCell,
                                                   for: indexPath) as? RestaurantInfoTableViewCell else {
                                                    return RestaurantInfoTableViewCell()
    }
    configureCell(cell, at:indexPath)
    return cell
  }
  private func configureCell(_ cell: RestaurantInfoTableViewCell, at indexPath: IndexPath) {
    if !isFiltering() {
      let restaurant = restaurantList[indexPath.row]
      cell.restaurantInfo = restaurant
    } else {
      let filteredRestaurant = filteredRestaurantList[indexPath.row]
      cell.restaurantInfo = filteredRestaurant
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
  func filterRestaurantListForSearchText(_ searchKeyword: String) {
    filteredRestaurantList = restaurantList.filter { restaurant -> Bool in
      return restaurant.name.lowercased().contains(searchKeyword.lowercased())
    }
    tableView.reloadData()
  }
}
