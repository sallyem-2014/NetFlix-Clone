//
//  SearchResultViewController.swift
//  Netflix Clone
//
//  Created by Sally on 15/08/2024.
//

import UIKit

class SearchResultViewController: UIViewController {
  
  private let searchRsultCollectionView: UICollectionView = {
    
    let layout = UICollectionViewFlowLayout()
    layout.itemSize = CGSize(width: 200, height: 100)
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    return collectionView
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    registerCollectionCells()
    self.view.backgroundColor = .systemBackground
  }
  
  private func registerCollectionCells() {
    //collectionView.register(TitleCollectionViewCell.self, forCellWithReuseIdentifier: TitleCollectionViewCell.identifer)
  }
}
