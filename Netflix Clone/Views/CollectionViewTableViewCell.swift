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
  
  private func downloadItem(indexPath: IndexPath) {
    print("downloading ..... \(titles?[indexPath.row].id)")
    guard let itemTosave = titles?[indexPath.row] else { return }
    DataPersistanceManager.shared.downloadTitleWith(with: itemTosave) { result in
      switch result {
      case .success():
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "downloaded"), object: nil)
      case.failure(let error):
        print ("error = ", error)
      }
    }
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
  
  func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
    let config = UIContextMenuConfiguration( identifier: nil, previewProvider: nil) { _ in
      
      let downloadAction = UIAction(title: "download") { [weak self] _ in
        guard let self else { return }
        self.downloadItem(indexPath: indexPath)
      }
      return UIMenu(options: .displayInline, children: [downloadAction])
    }
    return config
  }
}
