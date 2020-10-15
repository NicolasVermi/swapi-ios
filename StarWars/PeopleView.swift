import SwiftUI

struct PeopleConteinerView: View {
    @StateObject var viewModel: PeopleViewViewModel
    
    init(filmId: String) {
        self._viewModel = StateObject(wrappedValue: PeopleViewViewModel(filmId: filmId))
    }

    var body: some View{
        PeopleView(people: viewModel.people.map { $0.name }, isLoading: viewModel.isLoading)
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
                Text("").padding(.bottom, 50)
                Text("STAR WARS")
                    .foregroundColor(.yellow)
                    .bold()
                    .font(.system(size: 50))
                Text("CHARACTERS LIST")
                    .foregroundColor(.yellow)
                    .bold()
                    .font(.system(size: 25))
                    .navigationBarTitle("Characters list")
                    .padding(.bottom, 130)

                Spacer()
                
                if !isLoading {
                    VStack {
                        ScrollView(.vertical){
                            ForEach(people, id: \.self) { person in
                                NavigationLink(destination: DetailsConteinerView(personId: person)) {
                                    Text(person).foregroundColor(.white).font(.system(size: 30))
                                        .bold()
                                        .padding(.vertical,15)
                                }
                            }
                        }
                        Text("").padding(.bottom,200)
                    }
                }else{
                    VStack {
                        ProgressView("Loading...")
                            .progressViewStyle(CircularProgressViewStyle(tint: .yellow))
                            .foregroundColor(.white)
                    }.padding(.bottom,100)
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
                PeopleView(people: ["1","1","1","1","1","1","1","1","1","1","1"], isLoading: false)
            }
            
            NavigationView {
                PeopleView(people: [], isLoading: true)
            }
        }
    }
}
