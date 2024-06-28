//
//  Query+Extensions.swift
//  GitHubApp
//
//  Created by Kyiv Edwards on 6/26/24.
//

import Foundation
import Apollo

extension GetRepositoriesByUserNameQuery.Data.User.Repository.Node: RepositoryNode{ }
extension GetTopRepositoriesForUserQuery.Data.User.Repository.Node: RepositoryNode{ }
