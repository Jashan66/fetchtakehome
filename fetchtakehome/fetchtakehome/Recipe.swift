//
//  Recipe.swift
//  fetchtakehome
//
//  Created by Jashan Rahal on 1/15/25.
//


struct RecipeResponse: Codable {
    let recipes: [Recipe]
}


struct Recipe: Identifiable, Codable {
    var id: String { uuid }
    let uuid: String
    let name: String?
    let cuisine: String
    let youtube_url: String?
    let source_url: String?
    let photo_url_small: String
    let photo_url_large: String
}
