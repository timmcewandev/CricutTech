//
//  ContentView.swift
//  CricutTech
//
//  Created by Tim McEwan on 9/4/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ViewModel()
    
    private let flexibleColumn = [
        GridItem(.flexible(minimum: 100, maximum: 200)),
        GridItem(.flexible(minimum: 100, maximum: 200)),
        GridItem(.flexible(minimum: 100, maximum: 200))
    ]
    
    var body: some View {
        NavigationView {
            GeometryReader { geo in
                VStack {
                    // MARK: Main Grid
                    ScrollView {
                        LazyVGrid(columns: flexibleColumn) {
                            ForEach(0..<viewModel.masterShapes.count, id: \.self) { i in
                                let shape = viewModel.masterShapes[i]
                                Image(systemName: viewModel.masterShapes[i])
                                    .foregroundStyle(.teal)
                                    .font(.system(size: 100))
                                    .accessibilityLabel(shape)
                            }
                        }.padding()
                    }
                    Spacer()
                    // MARK: Bottom bar
                    HStack(alignment: .center) {
                        ForEach(viewModel.shape) { shape in
                            Button {
                                Task {
                                    viewModel.addNewShape(shape: shape.name)
                                }
                            } label: {
                                Spacer()
                                Text(shape.name)
                                Spacer()
                            }
                        }
                    }
                }
                .task {
                    await viewModel.getButton()
                }
                // MARK: Top Toolbar
                .toolbar {
                    // MARK: Clear All Button
                    ToolbarItem(placement: .topBarLeading) {
                        Button {
                            viewModel.removeAllShapes()
                        } label: {
                            Text("Clear All")
                                .foregroundStyle(.blue)
                        }
                    }
                    
                    // MARK: Edit Circle
                    ToolbarItem(placement: .topBarTrailing) {
                        NavigationLink {
                            CircleView(viewModel: viewModel)
                        } label: {
                            Text("edit Circle")
                                .foregroundStyle(.blue)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
