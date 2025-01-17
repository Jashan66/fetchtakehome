//
//  RecipeListItemView.swift
//  fetchtakehome
//
//  Created by Jashan Rahal on 1/15/25.
//
import SwiftUI

struct RecipeListItemView: View {
    let recipe: Recipe
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {

            Text(recipe.name ?? "")
                .font(.headline)
                .bold()
                .padding(.bottom, 2)
                .foregroundColor(.primary)
            

            Text("Cuisine: \(recipe.cuisine)")
                .font(.subheadline)
                .foregroundColor(.secondary)
            

            AsyncImage(url: URL(string: recipe.photo_url_small)) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(10)
                        .shadow(radius: 4)
                case .failure:
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .foregroundColor(.gray)
                @unknown default:
                    EmptyView()
                }
            }
            .frame(height: 200)
            

            if let sourceURL = recipe.source_url, let url = URL(string: sourceURL) {
                Link(destination: url) {
                    Text("Source")
                        .font(.footnote)
                        .foregroundColor(.blue)
                        .padding(.vertical, 4)
                        .padding(.horizontal, 8)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(8)
                }
            } else {
                Text("Unknown Source")
                    .font(.footnote)
                    .foregroundColor(.gray)
            }
            

            if let youtubeURL = recipe.youtube_url, let url = URL(string: youtubeURL) {
                Link(destination: url) {
                    Text("Watch on YouTube")
                        .font(.footnote)
                        .foregroundColor(.red)
                        .padding(.vertical, 4)
                        .padding(.horizontal, 8)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(8)
                    
                }
            } else {
                Text("No Video Available")
                    .font(.footnote)
                    .foregroundColor(.gray)
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
    }
}
