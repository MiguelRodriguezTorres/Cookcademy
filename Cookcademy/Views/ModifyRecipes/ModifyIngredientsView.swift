//
//  ModifyIngredientsView.swift
//  Cookcademy
//
//  Created by Miguel Rodriguez on 1/25/26.
//

import SwiftUI

struct ModifyIngredientsView: View {
    @Binding var ingredients: [Ingredient]
    @State private var newIngredient = Ingredient()
    
    private let listBackgroundColor = AppColor.background
    private let listTextColor = AppColor.foreground

    var body: some View {
        // closure for ModifyIngredientView
        let addIngredientView = ModifyIngredientView(ingredient: $newIngredient) { ingredient in
            ingredients.append(ingredient)
            newIngredient = Ingredient()
        }
        
        NavigationStack { // must use Navigation Stack for links
            VStack {
                if ingredients.isEmpty {
                    Spacer()
                    NavigationLink(
                        "Add the first ingredient",
                        destination: addIngredientView
                    )
                    Spacer()
                } else {
                    List {
                        ForEach(ingredients.indices, id: \.self) { index in
                            let ingredient = ingredients[index]
                            Text(ingredient.description)
                        }
                        .listRowBackground(listBackgroundColor)
                        NavigationLink(
                            "Add another ingredient",
                            destination: addIngredientView
                        )
                        .buttonStyle(PlainButtonStyle())
                        .listRowBackground(listBackgroundColor)
                    }
                    .foregroundStyle(listTextColor)
                }
            }
        }
    }
}

#Preview {
    @Previewable @State var ingredients = [Ingredient]()
    
    ModifyIngredientsView(ingredients: $ingredients)
}
