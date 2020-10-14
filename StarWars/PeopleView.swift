import SwiftUI

struct PeopleConteinerView: View {
    @StateObject var viewModel = PeopleViewViewModel()

    var body: some View{
        PeopleView(people: viewModel.people, isLoading: viewModel.isLoading)
            .onAppear { viewModel.loadPeople() }
        
    }
}

struct PeopleView: View {
    let people: [String]
    let isLoading: Bool 
    var body: some View {
        ZStack {
            Image("sky")
                .edgesIgnoringSafeArea(.all)
            VStack{
                Text("STAR WARS")
                    .foregroundColor(.yellow)
                    .bold()
                    .font(.system(size: 50))
                Text("CHARACTERS LIST")
                    .foregroundColor(.yellow)
                    .bold()
                    .font(.system(size: 25))
                    .navigationBarTitle("Characters list")
                Spacer()
                
                if !isLoading {
                    ScrollView{
                        ForEach(people, id: \.self) { person in
                            NavigationLink(destination: DetailsView()) {
                                Text(person).foregroundColor(.yellow).font(.system(size: 25))
                            }
                        }
                    }
                }else{
                    VStack {
                        ProgressView("Loading...")
                            .progressViewStyle(CircularProgressViewStyle(tint: .yellow))
                            .foregroundColor(.yellow)
                    }
                }
                Spacer()
            }
        }
    }
}

struct PeopleView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                PeopleView(people: ["1","1","1"], isLoading: false)
            }
            
            NavigationView {
                PeopleView(people: [], isLoading: true)
            }
        }
    }
}
