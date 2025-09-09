//
//  CircleView.swift
//  CricutTech
//
//  Created by Tim McEwan on 9/4/25.
//

import SwiftUI
import Combine

struct CircleView: View {
    @ObservedObject var viewModel = ViewModel()
    private let flexibleColumn = [
        GridItem(.flexible(minimum: 100, maximum: 200)),
        GridItem(.flexible(minimum: 100, maximum: 200)),
        GridItem(.flexible(minimum: 100, maximum: 200))
    ]
    
    var body: some View {
        
        VStack {
            // MARK: Main Grid
            ScrollView {
                LazyVGrid(columns: flexibleColumn) {
                    ForEach(0..<viewModel.circleShapes.count, id: \.self) { i in
                        Image(systemName: viewModel.circleShapes[i])
                            .foregroundStyle(.teal)
                            .font(.system(size: 100))
                            .accessibilityLabel(viewModel.circleString)
                    }
                }.padding()
            }
            Spacer()
            HStack {
                Button {
                    viewModel.removeAllCirclesFromMasterList()
                } label: {
                    Text("Delete All")
                }.padding([.trailing], 85)
                
                Button {
                    viewModel.addACircle()
                } label: {
                    Text("Add")
                    
                }.padding([.trailing], 84)
                
                Button {
                    viewModel.removeCircle()
                } label: {
                    Text("Remove")
                    
                }.padding([.trailing])
            }
        }
        .onAppear {
            viewModel.filterToCircle()
        }
        
    }
}

#Preview {
    CircleView()
}
