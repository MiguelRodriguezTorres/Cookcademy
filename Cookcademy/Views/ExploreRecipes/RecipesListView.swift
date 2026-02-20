//
//  ContentView.swift
//  Cookcademy
//
//  Created by Miguel Rodriguez on 1/10/26.
//

import SwiftUI

struct RecipesListView: View {
    @EnvironmentObject private var recipeData: RecipeData
    let viewStyle: ViewStyle
    
    @State private var isPresenting = false
    @State private var newRecipe = Recipe()
    
    // App Colors
    @AppStorage("listBackgroundColor") private var listBackgroundColor = AppColor.background
    @AppStorage("listTextColor") private var listTextColor = AppColor.foreground
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(recipes) { recipe in
                    NavigationLink(recipe.mainInformation.name, destination: RecipeDetailView(recipe: binding(for: recipe)))
                }
                .listRowBackground(listBackgroundColor)
                .foregroundColor(listTextColor)
            }
            .navigationTitle(navigationTitle)
            .toolbar(content: {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        isPresenting = true
                        
                        newRecipe = Recipe()
                        newRecipe.mainInformation.category = recipes.first?.mainInformation.category ?? .breakfast
                    }, label: {
                        Image(systemName: "plus")
                    })
//                    Button(action: {
//                        isPresenting = true
//                    }, label: {
//                        Image(systemName: "plus")
//                    })
                }
            })
            .sheet(isPresented: $isPresenting, content: {
                NavigationStack {
                    ModifyRecipeView(recipe: $newRecipe)
                        .toolbar(content: {
                            ToolbarItem(placement: .cancellationAction) {
                                Button("Dismiss") {
                                    isPresenting = false
                                }
                            }
                            ToolbarItem(placement: .confirmationAction) {
                                if newRecipe.isValid {
//                                    if case .favorites = viewStyle {
//                                        newRecipe.isFavorite = true
//                                    }
//                                    recipeData.add(recipe: newRecipe)
//                                    isPresenting = false
                                    Button("Add") {
                                        if case .favorites = viewStyle {
                                            newRecipe.isFavorite = true
                                        }
                                        
                                        recipeData.add(recipe: newRecipe)
                                        isPresenting = false
                                    }
                                }
                            }
                        })
                        .navigationTitle("Add a New Recipe")
                }
            })
        }
    }
}

extension RecipesListView {
    enum ViewStyle {
        case favorites
        case singleCategory(MainInformation.Category)
    }
    
    private var recipes: [Recipe] {
        switch viewStyle {
            case let .singleCategory(category):
                return recipeData.recipes(for: category)
            case .favorites:
                return recipeData.favoriteRecipes
        }
    }
    
    private var navigationTitle: String {
        switch viewStyle {
            case let .singleCategory(category):
                return "\(category.rawValue) Recipes"
            case .favorites:
                return "Favorite Recipes"
        }
    }
    
    func binding(for recipe: Recipe) -> Binding<Recipe> {
        guard let index = recipeData.index(of: recipe) else {
            fatalError("Recipe not found.")
        }
        
        return $recipeData.recipes[index]
    }
}

#Preview {
    NavigationStack {
        RecipesListView(viewStyle: .singleCategory(.breakfast))
            .environmentObject(RecipeData())
    }
}
