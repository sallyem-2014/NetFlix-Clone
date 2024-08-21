//
//  UpComingViewController.swift
//  Netflix Clone
//
//  Created by Sally on 07/08/2024.
//

import UIKit

class UpComingViewController: UIViewController {
  
  var titles: [Title] = [Title]()
 
  private let tableView: UITableView = {
    let tableview = UITableView()
    return tableview
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = .systemBackground
    setupNavBar()
    registerCell()
    setUpTableView()
    getupCommingMovies()
  }
  
  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
    self.tableView.frame = view.bounds
  }
  
  private func setupNavBar() {
    self.title = "UpComming"
    self.navigationController?.navigationBar.prefersLargeTitles = true
    self.navigationController?.navigationItem.largeTitleDisplayMode = .always
  }
  
  private func registerCell() {
    tableView.register(UpComingTableViewCell.self, forCellReuseIdentifier: UpComingTableViewCell.identifer)
  }
  private func setUpTableView() {
    self.view.addSubview(tableView)
    tableView.delegate = self
    tableView.dataSource = self
  }
  
  private func getupCommingMovies() {
    APICaller.shared.getUpCommingMovies { [weak self ] result in
      guard let self else { return }
      switch result {
      case .success(let movies):
        self.titles = movies
        DispatchQueue.main.async {
          self.tableView.reloadData()
        }
      case .failure(let error):
        print (error.localizedDescription)
      }
    }
  }
}

extension UpComingViewController: UITableViewDelegate , UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return titles.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: UpComingTableViewCell.identifer, for: indexPath) as? UpComingTableViewCell else { return UITableViewCell() }
     let title = self.titles[indexPath.row].title ?? "unkown"
     let posterURL = self.titles[indexPath.row].poster_path ?? ""
    cell.configure(title: title, posterURL: posterURL)
    return cell
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 140
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    self.tableView.deselectRow(at: indexPath, animated: true)
    let title = titles[indexPath.row]
    guard  let titleName = title.original_title ?? title.original_name else { return }
  }
}
