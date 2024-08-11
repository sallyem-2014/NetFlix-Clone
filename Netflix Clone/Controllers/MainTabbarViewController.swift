//
//  ViewController.swift
//  Netflix Clone
//
//  Created by Sally on 07/08/2024.
//

import UIKit

class MainTabbarViewController: UITabBarController {

  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.view.backgroundColor = .systemBackground
   
//  
//    let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//    let vc : HomeViewController = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
//    let vc1 = UINavigationController(rootViewController: vc)

    
    
    let vc1 = UINavigationController(rootViewController: HomeViewController())
    let vc2 = UINavigationController(rootViewController: UpComingViewController())
    let vc3 = UINavigationController(rootViewController: SearchViewController())
    let vc4 = UINavigationController(rootViewController: DownloadsViewController())
    
    vc1.tabBarItem.image = UIImage(systemName: "house")
    vc2.tabBarItem.image = UIImage(systemName: "play.circle")
    vc3.tabBarItem.image = UIImage(systemName: "magnifyingglass")
    vc4.tabBarItem.image = UIImage(systemName: "arrow.down.to.line.alt")
    
    setViewControllers([vc1,vc2, vc3,vc4], animated: true)
    
  }


}

