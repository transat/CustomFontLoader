//
//  FontListView.swift
//  
//
//  Created by Clément Girault on 26/4/2023.
//

import SwiftUI

public struct FontListView: View {
    @ObservedObject public var viewModel = FontViewModel()
    @Environment(\.fontFiles) var fontFiles: [String]
    
    public init() {}
    
    public var body: some View {
        VStack {
            TextField("Enter your text", text: $viewModel.text)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Slider(value: $viewModel.fontSize, in: 10...72, step: 1)
                .padding()
            
            List {
                ForEach(fontFiles, id: \.self) { fontFile in
                    Text(viewModel.text)
                        .customFont(fontFile, size: viewModel.fontSize)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
        }
    }
}

public class FontViewModel: ObservableObject {
    @Published public var text: String = "The quick brown fox jumps over the lazy dog !?"
    @Published public var fontSize: CGFloat = 18
}
