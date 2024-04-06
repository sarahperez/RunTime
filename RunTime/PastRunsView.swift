//
//  PastRunsView.swift
//  RunTime
//
//  Created by sophie ruetschi on 4/6/24.
//

import SwiftUI
import EventKitUI
import Foundation

struct Review: Identifiable {
    let date:Date
    let rating:Int
    let note:String
    let id = UUID()
    
//    init(date: Date, rating: Int, note: String) {
//        self.date = date
//        self.rating = rating
//        self.note = note
//        }
}

let formatter = DateFormatter()

struct PastRunsView: View {
    
    var Reviews = [Review(date:Date.now, rating:5, note:"good"),
                   Review(date:Date.now, rating:0, note:"bad")]
    
    var body: some View {
        
        Label("Past Runs", systemImage: "figure.run.circle.fill")
        
        List() {
            /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Content@*/Text("Content")/*@END_MENU_TOKEN@*/
        }
        
        Label("Reviewed Runs", systemImage: "figure.run.circle.fill")
        
        List(Reviews) {
            var displayNote = $0.note
            var displayDate = $0.date
            var displayRating = $0.rating
            
            GroupBox(label: Text(formatter.string(from: displayDate))){
                
                Text(displayNote)
            }
        }
    }
}

#Preview {
    PastRunsView()
}
