//
//  DetailsView.swift
//  StarWars
//
//  Created by Nicolas on 13/10/2020.
//

import SwiftUI
struct DetailsConteinerView: View {
    @StateObject var viewModel = PeopleViewViewModel()

    var body: some View{
        DetailsView()
            .onAppear { viewModel.loadPeople() }
        
    }
}

struct DetailsView: View {
    var body: some View {
        ZStack {
            Image("sky").edgesIgnoringSafeArea(.all)
            VStack{
                    Text("STAR WARS")
                        .foregroundColor(.yellow)
                        .bold()
                        .font(.system(size: 50))
                    Text("CHARACTER DETAILS")
                        .foregroundColor(.yellow)
                        .bold()
                        .font(.system(size: 25))
                    //Spacer()
                    ScrollView{
                        VStack(alignment:.center){
                            HStack{
                                Text("Name: ").foregroundColor(.yellow).font(.system(size: 25))
                                Spacer()
                                Text("pers2").foregroundColor(.yellow).font(.system(size: 25))
                            }
                            HStack{
                                Text("Height: ").foregroundColor(.yellow).font(.system(size: 25))
                                Spacer()
                                Text("177").foregroundColor(.yellow).font(.system(size: 25))
                            }
                            HStack{
                                Text("Mass: ").foregroundColor(.yellow).font(.system(size: 25))
                                Spacer()
                                Text("77").foregroundColor(.yellow).font(.system(size: 25))
                            }
                            HStack{
                                Text("Hair Color: ").foregroundColor(.yellow).font(.system(size: 25))
                                Spacer()
                                Text("black").foregroundColor(.yellow).font(.system(size: 25))
                            }
                            HStack{
                                Text("Skin Color: ").foregroundColor(.yellow).font(.system(size: 25))
                                Spacer()
                                Text("black").foregroundColor(.yellow).font(.system(size: 25))
                            }
                            HStack{
                                Text("Eyes Color: ").foregroundColor(.yellow).font(.system(size: 25))
                                Spacer()
                                Text("blu").foregroundColor(.yellow).font(.system(size: 25))
                            }
                        }.padding(.top,100)
                    .padding(.horizontal)
                    VStack(alignment:.center){
                        HStack{
                            Text("Birth Year: ").foregroundColor(.yellow).font(.system(size: 25))
                            Spacer()
                            Text("19BBY").foregroundColor(.yellow).font(.system(size: 25))
                        }
                        HStack{
                            Text("Gender: ").foregroundColor(.yellow).font(.system(size: 25))
                            Spacer()
                            Text("Male").foregroundColor(.yellow).font(.system(size: 25))
                        }
                        HStack{
                            Text("Home World: ").foregroundColor(.yellow).font(.system(size: 25))
                            Spacer()
                            Text("7S7").foregroundColor(.yellow).font(.system(size: 25))
                        }
                        HStack{
                            Text("Species: ").foregroundColor(.yellow).font(.system(size: 25))
                            Spacer()
                            Text("black").foregroundColor(.yellow).font(.system(size: 25))
                        }
                        HStack{
                            Text("Vehicles: ").foregroundColor(.yellow).font(.system(size: 25))
                            Spacer()
                            Text(" ").foregroundColor(.yellow).font(.system(size: 25))
                        }
                        HStack{
                            Text("Star Ships: ").foregroundColor(.yellow).font(.system(size: 25))
                            Spacer()
                            Text(" ").foregroundColor(.yellow).font(.system(size: 25))
                        }
                    }.padding(.horizontal)
                }
                    
                
                    Spacer()
            }
        }
        
        }
}

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsView()
    }
}
