//
//  ContentView.swift
//  RunTime
//
//  Created by Sarah Perez on 4/6/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @StateObject private var sunViewModel = SunViewModel()
    @StateObject private var storeManager: EventStoreManager = EventStoreManager()
    
    var body: some View {
    NavigationView {
        
        //Background
        LinearGradient(gradient: Gradient(colors: [Color(.sRGB, red: 1.0, green: 0.7, blue: 0.85), Color.yellow]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
                .overlay(
                    ScrollView{
                        VStack(spacing:20) {
                            HStack{
                                //Run - Header
                                Text("Run")
                                    .font(.largeTitle)
                                    .fontWeight(.heavy).padding(.leading,43)
                                //Profile
                                Image("Minuet").resizable().aspectRatio(contentMode: .fit).frame(width: 70, height: 70).clipShape(Circle())
                                //Time - Header
                                Text("Time")
                                    .font(.largeTitle)
                                    .fontWeight(.heavy)
                            
                                //Preferences (Settings)
                                Image(systemName: "gearshape.fill").foregroundColor(Color.black).offset(x: 5,y:-40).font(.system(size:25))
                            }
                            //Greeting Header
                            //Rectangle
                            RoundedRectangle(cornerRadius: 10.0)
                                .frame(width: 350, height: 120)
                                .cornerRadius(15)
                                .foregroundColor(Color.white)
                                .shadow(radius: 3)
                                .overlay(
                                    
                                    //Inside of rectangle
                                    //Header
                                    HStack {
                                        Image(systemName: "sunrise.fill").foregroundColor(Color.yellow).font(.system(size:40)).offset(x: -15)
                                        Text("Hello, Minuet!")
                                            .font(.title)
                                            .fontWeight(.semibold)
                                    }
                                        .padding()
                                    
                                    
                                )
                                .overlay(
                                    //Subheader
                                    VStack{
                                        HStack {
                                                                        if let sunData = sunViewModel.sunData {
                                                                            Text("Sunrise: \(sunData.sunrise)")
                                                                            Text("Sunset: \(sunData.sunset)")
                                                                        } else if sunViewModel.error != nil {
                                                                            Text("Error")
                                                                        } else {
                                                                            ProgressView("Fetching Sun Data...")
                                                                        }
                                                                    }
                                                                    .onAppear {
                                                                        sunViewModel.fetch()
                                                                    }
                                            .font(.subheadline)
                                            .offset(y: 45)
                                    }
                                )
                            //Schedule Run and Past Runs
                            HStack {
                                //Schedule run button
                                NavigationLink(destination: CalendarAuthorizationView().environmentObject(storeManager)
                                    .task {
                                        await storeManager.listenForCalendarChanges()
                                    }) {
                                    Button("") {
                                        /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/ /*@END_MENU_TOKEN@*/
                                    }
                                    .frame(width: 160, height: 150).background(Color.white).foregroundColor(.black).cornerRadius(15).shadow(radius:3).overlay(
                                        Image(systemName: "calendar.badge.clock").foregroundColor(Color( red: 0.5, green: 0.7, blue: 1.0)).font(.system(size:50)).offset(y: -10)
                                        
                                    ).overlay(Text("Schedule Run").font(.headline).foregroundColor(Color.black).offset(y:40))
                                        .padding(.trailing, 20)
                                    
                                }
                                
                                NavigationLink(destination: PastRunsView().environmentObject(storeManager)
                                    .task {
                                        await storeManager.listenForCalendarChanges()
                                    }) {
                                    Button("") {
                                        /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/ /*@END_MENU_TOKEN@*/
                                    }
                                    .frame(width: 160, height: 150).background(Color.white).foregroundColor(.black).cornerRadius(15).shadow(radius:3).overlay(
                                        Image(systemName: "figure.run").foregroundColor(Color(red: 0.6, green: 0.5, blue: 1.0)).font(.system(size:50)).offset(y: -10)
                                        
                                    ).overlay(Text("Past Runs").font(.headline).foregroundColor(Color.black).offset(y:40))
                                }
                                
                            }
                            //My Upcoming Runs
                            List {
                                HStack{
                                    Image(systemName: "figure.run.circle").foregroundColor(Color.pink).font(.system(size:25))
                                    
                                    VStack(alignment: .leading){
                                        Text("Sunday, April 7 - 5:45 PM").foregroundColor(Color.black).multilineTextAlignment(.leading)
                                        Text("Moderate intesity; 30 min run").font(.caption).foregroundColor(Color.black)
                                    }
                                }
                                HStack{
                                    Image(systemName: "figure.run.circle").foregroundColor(Color.green).font(.system(size:25))
                                    
                                    VStack(alignment: .leading){
                                        Text("Tuesday, April 9 - 10:00 AM").foregroundColor(Color.black).multilineTextAlignment(.leading)
                                        Text("High intesntiy; 45 min run").font(.caption).foregroundColor(Color.black)
                                    }
                                }
                                    .foregroundColor(Color.black)
                            }.frame(width:350, height: 190).cornerRadius(15).foregroundColor(Color.white).shadow(radius:3).overlay(Text("My Upcoming Runs").offset(y:-75)).overlay(VStack {
                                NavigationLink(destination: UpcomingRunsView().environmentObject(storeManager)
                                    .task {
                                        await storeManager.listenForCalendarChanges()
                                    }) {
                                    Text("See all")
                                }
                            }.offset(y:75))
                            
                            List {
                                HStack{
                                    Image("Sophie").resizable().aspectRatio(contentMode: .fit).frame(width: 50, height: 50).clipShape(Circle())
                                    
                                    VStack(alignment: .leading){
                                        Text("Sophie R.").foregroundColor(Color.black).multilineTextAlignment(.leading)
                                        Text("Ran for 30 mins on Apr 4, 2024").font(.caption).foregroundColor(Color.black)
                                    }
                                }
                                HStack{
                                    Image("Tori").resizable().aspectRatio(contentMode: .fit).frame(width: 50, height: 50).clipShape(Circle())
                                    
                                    VStack(alignment: .leading){
                                        Text("Tori P.").foregroundColor(Color.black).multilineTextAlignment(.leading)
                                        Text("Ran for 10 mins on Apr 4, 2024").font(.caption).foregroundColor(Color.black)
                                    }
                                }
                                HStack{
                                    Image("Sarah").resizable().aspectRatio(contentMode: .fit).frame(width: 50, height: 50).clipShape(Circle())
                                    
                                    VStack(alignment: .leading){
                                        Text("Sarah P.").foregroundColor(Color.black).multilineTextAlignment(.leading)
                                        Text("Ran for 50 mins on Apr 1, 2024").font(.caption).foregroundColor(Color.black)
                                    }
                                }
                                
                            }.frame(width:350, height: 300).cornerRadius(15).foregroundColor(Color.white).shadow(radius:3).overlay(Text("Recent Friend Activity").offset(y:-130)).overlay(Button("See all") {
                                /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/ /*@END_MENU_TOKEN@*/
                            }.offset(y:125))
                        }
                    }
                )
        }
    }

}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
