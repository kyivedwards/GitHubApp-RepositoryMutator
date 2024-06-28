//
//  AddRepositoryScreen.swift
//  GitHubApp
//
//  Created by Kyiv Edwards on 6/24/24.
//

import SwiftUI


struct AddRepositoryScreen: View {
    
    @Environment(\.presentationMode) private var presentationMode
    @StateObject private var addRepositoryVM = AddRepositoryViewModel()
    
    var body: some View {
        Form {
            TextField("Name", text: $addRepositoryVM.name)
            TextField("Description", text: $addRepositoryVM.description)
            
            Picker("Select", selection: $addRepositoryVM.visibility, content: {
                Text("Public").tag(RepositoryVisibility.public)
                Text("Private").tag(RepositoryVisibility.private)
            }).pickerStyle(SegmentedPickerStyle())
            
            
            HStack {
                Spacer()
                Button("Save") {
                    
                    addRepositoryVM.saveRepository {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
                Spacer()
            }
        }
        .navigationTitle("Add Repository")
        .embedInNavigationView()
    }
}

struct AddRepositoryScreen_Previews: PreviewProvider {
    static var previews: some View {
        AddRepositoryScreen()
    }
}
