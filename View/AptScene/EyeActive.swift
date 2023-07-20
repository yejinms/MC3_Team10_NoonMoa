//
//  EyeActive.swift
//  MC3
//
//  Created by 최민규 on 2023/07/16.
//

import SwiftUI

struct EyeActive: View {
    var body: some View {
        
        Image.assets.eye.active
            .resizable()
            .scaledToFit()
    }
}

struct EyeActive_Previews: PreviewProvider {
    static var previews: some View {
        EyeActive()
    }
}
