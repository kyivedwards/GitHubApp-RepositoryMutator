//
//  AddRepositoryViewModel.swift
//  GitHubApp
//
//  Created by Kyiv Edwards on 6/24/24.
//

import Foundation

class AddRepositoryViewModel: ObservableObject {
    
    var name: String = ""
    var description: String = ""
    var visibility: RepositoryVisibility = .public
    @Published var errors: [ErrorViewModel] = []
    
    //Create Repository: Function utilizing mutation from API
    func saveRepository(completion: @escaping () -> Void) {
        
        Network.shared.apollo.perform(mutation: CreateRepositoryMutation(name: name, description: description, visibility: visibility, clientMutationId: UUID().uuidString)) { result in
            
            switch result {
                case .success(let graphQLResult):
                    if let errors = graphQLResult.errors {
                        DispatchQueue.main.async {
                            self.errors = errors.map {
                                ErrorViewModel(message: $0.message)
                            }
                        }
                    } else {
                        DispatchQueue.main.async {
                            completion()
                        }
                    }
                case .failure(let error):
                DispatchQueue.main.async {
                    self.errors = [ErrorViewModel(message: error.localizedDescription)]
                }
            }
        }
        
    }
}
