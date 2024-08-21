//
//  DataPersistanceManager.swift
//  Netflix Clone
//
//  Created by Sally on 20/08/2024.
//

import Foundation
import UIKit
import CoreData

class DataPersistanceManager {
  
  enum DownlodingError: Error {
    case FaildToSaveData
    case FaildToRetriveData
    case FailedToDeleteData
  }
  
  static let shared = DataPersistanceManager()
  
 
  
  func downloadTitleWith(with model: Title, completion: @escaping(Result<Void,Error>) -> Void) {
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
    let context = appDelegate.persistentContainer.viewContext
   
    let item = TitleEntityitems(context: context)
    item.original_name = model.original_name
    item.media_type = model.media_type
    item.poster_path = model.poster_path
    
    do {
      try context.save()
      completion(.success(()))
      
    } catch {
      print(DownlodingError.FaildToSaveData)
    }
  }
  
  func fetchingRequestFromDataBase(completion: @escaping(Result<[TitleEntityitems],Error>) -> Void) {
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
    let context = appDelegate.persistentContainer.viewContext
    var request = NSFetchRequest<TitleEntityitems>()
    request = TitleEntityitems.fetchRequest()
    
    do {
      let titles = try context.fetch(request)
      completion(.success(titles))
    } catch {
      completion(.failure(DownlodingError.FaildToRetriveData))
    }
  }
  
  func deleteDownloadedItem (item: TitleEntityitems, completion: @escaping(Result<Void,Error>) -> Void) {
    
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
    let context = appDelegate.persistentContainer.viewContext
    context.delete(item)
    do {
      try context.save()
      completion(.success(()))
    } catch{
      completion(.failure(DownlodingError.FailedToDeleteData))
    }
  }
}
