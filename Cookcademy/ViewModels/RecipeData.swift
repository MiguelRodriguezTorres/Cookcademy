//
//  RecipeData.swift
//  Cookcademy
//
//  Created by Miguel Rodriguez on 1/11/26.
//

import Foundation
import Combine

class RecipeData: ObservableObject {
    @Published var recipes = Recipe.testRecipes
}
