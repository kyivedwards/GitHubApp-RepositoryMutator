//
//  View+Extensions.swift
//  GitHubApp
//
//  Created by Kyiv Edwards on 6/26/24.
//

import Foundation
import SwiftUI

extension View {
    
    func embedInNavigationView() -> some View {
        NavigationView { self }
    }
}
