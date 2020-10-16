//
//  DetailsView.swift
//  StarWars
//
//  Created by Nicolas on 13/10/2020.
//

import SwiftUI
struct DetailsConteinerView: View {
    @StateObject var viewModel: DetailsViewViewModel
    
    init(personId: String) {
        self._viewModel = StateObject(wrappedValue: DetailsViewViewModel(personId: personId))
    }

    var body: some View{
        DetailsView(details: viewModel.details ,planet: viewModel.planet, isLoading: viewModel.isLoading)
            .onAppear { viewModel.loadDetails()}
        
    }
}

struct DetailsView: View {
    let details: Details?
    let planet: Planet?
    let isLoading: Bool
    var body: some View {
        ZStack {
            Image("sky").edgesIgnoringSafeArea(.all)
            VStack{
                
                Text("STAR WARS")
                    .foregroundColor(.yellow)
                    .bold()
                    .font(.system(size: 50))
                    .padding(.top, 100)
                Text("CHARACTER DETAILS")
                    .foregroundColor(.yellow)
                    .bold()
                    .font(.system(size: 25))
                    .padding(.bottom, 60)
                    .navigationBarTitle("Details List", displayMode: .inline)
                    

                if !isLoading {
                    if let character = details {
                        ScrollView() {
                            HStack() {
                                Text("").padding(.horizontal, 70)
                                VStack(alignment: .leading) {
                                    VStack(alignment: .leading){
                                        HStack(){
                                            Text("Name:").foregroundColor(.yellow).font(.system(size: 30))
                                            Text(character.name)
                                                .foregroundColor(.white).font(.system(size: 30))
              
                                        }
                                        HStack{
                                            Text("Height: ").foregroundColor(.yellow).font(.system(size: 30))
                                            Text(character.height).foregroundColor(.white).font(.system(size: 30))
                                        }
                                        HStack{
                                            Text("Mass: ").foregroundColor(.yellow).font(.system(size: 30))
                                            Text(character.mass).foregroundColor(.white).font(.system(size: 30))
                                        }
                                        HStack{
                                            Text("Hair Color: ").foregroundColor(.yellow).font(.system(size: 30))
                                            Text(character.hairColor).foregroundColor(.white).font(.system(size: 30))
                                        }
                                        HStack{
                                            Text("Skin Color: ").foregroundColor(.yellow).font(.system(size: 30))
                                            Text(character.skinColor).foregroundColor(.white).font(.system(size: 30))
                                        }
                                        HStack{
                                            Text("Eyes Color: ").foregroundColor(.yellow).font(.system(size: 30))

                                            Text(character.eyeColor).foregroundColor(.white).font(.system(size: 30))
                                        }
                                    }
                                
                                VStack(alignment:.leading){
                                    HStack{
                                        Text("Birth Year: ").foregroundColor(.yellow).font(.system(size: 30))
                                        Text(character.birthYear).foregroundColor(.white).font(.system(size: 30))
                                    }
                                    HStack{
                                        Text("Gender: ").foregroundColor(.yellow).font(.system(size: 30))
                                        Text(character.gender).foregroundColor(.white).font(.system(size: 30))
                                    }
                                    HStack{
                                        
                                        Text("Home World: ").foregroundColor(.yellow).font(.system(size: 30))
                                        if let world = planet{
                                            Text(world.name).foregroundColor(.white).font(.system(size: 30))
                                        }
                                        else{
                                            Text("n/a").foregroundColor(.white).font(.system(size: 30))
                                        }
                                    }
//                                    HStack{
//                                        Text("Species: ").foregroundColor(.yellow).font(.system(size: 30))
//                                        Text("black").foregroundColor(.white).font(.system(size: 30))
//                                    }
        //                            HStack{
        //                                Text("Vehicles: ").foregroundColor(.yellow).font(.system(size: 30))
        //                                Text(" ").foregroundColor(.white).font(.system(size: 30))
        //                            }
        //                            HStack{
        //                                Text("Star Ships: ").foregroundColor(.yellow).font(.system(size: 30))
        //                                Text(" ").foregroundColor(.white).font(.system(size: 30))
        //                            }
                                }
                                    
                                }
                                Text(" ").padding(.horizontal, 50)
                            }
                        }.padding(.top, 50)

                        
                        
                    }
                }else{
                        VStack {
                            ProgressView("Loading...")
                                .progressViewStyle(CircularProgressViewStyle(tint: .yellow))
                                .foregroundColor(.white)


                        }.padding(.top,270)
                    }
                    
                

                Spacer()
            }
        }
        
    }
}

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                DetailsView(
                    details:
                        Details(
                            name: "Luke Skywalker Luke Skywalker",
                            height: "7",
                            mass: "7",
                            hairColor: "String",
                            skinColor: "String",
                            eyeColor: "String",
                            birthYear: "String",
                            gender: "String",
                            homeworld: "String"),
                    planet: Planet(name: "String"),
                    isLoading: false
                )
            }
            
//            NavigationView {
//                DetailsView(details: nil, planet: nil, isLoading: true)
//            }
        }
    }
}
