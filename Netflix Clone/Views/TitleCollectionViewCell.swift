//
//  TitleCollectionViewCell.swift
//  Netflix Clone
//
//  Created by Sally on 11/08/2024.
//

import UIKit
import Kingfisher

class TitleCollectionViewCell: UICollectionViewCell {
  
  static let identifer = "TitleCollectionViewCell"
  
  private var posterImage: UIImageView = {
    let image = UIImageView()
    image.contentMode = .scaleToFill
    return image
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    contentView.addSubview(posterImage)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    self.posterImage.frame = self.contentView.bounds
  }
  
  func setupPosterImage(with model: String?) {
    guard let model = model , let url = URL(string: model) else { return }
    posterImage.kf.setImage(with: url)
  }
}
