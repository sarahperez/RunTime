//
//  ContentView.swift
//  RunTime
//
//  Created by Sarah Perez on 4/6/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    var body: some View {
    NavigationView {
        
        //Background
        LinearGradient(gradient: Gradient(colors: [Color(.sRGB, red: 0.4, green: 0.9, blue: 1.0), Color.purple]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
                .overlay(

            VStack(spacing:20) {
                
                //Greeting Header
                //Rectangle
                RoundedRectangle(cornerRadius: 10.0)
                    .frame(width: 350, height: 120)
                    .cornerRadius(15)
                    .foregroundColor(Color.white)
                    .shadow(radius: 10)
                    .overlay(
                        
                        //Inside of rectangle
                        //Header
                        HStack {
                            Image(systemName: "sunrise.fill").font(.system(size:40))
                            Text("Hello, Username!")
                                .font(.title)
                                .fontWeight(.semibold)
                        }
                            .padding()
                        
                    
                    )
                    .overlay(
                        //Subheader
                        VStack{
                            Text("Happy Saturday, April 6")
                                .font(.subheadline)
                                .offset(y: 45)
                        }
                    )
                HStack {
                        //Schedule run button
                        NavigationLink(destination: ScheduleRunView()) {
                            Button("") {
                                /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/ /*@END_MENU_TOKEN@*/
                            }
                            .frame(width: 160, height: 150).background(Color.white).foregroundColor(.black).cornerRadius(15).shadow(radius:10).overlay(
                                Image(systemName: "clock").foregroundColor(Color.black).font(.system(size:50)).offset(y: -10)
                            
                            ).overlay(Text("Schedule Run").foregroundColor(Color.black).offset(y:40))
                                .padding(.trailing, 15)
                            //Past runs button
                            Button("") {
                                /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/ /*@END_MENU_TOKEN@*/
                            }
                            .frame(width: 160, height: 150).background(Color.white).foregroundColor(.black).cornerRadius(15).shadow(radius:10).overlay(
                                Image(systemName: "figure.run").foregroundColor(Color.black).font(.system(size:50)).offset(y: -10)
                            
                            ).overlay(Text("Past Runs").foregroundColor(Color.black).offset(y:40))
                    }
                    
                }
                        
                
                
            }
                .padding()
            )
        }
    }

}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
