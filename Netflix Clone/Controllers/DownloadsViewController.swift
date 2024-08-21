//
//  DownloadsViewController.swift
//  Netflix Clone
//
//  Created by Sally on 07/08/2024.
//

import UIKit

class DownloadsViewController: UIViewController {
  
  var titles: [TitleEntityitems] = [TitleEntityitems]()
  
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
    retriveItems()
    addOvserver()
  }
  
  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
    self.tableView.frame = view.bounds
  }
  
  private func setupNavBar() {
    self.title = "Download"
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
  
  private func retriveItems() {
    DataPersistanceManager.shared.fetchingRequestFromDataBase { result in
      switch result {
      case .success(let items):
        self.titles = items
        DispatchQueue.main.async {
          self.tableView.reloadData()
        }
      case .failure(let error):
        print (error.localizedDescription)
        
      }
    }
  }
  
  private func addOvserver() {
    NotificationCenter.default.addObserver(forName: NSNotification.Name("downloaded"), object: nil, queue: nil) { _ in
      self.retriveItems()
    }
  }
}

extension DownloadsViewController: UITableViewDelegate , UITableViewDataSource {
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
  
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    switch editingStyle {
    case .delete:
      
      DataPersistanceManager.shared.deleteDownloadedItem(item: titles[indexPath.row]) { result in
        switch result {
        case .success(()):
          print("deleted ...")
        case.failure(let error):
          print(error.localizedDescription)
        }
      }
      self.titles.remove(at: indexPath.row)
      tableView.deleteRows(at: [indexPath], with:.fade )
      
    default:
      break
    }
  }
}
