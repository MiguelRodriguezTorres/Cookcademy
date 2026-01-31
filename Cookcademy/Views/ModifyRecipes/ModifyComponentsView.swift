//
//  ModifyIngredientsView.swift
//  Cookcademy
//
//  Created by Miguel Rodriguez on 1/25/26.
//

import SwiftUI

protocol RecipeComponent: CustomStringConvertible {
    init()
    static func singularName() -> String
    static func pluralName() -> String
}

extension RecipeComponent {
    static func singularName() -> String {
        String(describing: self).lowercased()
    }
    
    static func pluarlName() -> String {
        self.singularName() + "s"
    }
}

// Creating the ModifyComponentView
protocol ModifyComponentView: View {
    associatedtype Component
    init(component: Binding<Component>, createAction: @escaping (Component) -> Void)
}

struct ModifyComponentsView<Component: RecipeComponent, DestinationView: ModifyComponentView>: View where DestinationView.Component == Component {
    @Binding var components: [Component]
    @State private var newComponent = Component()
    
    private let listBackgroundColor = AppColor.background
    private let listTextColor = AppColor.foreground

    var body: some View {
        NavigationStack { // must use Navigation Stack for links
            VStack {
                // closure for ModifyIngredientView
                let addComponentView = DestinationView(component: $newComponent) { component in
                    components.append(component)
                    newComponent = Component()
                }.navigationTitle("Add \(Component.singularName().capitalized)")
                
                if components.isEmpty {
                    Spacer()
                    NavigationLink(
                        "Add the first \(Component.singularName())",
                        destination: addComponentView
                    )
                    Spacer()
                } else {
                    HStack {
                        Text(Component.pluarlName().capitalized)
                            .font(.title)
                            .padding()
                        Spacer()
                    }
                    List {
                        ForEach(components.indices, id: \.self) { index in
                            let component = components[index]
                            Text(component.description)
                        }
                        .listRowBackground(listBackgroundColor)
                        NavigationLink(
                            "Add another \(Component.singularName())",
                            destination: addComponentView
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
    //@Previewable @State var ingredients = [Ingredient]()
    @Previewable @State var emptyIngredients = [Ingredient]()
    @Previewable @State var recipe = Recipe()
    
//    ModifyComponentsView<Ingredient, ModifyIngredientView>(ingredients: $ingredients)
    NavigationStack {
        ModifyComponentsView<Ingredient, ModifyIngredientView>(components: $emptyIngredients)
    }
    NavigationStack {
        ModifyComponentsView<Ingredient, ModifyIngredientView>(components: $recipe.ingredients)
    }
}
