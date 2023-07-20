//
//  SceneButtons.swift
//  MC3
//
//  Created by 최민규 on 2023/07/16.
//

import SwiftUI

struct SceneButtons: View {
    
    @State var index: Int = 0
    //
    var body: some View {
        
        ZStack {
            Color.clear
            if index % 2 == 0 {
                Button(action: {
                    print("\(index)")
                }) {
                    Color.clear
                        .cornerRadius(8)
                }
            } else {
                Button(action: {
                    print("\(index)")
                }) {
                    Color.clear
                        .cornerRadius(8)
                }
            }
            
        }
    }
}

struct SceneButtons_Previews: PreviewProvider {
    static var previews: some View {
        SceneButtons()
    }
}
