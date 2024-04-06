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
            VStack {
                NavigationLink(destination: ScheduleRunView()) {
                    Text("Schedule a Run").frame(width: 300, height: 150).background(Color.purple).foregroundColor(.black).cornerRadius(50)
                }
            }
        }
    }

}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
