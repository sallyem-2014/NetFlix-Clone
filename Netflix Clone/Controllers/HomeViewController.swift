//
//  HomeViewController.swift
//  Netflix Clone
//
//  Created by Sally on 07/08/2024.
//

import UIKit

enum Sections: Int {
  case tresndingMovies = 0
  case trendingTV = 1
  case upCommingMovies = 2
  case topRated = 3
}

class HomeViewController: UIViewController {
  
  enum sectionTitles: String {
    case tresndingMovies = "Tresnding Movies"
    case trendingTV = "Trending TV"
    case upCommingMovies = "UpComming Movies"
    case topRated = "Top rated"
  }
  
  let sectionlist = [sectionTitles.tresndingMovies, sectionTitles.trendingTV, sectionTitles.upCommingMovies, sectionTitles.topRated]
  
  private let mainTableView: UITableView = {
    let tableView = UITableView(frame: .zero, style: UITableView.Style.grouped)
    return tableView
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = .systemBackground
    setupTableView()
    registerTableViewCells()
    setupNavBar()
    getTrendingMovies()
  }
  
  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
    self.mainTableView.frame = view.bounds
  }
  
  private func registerTableViewCells() {
    self.mainTableView.register(CollectionViewTableViewCell.self, forCellReuseIdentifier: CollectionViewTableViewCell.identifier)
  }
  
  private func  getTrendingMovies() {
    APICaller.shared.getTrendingMovies { result in
      switch result {
      case.success(let movies):
        print (movies)
      case.failure(let error):
        print(error.localizedDescription)
      }
    }
  }
  
  private func setupNavBar() {
    var image = UIImage(systemName: "pencil.circle")
    image = image?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
    navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self , action: nil)
    navigationItem.rightBarButtonItems = [
      UIBarButtonItem(image: UIImage(systemName: "person.crop.circle"), style: .plain, target: self , action: nil),
      UIBarButtonItem(image: UIImage(systemName: "play.rectangle"), style: .plain, target: self , action: nil),
    ]
    navigationController?.navigationBar.tintColor = .black
  }
  
  private func setupTableView() {
    self.view.addSubview(mainTableView)
    mainTableView.delegate = self
    mainTableView.dataSource = self
    let headerView = HeroHeaderView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 420))
    mainTableView.tableHeaderView = headerView
  }
}

extension HomeViewController: UITableViewDelegate , UITableViewDataSource {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return sectionlist.count
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionViewTableViewCell.identifier, for: indexPath) as? CollectionViewTableViewCell else { return UITableViewCell() }
    
    switch indexPath.section {
    case Sections.tresndingMovies.rawValue:
      
      APICaller.shared.getTrendingMovies { result in
        switch result {
        case.success(let movies):
          cell.configure(with: movies)
        case.failure(let error):
          print(error.localizedDescription)
        }
      }
      
    case Sections.trendingTV.rawValue:
      
      APICaller.shared.getTrendingMovies { result in
        switch result {
        case.success(let movies):
          cell.configure(with: movies)
        case.failure(let error):
          print(error.localizedDescription)
        }
      }
      
    case Sections.topRated.rawValue:
      
      APICaller.shared.getTrendingMovies { result in
        switch result {
        case.success(let movies):
          cell.configure(with: movies)
        case.failure(let error):
          print(error.localizedDescription)
        }
      }
      
    case Sections.upCommingMovies.rawValue:
      
      APICaller.shared.getTrendingMovies { result in
        switch result {
        case.success(let movies):
          cell.configure(with: movies)
        case.failure(let error):
          print(error.localizedDescription)
        }
      }
      
    default:
     return  UITableViewCell()
    }
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 200
  }
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 40
  }
  
  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return sectionlist[section].rawValue
  }
  
  
  //  func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
  //    guard let header = view as? UITableViewHeaderFooterView else { return }
  //
  //    header.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
  //    header.frame = CGRect(x: header.bounds.origin.x + 20, y: 0, width: 100, height: header.bounds.height)
  //  }
  
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    let defaultOffset = view.safeAreaInsets.top
    let offset = scrollView.contentOffset.y + defaultOffset
    navigationController?.navigationBar.transform = .init(translationX: 0, y: min(0, -offset))
  }
}
