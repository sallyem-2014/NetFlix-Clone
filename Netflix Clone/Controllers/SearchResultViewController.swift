//
//  SearchResultViewController.swift
//  Netflix Clone
//
//  Created by Sally on 15/08/2024.
//

import UIKit

class SearchResultViewController: UIViewController {
  
  var titles: [Title]?
  
  let searchRsultCollectionView: UICollectionView = {
    
    let layout = UICollectionViewFlowLayout()
    layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 3 - 10 , height: 200)
    layout.minimumInteritemSpacing = 0
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    return collectionView
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = .systemBackground
    self.view.addSubview(searchRsultCollectionView)
    registerCollectionCells()
    searchRsultCollectionView.delegate = self
    searchRsultCollectionView.dataSource = self
  }
  
  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
    self.searchRsultCollectionView.frame = view.bounds
  }
  
  private func registerCollectionCells() {
    self.searchRsultCollectionView.register(TitleCollectionViewCell.self, forCellWithReuseIdentifier: TitleCollectionViewCell.identifer)
  }
}

extension SearchResultViewController: UICollectionViewDelegate, UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return titles?.count ?? 0
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TitleCollectionViewCell.identifer, for: indexPath) as? TitleCollectionViewCell else { return UICollectionViewCell() }
    cell.setupPosterImage(with: titles?[indexPath.row].poster_path)
    return cell
  }
}
