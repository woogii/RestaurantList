# RestaurantList

This is a simple demo application that shows a list of restaurants. A list shows various information about a restaurant such as opening status, delivery cost, location, and so on. The list is sorted in order of favorite first, and then opening status, by default. On the top of the screen, there are two menu icons, search and sorting icons. If the search button is tapped, an input form is displayed, which enables users to type the keyword to find restaurants. When the sorting icon is tapped, a list of sorting options is shown and users can add another sorting option to sort the restaurant list.

## Tasks
* Parse a JSON file that includes restaurant information and display the information on the list
* Sort the restaurant list by multiple criteria
* Provide a search interface to find restaurants
* Provide valid test cases 

## How to solve 

* Use `JSONSerialization` class to get a foundation object from JSON data and parse the object.
* Use the built-in `sorted` function of Array type to sort the restaurant list.
* Use `UITextField` to provide an input form and declare a variable that saves filtered restaurant list. The variable works as data source when `UITableView` shows the filtered list.
* Populate restaruant information on a custom `UITableViewCell` via `UITableView` DataSource Methods. 
* Use `CoreData` to save and fetch the favorite restaurant list.


## Design decision 

This application follows the MVC (Model-View-Controller) pattern. 

* Model Layer - Restaurant struct is defined with Initializer, member variables and static functions. One static function create a restaurant list by deserializing and parsing the JSON Object in `Bundle`. And the other static function is responsible for sorting the list with a sorting option.
FavoriteRestaurant is `NSManagedObject` subclass which is used to save the favorite restaurant locally on the phone. It includes insert, delete functions that updates the favorite list.
  
* Controller Layer - RestaurantListViewController holds the restaurant array and uses it as a datasource of `UITableView` to populate restaurant information. It also provides searching, sorting UI and updates the list based on the data source.
* View Layer - RestaurantInfoTableViewCell is responsible for displaying restaurant information. It has a property observer of Restaurant type which updates the cell's UI when the restaurant list changes in Controller layer.

## Further Improvement 

* It is highly likely that the amount of code in Controller layer in the project will rapidly grow as more features are added. This is a phenomenon so called 'fat viewcontroller', which is the reason why developers start adopting alternative patterns such as MVVM, MVP, Viper. One of those patterns can be used on the project to reduce the Controller layer's tasks. 
* The code of the sort function in Model layer is verbose and contains duplicate code. This can be fixed by extending Sequence protocol and I get some hints after reading this [blog](http://master-method.com/index.php/2016/11/23/sort-a-sequence-i-e-arrays-of-objects-by-multiple-properties-in-swift-3/). I will dig deep into this topic to resolve the issue.
* Unit, UI Tests
# Open Source Licence

*  [Toaster](https://github.com/devxoul/Toaster)
*  [Cosmos](https://github.com/evgenyneu/Cosmos)
*  [SwiftLint](https://github.com/realm/SwiftLint)

## Image Licence 

* [Icons8](https://icons8.com/) 

# How to build 

1) Clone the repository 

```
$ git clone https://github.com/woogii/RestaurantList.git
$ cd RestaurantList
```
2) Install SwiftLint

```
$ brew install swiftlint
```
3) Set up the third party library 

```
$ pod install
```

4) Open the workspace in XCode 

```
$ open RestaurantList.xcworkspace/
```

5) Compile and run the app in your simulator or iPhone 

# Compatibility 
The code of this project works in Swift3.0, Xcode 8.3.1 and iOS9 
