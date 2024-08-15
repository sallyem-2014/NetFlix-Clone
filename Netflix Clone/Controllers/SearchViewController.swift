//
//  SearchViewController.swift
//  Netflix Clone
//
//  Created by Sally on 07/08/2024.
//

import UIKit

class SearchViewController: UIViewController {
  
  var titles: [Title] = [Title]()
  
  private let discoverTable: UITableView = {
    let tableview = UITableView()
    return tableview
  }()
  
  private let searchController : UISearchController = {
    let searchController = UISearchController(searchResultsController: SearchResultViewController())
    searchController.searchBar.placeholder = "search for ........."
    searchController.searchBar.searchBarStyle = .minimal
    return searchController
  }()
  override func viewDidLoad() {
    super.viewDidLoad()
    setupNavBar()
    registerCell()
    setUpTableView()
    getDiscoverMovies()
  }
  
  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
    self.discoverTable.frame = view.bounds
  }
  
  private func setupNavBar() {
    self.title = "Search"
    self.navigationController?.navigationBar.prefersLargeTitles = true
    self.navigationController?.navigationItem.largeTitleDisplayMode = .always
    self.navigationItem.searchController = searchController
  }
  
  private func registerCell() {
    discoverTable.register(UpComingTableViewCell.self, forCellReuseIdentifier: UpComingTableViewCell.identifer)
  }
  
  private func setUpTableView() {
    self.view.addSubview(discoverTable)
    discoverTable.delegate = self
    discoverTable.dataSource = self
  }
  
  private func getDiscoverMovies() {
    APICaller.shared.getTrendingMovies{ [weak self ] result in
      guard let self else { return }
      switch result {
      case .success(let movies):
        self.titles = movies
        DispatchQueue.main.async {
          self.discoverTable.reloadData()
        }
      case .failure(let error):
        print (error.localizedDescription)
      }
    }
  }
}

extension SearchViewController: UITableViewDelegate , UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return titles.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: UpComingTableViewCell.identifer, for: indexPath) as? UpComingTableViewCell else { return UITableViewCell() }
    cell.configure(with: self.titles[indexPath.row])
    return cell
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 140
  }
  
}
