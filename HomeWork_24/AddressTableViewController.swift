//
//  AddressTableViewController.swift
//  HomeWork_24
//
//  Created by MAC OS  on 01.10.2019.
//  Copyright © 2019 MAC OS . All rights reserved.
//

import UIKit

class AddressTableViewController: UITableViewController {
  
  var address = [FavoriteAddress]()
  
  private var addresses: [FavoriteAddress] = [
    FavoriteAddress(name: "Автохаус Мегаполис", address: "Минск, Притыцкого 60В"),
    FavoriteAddress(name: "Драйв Моторс", address: "Минск, Догниновский тракт 186"),
    FavoriteAddress(name: "Тарантас", address: "Минск, Радиальная 18"),
    FavoriteAddress(name: "Bidcar", address: "Минск, Тимирязева 97"),
    FavoriteAddress(name: "Автолот", address: "Минск, Инженерная 38А"),
    FavoriteAddress(name: "Голден Моторс", address: "Минск, Тимирязева 46б"),
    FavoriteAddress(name: "4КОЛЕСА", address: "Минск, Радужная 7а"),
    FavoriteAddress(name: "Автохаус ШАНС", address: "Минск, Серова 1"),
    FavoriteAddress(name: "7 Регион", address: "Минск, пр.Партизанский 160А"),
    FavoriteAddress(name: "Audi", address: "Минск, пр-т Независимости 198"),
    FavoriteAddress(name: "Хенде АвтоГрад", address: "Минск, Тимирязева 114"),
    FavoriteAddress(name: "Motoshop", address: "Минск, Шаранговича 7"),
    FavoriteAddress(name: "MV-auto", address: "Минск, Карбышева 25а"),
    FavoriteAddress(name: "Колесо-Лидер", address: "Минск, пр-т Независимости 165"),
    FavoriteAddress(name: "Автосалон АВТОДОМ", address: "Минск, Тимирязева 74"),
    FavoriteAddress(name: "Автоидея", address: "Минск, Юбилейная 4"),
    FavoriteAddress(name: "Тойота Центр Минск", address: "Минск, Орловская 88"),
    FavoriteAddress(name: "АвтоУдача", address: "Минск, пр-т Независимости 163"),
    FavoriteAddress(name: "Автоцентр Восток", address: "Минск, пр-т Независимости 163"),
    FavoriteAddress(name: "Автопромсервис", address: "Минск, Свислочская 9")
  ]
  
  //Массив отфильтрованных адресов
  
  private var filteredAddress = [FavoriteAddress]()
  
  private let searchController = UISearchController(searchResultsController: nil)
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureSearch()
    
  }
  
  //Setup the Search Controller
  
  private func configureSearch() {
    searchController.searchResultsUpdater = self
    searchController.dimsBackgroundDuringPresentation = false
    searchController.searchBar.placeholder = "Search"
    definesPresentationContext = true
    tableView.tableHeaderView = searchController.searchBar
  }
  
  //Table view data source
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if isFiltering() {
      return filteredAddress.count
    }
    return addresses.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! AddressTableViewCell
    
    var address: FavoriteAddress
    
    if isFiltering() {
      address = filteredAddress[indexPath.row]
    } else {
      address = addresses[indexPath.row]
    }
    
    cell.nameTextLabel.text = address.name
    cell.addressTextLabel.text = address.address
    
    return cell
  }
  
  //Navigation
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "mapSegue" {
      if let indexPath = tableView.indexPathForSelectedRow {
        let dvc = segue.destination as! MapViewController
        dvc.address = self.addresses[indexPath.row]
      }
    }
  }
  
  func searchBarIsEmpty() -> Bool {
    return searchController.searchBar.text?.isEmpty ?? true
  }
  
  func isFiltering() -> Bool {
    return searchController.isActive && !searchBarIsEmpty()
  }
}

extension AddressTableViewController: UISearchResultsUpdating {
  
  func updateSearchResults(for searchController: UISearchController) {
    filterContentForSearchText(searchController.searchBar.text!)
  }
  
  //Параметры поиска
  
  private func filterContentForSearchText(_ searchText: String) {
    filteredAddress = addresses.filter({ (adress: FavoriteAddress) -> Bool in
      return adress.name.lowercased().contains(searchText.lowercased())
    })
    tableView.reloadData()
  }
}
