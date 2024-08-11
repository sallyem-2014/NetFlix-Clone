//
//  CollectionViewTableViewCell.swift
//  Netflix Clone
//
//  Created by Sally on 07/08/2024.
//

import UIKit

class CollectionViewTableViewCell: UITableViewCell {
  
  static let identifier = "CollectionViewTableViewCell"
  private var titles: [Title]?
  
  private let collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    // we want to ewch cell to get the entire height
    layout.itemSize = CGSize(width: 140, height: 200)
    layout.scrollDirection = .horizontal
    let collectiovView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    return collectiovView
  }()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    self.contentView.backgroundColor = .yellow
    setUpCollectionView()
    registerCell()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func configure(with titles: [Title]) {
    self.titles = titles
    DispatchQueue.main.async {
      self.collectionView.reloadData()
    }
  }
  
  private func registerCell() {
    collectionView.register(TitleCollectionViewCell.self, forCellWithReuseIdentifier: TitleCollectionViewCell.identifer )
  }
  
  private func setUpCollectionView() {
    self.contentView.addSubview(collectionView)
    collectionView.delegate = self
    collectionView.dataSource = self
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    collectionView.frame = contentView.bounds
  }
}

extension CollectionViewTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return titles?.count ?? 0
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TitleCollectionViewCell.identifer, for: indexPath) as? TitleCollectionViewCell else { return UICollectionViewCell() }
    cell.setupPosterImage(with: titles?[indexPath.row].poster_path)
    cell.backgroundColor = .systemPink
    return cell
  }
}
