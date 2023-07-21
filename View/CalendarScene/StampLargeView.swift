//
//  StampLargeView.swift
//  MC3
//
//  Created by Seohyun Hwang on 2023/07/20.
//

import SwiftUI

struct StampLargeView: View {
    
    var skyColor: LinearGradient
    var skyImage: String
    
    
    var body: some View {
        RoundedRectangle(cornerRadius: 40)
            .fill(skyColor)
            .frame(width: UIScreen.main.bounds.width * 0.6, height: UIScreen.main.bounds.width * 0.6)
            .overlay {
                Image(skyImage)
                    .resizable()
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: 40))
                // MARK: - 해당 날의 캐릭커 출석 모습 넣기
                RoundedRectangle(cornerRadius: 40)
                    .strokeBorder(Color.black, lineWidth: 2)
                Image("Eye_stamp")
                    .resizable()
                    .scaledToFit()
            }
    }
}

struct StampLargeView_Previews: PreviewProvider {
    static var previews: some View {
        StampLargeView(skyColor: Color.sky.clearDay, skyImage: "LargeStamp_clearDay")
    }
}
