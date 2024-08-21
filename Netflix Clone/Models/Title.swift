//
//  Movie.swift
//  Netflix Clone
//
//  Created by Sally on 11/08/2024.
//

import Foundation

struct MovieResponse: Codable {
  let results: [Title]
}

struct Title: Codable {
  let id: Int
  let media_type: String?
  let original_language: String?
  let original_title: String?
  let original_name: String?
  let overview: String?
  let title: String?
  let poster_path: String?
  let release_date: String?
  let vote_average: Double?
}
