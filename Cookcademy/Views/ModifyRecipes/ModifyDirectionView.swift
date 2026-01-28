//
//  ModifyDirectionView.swift
//  Cookcademy
//
//  Created by Miguel Rodriguez on 1/28/26.
//

import SwiftUI

struct ModifyDirectionView: View {
    @Binding var direction: Direction
    let createAction: (Direction) -> Void
    
    private let listBackgroundColor = AppColor.background
    private let listTextColor = AppColor.foreground
    
    @Environment(\.presentationMode) private var mode
    
    var body: some View {
        Form {
            TextField("Direction Description", text: $direction.description)
                .listRowBackground(listBackgroundColor)
            Toggle("Optional", isOn: $direction.isOptional)
                .listRowBackground(listBackgroundColor)
            HStack {
                Spacer()
                Button("Save") {
                    createAction(direction)
                    mode.wrappedValue.dismiss()
                }
                Spacer()
            }
            .listRowBackground(listBackgroundColor)
        }
        .foregroundStyle(listTextColor)
    }
}

#Preview {
    @Previewable @State var emptyDirection: Direction = .init(description: "", isOptional: false)
    
    ModifyDirectionView(direction: $emptyDirection) { _ in return }
}
