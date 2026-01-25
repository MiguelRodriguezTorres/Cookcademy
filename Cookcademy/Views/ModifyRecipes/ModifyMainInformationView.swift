//
//  ModifyMainInformationView.swift
//  Cookcademy
//
//  Created by Miguel Rodriguez on 1/25/26.
//

import SwiftUI

struct ModifyMainInformationView: View {
    @Binding var mainInformation: MainInformation
    
    private let listBackgroundColor = AppColor.background
    private let listTextColor = AppColor.foreground
    
    var body: some View {
        Form {
            TextField("Recipe Name", text: $mainInformation.name)
                .listRowBackground(listBackgroundColor)
            TextField("Author", text: $mainInformation.author)
                .listRowBackground(listBackgroundColor)
            Section(header: Text("Description")) {
                TextEditor(text: $mainInformation.description)
                    .listRowBackground(listBackgroundColor)
            }
            Picker(selection: $mainInformation.category, label: HStack {
                Text("Category")
                Spacer()
                Text(mainInformation.category.rawValue)
            }) {
                ForEach(MainInformation.Category.allCases, id: \.self) { category in
                    Text(category.rawValue)
                }
            }
            .listRowBackground(listBackgroundColor)
            .pickerStyle(MenuPickerStyle())
        }
        .foregroundStyle(listTextColor)
    }
}

#Preview {
    // use @Previewable and @State instead of @Binding
    @Previewable @State var sampleInformation = MainInformation(
        name: "Salmon Stir Fry",
        description: "Chopped salmon with mixed vegetables and soy sauce.",
        author: "Miguel Rodriguez",
        category: .dinner
    )
    
    ModifyMainInformationView(mainInformation: $sampleInformation)
}
