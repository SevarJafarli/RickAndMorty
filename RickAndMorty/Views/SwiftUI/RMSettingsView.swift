//
//  RMSettingsView.swift
//  RickAndMorty
//
//  Created by Sevar Jafarli on 26.05.23.
//

import SwiftUI

struct RMSettingsView: View {
    let viewModel: RMSettingsViewViewModel
    init(viewModel: RMSettingsViewViewModel) {
        self.viewModel = viewModel
    }
    var body: some View {
        List(viewModel.cellViewModels) {viewModel in
            HStack {
                if let image = viewModel.image {
                    Image(uiImage: image)
                        .resizable()
                        .renderingMode(.template)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20, height: 20)
                        .padding(8)
                        .foregroundColor(.white)
                        .background(Color(viewModel.imageContainerColor))
                        .cornerRadius(6)
                }
                
                Text(viewModel.title).padding(.leading, 8)
                Spacer()
            }.padding(.bottom, 4)
            .onTapGesture {
                    viewModel.onTapHandler(viewModel.type)
                }
        }
    }
}
    
struct RMSettingsView_Previews: PreviewProvider {
        static var previews: some View {
            RMSettingsView(viewModel: .init(cellViewModels: RMSettingsOption.allCases.compactMap({ option in
                return RMSettingsCellViewModel(type: option) { type in
                   
                }
            })))
        }
}

