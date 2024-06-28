//
//  RepositoryNode.swift
//  GitHubApp
//
//  Created by Kyiv Edwards on 6/26/24.
//

import Foundation
import Apollo

protocol RepositoryNode {
    var id: GraphQLID {get}
    var name: String {get}
    var description: String? {get}
    var stargazerCount: Int {get}
}
