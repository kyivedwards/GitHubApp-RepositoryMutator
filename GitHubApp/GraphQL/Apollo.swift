//
//  Apollo.swift
//  GitHubApp
//
//  Created by Kyiv Edwards on 6/25/24.
//

import Foundation
import Apollo

//Handling network operations to Apollo Server
class Network {
    
    static let shared = Network()
    private init() { }
    
    
    //Initialize when first accesed
    private(set) lazy var apollo: ApolloClient = {
        
        let url = URL(string: "https://api.github.com/graphql")!
        let configuration = URLSessionConfiguration.default
        
        //Appollo store manages local cache
        let store = ApolloStore()
        configuration.httpAdditionalHeaders = ["Authorization" : "Bearer \(Constants.APIKeys.GitHubAccessToken)"]
        
        //Create client with session configurations
        let sessionClient = URLSessionClient(sessionConfiguration: configuration, callbackQueue: nil)
        //Modify requests and responses at run time
        let provider = DefaultInterceptorProvider(client: sessionClient, shouldInvalidateClientOnDeinit: true, store: store)
        
        let requestChainTransport = RequestChainNetworkTransport(interceptorProvider: provider, endpointURL: url)
        
        return ApolloClient(networkTransport: requestChainTransport, store: store)
    }()
}
