import SwiftUI
import Firebase


struct AptView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    @EnvironmentObject var aptViewModel: AptViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                if let apt = aptViewModel.apt {
                    Text("Apt Number: \(apt.number)")
                    List(aptViewModel.rooms, id: \.id) { room in
                        Section(header: Text("Room \(room.number)")) {
                            if let user = aptViewModel.users.first(where: { $0.id == room.userId }) {
                                VStack {
                                    Text("State: \(user.stateEnum.rawValue)")
                                    Text("Eye Color: \(user.eyeColorEnum.rawValue)")
                                    Text("Last Active Date: \(user.lastActiveDate ?? Date())")
                                }
                            }
                        }
                    }
                    Spacer()
                    NavigationLink(
                        destination: CalendarFullView(),
                        label: {
                            Image(systemName: "calendar")
                        })
                } else {
                    Text("Loading data...")
                }
            }
            .onAppear {
                aptViewModel.fetchCurrentUserApt()
            }
        }
        
    }
}
