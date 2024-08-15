//
//  UpComingTableViewCell.swift
//  Netflix Clone
//
//  Created by Sally on 13/08/2024.
//

import UIKit

class UpComingTableViewCell: UITableViewCell {
  
  static let identifer = "UpComingTableViewCell"

  private let title: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  private let posterImage: UIImageView = {
    let image = UIImageView()
    image.clipsToBounds = true
    image.translatesAutoresizingMaskIntoConstraints = false
    return image
  }()
  
  private let playButton: UIButton = {
    let button = UIButton()
    let image = UIImage(systemName: "play.circle.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30))
    button.setImage(image, for: .normal)
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    addViews()
    addViewsConstraint()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func addViews() {
    self.contentView.addSubview(playButton)
    self.contentView.addSubview(title)
    self.contentView.addSubview(posterImage)
  }
  
  private func addViewsConstraint() {

    let posterConstraints = [
      posterImage.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 0),
      posterImage.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 12),
      posterImage.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -15),
      posterImage.widthAnchor.constraint(equalToConstant: 100)
    ]
    
    let titleLabelConstraints = [
      self.title.leadingAnchor.constraint(equalTo: self.posterImage.trailingAnchor, constant: 20),
      self.title.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor)
    ]
    
    let playButtonConstraints = [
      self.playButton.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -12),
      self.playButton.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor)
    ]
    
    NSLayoutConstraint.activate(posterConstraints)
    NSLayoutConstraint.activate(titleLabelConstraints)
    NSLayoutConstraint.activate(playButtonConstraints)
  }
  
  func configure( with model: Title) {
    guard let psoterImage = model.poster_path, let url  = URL(string: "https://image.tmdb.org/t/p/w500" + psoterImage ) else { return }
    posterImage.kf.setImage(with: url)
    title.text = model.title ?? "unknown Title"
  }
}
