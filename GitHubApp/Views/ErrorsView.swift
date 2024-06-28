//
//  ErrorView.swift
//  GitHubApp
//
//  Created by Kyiv Edwards on 6/25/24.
//

import SwiftUI

struct ErrorsView: View {
    
    let errors: [ErrorViewModel]
    
    var body: some View {
        VStack {
            ForEach(errors, id: \.id) { error in
                Text(error.message ?? "")
                    .foregroundColor(.red)
            }
        }
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorsView(errors: [ErrorViewModel(message: "Repository has already been created!")])
    }
}
