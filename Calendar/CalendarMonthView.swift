////
////  CalendarMonthView.swift
////  MangMongApt
////
////  Created by kimpepe on 2023/07/17.
//    //
//
//import SwiftUI
//import SwiftUICalendar
//
//struct CalendarMonthView: View {
//    @ObservedObject var controller: CalendarController = CalendarController()
//
//    var body: some View {
//        NavigationView { // Add NavigationView
//            GeometryReader { reader in
//                VStack {
//                    HStack(alignment: .center, spacing: 0) {
//                        Button("Prev") {
//                            controller.scrollTo(controller.yearMonth.addMonth(value: -1), isAnimate: true)
//                        }
//                        .padding(8)
//                        Spacer()
//                        Text("\(controller.yearMonth.monthShortString), \(String(controller.yearMonth.year))")
//                            .font(.title)
//                            .padding(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0))
//                        Spacer()
//                        Button("Next") {
//                            controller.scrollTo(controller.yearMonth.addMonth(value: 1), isAnimate: true)
//                        }
//                        .padding(8)
//                    }
//                    CalendarView(controller, header: { week in
//                        GeometryReader { geometry in
//                            Text(week.shortString)
//                                .font(.subheadline)
//                                .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
//                        }
//                    }, component: { date in
//                        GeometryReader { geometry in
//                            NavigationLink(destination: CalendarDayView(controller: CalendarDayController(date))) { // Use clicked date to initialize DayCalendarController
//                                if date.isToday {
//                                    Circle()
//                                        .padding(4)
//                                        .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
//                                        .foregroundColor(.orange)
//                                    Text("\(date.day)")
//                                        .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
//                                        .font(.system(size: 10, weight: .bold, design: .default))
//                                        .foregroundColor(.white)
//                                } else {
//                                    Text("\(date.day)")
//                                        .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
//                                        .font(.system(size: 10, weight: .light, design: .default))
//    //                                .foregroundColor(getColor(date))
//                                        .opacity(date.isFocusYearMonth == true ? 1 : 0.4)
//                                }
//                            }
//                        }
//                    })
//                }
//            }
//            .onChange(of: controller.yearMonth) { yearMonth in
//                print(yearMonth)
//            }
//            .navigationBarTitle("Embed header")
//        }
//    }
//}
//
//
//struct CalendarCustomView_Previews: PreviewProvider {
//    static var previews: some View {
//        CalendarMonthView()
//    }
//}
//
//
