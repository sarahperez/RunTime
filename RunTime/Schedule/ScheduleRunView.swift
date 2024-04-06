//
//  ScheduleRunView.swift
//  RunTime
//
//  Created by Sarah Perez on 4/6/24.
//

import SwiftUI

struct ScheduleRunView: View {
    var body: some View {
        VStack {
            Text("Your Recommendations:")
            
            List(/*@START_MENU_TOKEN@*/0 ..< 5/*@END_MENU_TOKEN@*/) { item in
                Image(systemName: "figure.run")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 50)
                
                VStack(alignment: .center) {
                    Text("Sunday, April 5th @ 5pm")
                        .fontWeight(.semibold)
                        .lineLimit(2)
                    Text("Hii")
                }
            }
            
        }
    }
}

#Preview {
    ScheduleRunView()
}
