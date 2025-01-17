//
//  ContentView.swift
//  fetchtakehome
//
//  Created by Jashan Rahal on 1/14/25.
//

import SwiftUI



struct ContentView: View {
   @State private var allRecipes : [Recipe] = []
    @State private var errorMessage: String = ""
    @State private var isError: Bool = false
    var body: some View {
        VStack{
            Text("FlavorBook")
                            .bold()
                            .font(.title)
                            .padding()
                            .foregroundColor(.primary)
        Divider()
            
            
            if isError {
                ErrorMessageView(errorMessage: errorMessage)
            } else{
                List {
                    ForEach(allRecipes) { recipe in
                        RecipeListItemView(recipe: recipe)
                    }
                }
                .listStyle(PlainListStyle())
                .padding()
                .refreshable {
                    await refreshRecipes()
                }
            }
            
        }
        .padding()
        .onAppear(){
            getRecipeData()
        }
    }
    
    func refreshRecipes() async {
            await withCheckedContinuation { continuation in
                getRecipeData()
                continuation.resume()
            }
        }
    
    
    func getRecipeData(){

        guard let url = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json") else{
            print("URL Invalid")
            isError = true
            errorMessage = "Invalid URL"
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) {data, response, error in
            
            if let error = error {
                print("Error \(error)")
                isError = true
                errorMessage = "Error Getting Data"
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                print("Http Response Error")
                isError = true
                errorMessage = "Http Error"
                return
            }
            
            guard let data = data else{
                print("No data available")
                isError = true
                errorMessage = "No Data Available"
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let recipeResponse = try decoder.decode(RecipeResponse.self, from: data)
                allRecipes = recipeResponse.recipes
                
                if allRecipes.contains(where: {$0.name?.isEmpty ?? true}){
                    isError = true
                    errorMessage = "Recipes Are Malformed"
                }
                    
                if allRecipes.count == 0{
                    isError = true
                    errorMessage = "No Recipes Available"
                }
                
               } catch {
                   print("Decoding error: \(error)")
                   isError = true
                   errorMessage = "Error Decoding Data"
                   
               }
            
            
        }.resume()
        
    }

}



#Preview {
    ContentView()
}
