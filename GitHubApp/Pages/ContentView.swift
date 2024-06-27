//
//  ContentView.swift
//  GitHubApp
//
//  Created by Kyiv Edwards on 6/24/24.
//

import SwiftUI
import Combine

struct ContentView: View {
    
    @State private var repositoriesDisplay: String = "latest"
    @State private var isPresented: Bool = false
    @StateObject private var repositoryListVM = RepositoryListViewModel()
    
    var body: some View {
        VStack {
            
            Picker("Select", selection: $repositoriesDisplay, content: {
                Text("Latest").tag("latest")
                Text("Top").tag("top")
            }).pickerStyle(SegmentedPickerStyle())
            
            
            List(repositoryListVM.repositories, id: \.id) { repository in
                HStack {
                    VStack(alignment: .leading, spacing: 10) {
                        Text(repository.name)
                            //.font(.headline)
                            .font(.system(size: 20))
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        Text(repository.description)
                            .font(.system(size: 18))
                    }
                    Spacer()
                    
                    if repository.hasRating {
                        HStack {
                            Text("\(repository.starCount)")
                            Image(systemName: "star.fill")
                                .foregroundColor(.yellow)
                        }
                    }
                }
            }.listStyle(PlainListStyle())
        }
        .padding()
        .onAppear(perform: {
            repositoryListVM.getLatestRepositoriesForUser(username: Constants.User.username)
        })
        .navigationBarItems(trailing: Button(action: {
            isPresented = true
        }, label: {
            Image(systemName: "plus")
        }))
        .sheet(isPresented: $isPresented, onDismiss: {
            
        }, content: {
            AddRepositoryScreen()
        })
        .navigationTitle("Repositories")
        .embedInNavigationView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
