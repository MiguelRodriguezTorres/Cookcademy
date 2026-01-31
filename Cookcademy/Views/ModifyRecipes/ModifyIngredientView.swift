//
//  ModifyIngredientView.swift
//  Cookcademy
//
//  Created by Miguel Rodriguez on 1/25/26.
//

import SwiftUI

struct ModifyIngredientView: ModifyComponentView {
    @Binding var ingredient: Ingredient
    @Environment(\.presentationMode) private var mode
    
    private let listBackgroundColor = AppColor.background
    private let listTextColor = AppColor.foreground
    
    let createAction: (Ingredient) -> Void
    
    init(component: Binding<Ingredient>, createAction: @escaping (Ingredient) -> Void) {
        self._ingredient = component
        self.createAction = createAction
    }
    
    var body: some View {
        VStack {
            Form {
                TextField("Ingredient Name", text: $ingredient.name)
                    .listRowBackground(listBackgroundColor)
                Stepper(value: $ingredient.quantity, in: 0...100, step: 0.5) {
                    HStack {
                        Text("Quantity:")
                        TextField(
                            "Quantity",
                            value: $ingredient.quantity,
                            formatter: NumberFormatter.decimal
                        )
                        .keyboardType(.numbersAndPunctuation)
                    }
                }
                .listRowBackground(listBackgroundColor)
                Picker(
                    selection: $ingredient.unit,
                    label: HStack {
                        Text("Unit")
                        Spacer()
                        Text(ingredient.unit.rawValue)
                    }
                ) {
                    ForEach(Ingredient.Unit.allCases, id: \.self) { unit in
                        Text(unit.rawValue)
                    }
                }
                .listRowBackground(listBackgroundColor)
                .pickerStyle(MenuPickerStyle())
                HStack {
                    Spacer()
                    Button("Save") {
                        createAction(ingredient)
                        mode.wrappedValue.dismiss()
                    }
                    Spacer()
                }
                .listRowBackground(listBackgroundColor)
            }
            .foregroundStyle(listTextColor)
        }
    }
}

extension NumberFormatter {
    static var decimal: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }
}

#Preview {
    // no static and add @Previewable
    //@Previewable @State var emptyIngredient = Ingredient()
    @Previewable @State var emptyIngredient = Recipe.testRecipes[0].ingredients[0]
    
    ModifyIngredientView(component: $emptyIngredient) { ingredient in
        print(ingredient)
    }
}
