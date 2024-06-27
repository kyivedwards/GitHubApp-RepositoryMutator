//
//  RespositoryListViewModel.swift
//  GitHubApp
//
//  Created by Kyiv Edwards on 6/24/24.
//

import Foundation
import Apollo

typealias Node = GetRepositoriesByUserNameQuery.Data.User.Repository.Node

//View Model Class binds list data to view
class RepositoryListViewModel: ObservableObject {
    
    // Published array of RepositoryViewModel objects to update the view automatically
    @Published var repositories: [RepositoryViewModel] = []
    
    func getLatestRepositoriesForUser(username: String) {
        //Network call using Apollo to fetch data with the specified query
        Network.shared.apollo.fetch(query: GetRepositoriesByUserNameQuery(username: username)) { result in
            switch result {
            case.success(let graphQLResult):
                //Guard for nil values to ensure data integrity
                guard let data = graphQLResult.data,
                      let user = data.user,
                      let nodes = user.repositories.nodes
                else{
                    return
                }
                DispatchQueue.main.async {
                    self.repositories = nodes.compactMap{ $0 }.map(RepositoryViewModel.init)
                }
                
            case.failure(let error):
                print(error)
            }
        }
    }
    
}

// ViewModel for each repository to provide data to the view
struct RepositoryViewModel {
    
    //Fetch Node attribute from Query (Each node represents a repository)
    let node: Node
    
    var hasRating: Bool {
        node.stargazerCount > 0
    }
    var id: GraphQLID {
        node.id
    }
    
    var name: String {
        node.name
    }
    var description: String {
        node.description ?? ""
    }
    
    var starCount: Int {
        node.stargazerCount
    }
    
    
}
