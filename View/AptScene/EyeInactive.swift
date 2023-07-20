//
//  EyeInactive.swift
//  MC3
//
//  Created by 최민규 on 2023/07/16.
//

import SwiftUI

struct EyeInactive: View {
    var body: some View {
       
        Image.assets.eye.inactive
            .resizable()
            .scaledToFit()
    }
}

struct EyeInactive_Previews: PreviewProvider {
    static var previews: some View {
        EyeInactive()
    }
}
