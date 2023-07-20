import SwiftUI

struct AptView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    @EnvironmentObject var aptViewModel: AptViewModel
    @EnvironmentObject var weather: WeatherViewModel
    @EnvironmentObject var time: TimeViewModel
    
    var body: some View {
        ZStack {
            //배경 레이어
            SceneBackground()
                .environmentObject(weather)
                .environmentObject(time)
            
            //아파트 레이어
            GeometryReader { proxy in
                ZStack {
                    GeometryReader { geo in
                        SceneApt()
                        VStack(spacing: 16) {
                            ForEach(aptViewModel.rooms, id: \.id) { room in
                                HStack(spacing: 12) {
                                    ZStack {
                                        SceneRoom(roomUser: room.number)
                                            .frame(width: (geo.size.width - 48) / 3)
                                        if let user = aptViewModel.users.first(where: { $0.id == room.userId }) {
                                            VStack {
                                                Text("State: \(user.stateEnum.rawValue)")
                                                Text("Eye Color: \(user.eyeColorEnum.rawValue)")
                                                Text("Last Active Date: \(user.lastActiveDate ?? Date())")
                                            }
                                            .font(.footnote)
                                            .frame(width: (geo.size.width - 48) / 3)
                                        }
                                    }
                                }
                            }
                        }
                        .offset(x: 12, y: 32)
                    }
                }
                .padding()
                .ignoresSafeArea()
                .offset(y: proxy.size.height - proxy.size.width * 1.5)
            }
            
            //날씨 레이어
            SceneWeather()
                .environmentObject(weather)
                .environmentObject(time)
            
            // 기능테스트위한 임시 뷰
            FunctionTestView()
                .environmentObject(weather)
                .environmentObject(time)
            
        }
        .onAppear {
            aptViewModel.fetchCurrentUserApt()
        }
    }
}

struct AptView_Previews: PreviewProvider {
    static var previews: some View {
        AptView()
            .environmentObject(AptViewModel())
            .environmentObject(WeatherViewModel())
            .environmentObject(TimeViewModel())
    }
}


//
////
////  ApartView.swift
////  MC3
////
////  Created by 최민규 on 2023/07/14.
////
//
//import SwiftUI
//
//struct AptView: View {
//    @EnvironmentObject var viewRouter: ViewRouter
//    @EnvironmentObject var aptViewModel: AptViewModel
//    @EnvironmentObject var weather: WeatherViewModel
//    @EnvironmentObject var time: TimeViewModel
//
//    let rooms: [[Int]] = [
//        [1, 2, 3],
//        [4, 5, 6],
//        [7, 8, 9],
//        [10, 11, 12]
//    ]
//
//    var body: some View {
//        ZStack{
//            //배경 레이어
//            SceneBackground()
//                .environmentObject(weather)
//                .environmentObject(time)
//
//            //아파트 레이어
//            GeometryReader { proxy in
//                ZStack {
//                    GeometryReader { geo in
//                        SceneApt()
//                        VStack(spacing: 16) {
//                            ForEach(rooms, id: \.self) { row in
//                                HStack(spacing: 12) {
//                                    ForEach(row, id: \.self) { index in
//                                        SceneRoom(roomUser: index)
//                                            .frame(width: (geo.size.width - 48) / 3)
//                                        //디자인요소에서 보더는 빼는 것이 좋아보이고 radius는 8로 하는 것이 좋을 것으로 생각됨
//                                    }
//                                }
//                            }
//                        }
//                        .offset(x: 12, y: 32)
//                    }//GeometryReader
//                }//ZStack
//                .padding()
//                .ignoresSafeArea()
//                .offset(y: proxy.size.height - proxy.size.width * 1.5)
//                //화면만큼 내린 다음에 아파트 크기 비율인 1:1.5에 따라 올리고 24로 보정?
//            }
//
//            //날씨 레이어
//            SceneWeather()
//                .environmentObject(weather)
//                .environmentObject(time)
//
//            //버튼 레이어
//            GeometryReader { proxy in
//                ZStack {
//                    GeometryReader { geo in
//                        VStack(spacing: 16) {
//                            ForEach(rooms, id: \.self) { row in
//                                HStack(spacing: 12) {
//                                    ForEach(row, id: \.self) { index in
//                                        SceneButtons(index: index).environmentObject(weather)
//                                            .frame(width: (geo.size.width - 48) / 3, height: ((geo.size.width - 48) / 3) / 1.2)
//                                        //방 이미지 자체의 비율 1:1.2 통한 높이 산정
//                                    }
//                                }
//                            }
//                        }
//                        .offset(x: 12, y: 32)
//                    }//GeometryReader
//                }//ZStack
//                .padding()
//                .ignoresSafeArea()
//                .offset(y: proxy.size.height - proxy.size.width * 1.5 + 24)
//                //화면만큼 내린 다음에 아파트 크기 비율인 1:1.5에 따라 올리고 24로 보정?
//            }
//
//            //기능테스트위한 임시 뷰
//            FunctionTestView()
//                .environmentObject(weather)
//                .environmentObject(time)
//
//        }//ZStack
//    }
//}
//
//
//
//struct AptView_Previews: PreviewProvider {
//    static var previews: some View {
//        AptView()
//            .environmentObject(WeatherViewModel())
//            .environmentObject(TimeViewModel())
//    }
//}
