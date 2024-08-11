//
//  HeroHeaderView.swift
//  Netflix Clone
//
//  Created by Sally on 08/08/2024.
//

import UIKit

class HeroHeaderView: UIView {
  
  let imageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleToFill
    imageView.clipsToBounds = true
    imageView.image = UIImage(named: "thrones")
    return imageView
  }()
  
  let playButton: UIButton = {
    let button = UIButton()
    button.setTitle("play", for: .normal)
    button.layer.borderColor = UIColor.systemBackground.cgColor
    button.layer.borderWidth = 1
    button.layer.cornerRadius = 5
    // will not be appeare if it true
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()
  
  let downloadButton: UIButton = {
    let button = UIButton()
    button.setTitle("download", for: .normal)
    button.layer.borderColor = UIColor.systemBackground.cgColor
    button.layer.borderWidth = 1
    button.layer.cornerRadius = 5
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.addSubview(imageView)
    addGradiant()
    setupPlayButton()
    setupDownloadButton()
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    self.imageView.frame = self.bounds
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func addGradiant() {
    let gradiant = CAGradientLayer()
    gradiant.colors = [
      UIColor.clear.cgColor,
      UIColor.systemBackground.cgColor
    ]
    gradiant.frame = bounds
    layer.addSublayer(gradiant)
  }
  
  private func setupPlayButton() {
    self.addSubview(playButton)
    let constraint = [
      playButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 90),
      playButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50),
      playButton.widthAnchor.constraint(equalToConstant: 100)
    ]
    NSLayoutConstraint.activate(constraint)
  }
  
  private func setupDownloadButton() {
    self.addSubview(downloadButton)
    let constraint = [
      downloadButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -90),
      downloadButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50),
      downloadButton.widthAnchor.constraint(equalToConstant: 100)
    ]
    NSLayoutConstraint.activate(constraint)
  }
}
