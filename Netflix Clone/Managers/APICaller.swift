//
//  APICaller.swift
//  Netflix Clone
//
//  Created by Sally on 10/08/2024.
//

import Foundation

struct Constant {
  static let apiKey = "7748640a3e9ee1384f08e21bf8d81d3d"
  static let accessToken = "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI3NzQ4NjQwYTNlOWVlMTM4NGYwOGUyMWJmOGQ4MWQzZCIsIm5iZiI6MTcyMzMxMzcxMi4zODE3MTMsInN1YiI6IjY2YjdhOWFlOTdhYTMxMDA4MjExY2MwMiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.yyE9TqFfNZk8qpfkP7_GOZd5jqZ4W7mfpvRZfGQhZx0"
  static let baseURL = "https://api.themoviedb.org"
}

enum APIError {
  case APIFailedError
}

class APICaller {
  
  static let shared = APICaller()
  
  func getTrendingMovies(completion: @escaping (Result<[Title], Error>) -> Void) {
    guard let url = URL(string: Constant.baseURL + "/3/trending/movie/day") else { return }
    
    var request = URLRequest(url: url)
    request.addValue(Constant.accessToken, forHTTPHeaderField: "Authorization")
    
    let task = URLSession.shared.dataTask(with: request) { data, _ , error in
      guard let data = data, error == nil  else { return }
      
      do {
        //  let result = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
        let result = try JSONDecoder().decode(MovieResponse.self, from: data)
        completion(.success(result.results))
      } catch {
        completion(.failure(error))
      }
    }
    task.resume()
  }
  
  func getTrendingMTV(completion: @escaping (Result<[Title], Error>) -> Void) {
    guard let url = URL(string: Constant.baseURL + "/3/trending/tv/day") else { return }
    
    var request = URLRequest(url: url)
    request.addValue(Constant.accessToken, forHTTPHeaderField: "Authorization")
    
    let task = URLSession.shared.dataTask(with: request) { data, _ , error in
      guard let data = data, error == nil  else { return }
      
      do {
        //  let result = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
        let result = try JSONDecoder().decode(MovieResponse.self, from: data)
        completion(.success(result.results))
      } catch {
        completion(.failure(error))
      }
    }
    task.resume()
  }
}
