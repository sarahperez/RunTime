//
//  PastRunsView.swift
//  RunTime
//
//  Created by sophie ruetschi on 4/6/24.
//

import SwiftUI
import EventKit
import Foundation

struct Review: Identifiable {
    let event:EKEvent
    let rating:Double
    let note:String
    let id = UUID()
}

class Reviews: ObservableObject{
    var rev = [Review]()
    
    func addReview(e:EKEvent, r:Double, n:String){
        rev.append(Review(event:e, rating:r, note:n));
        print(rev.count)
    }
}

struct PastRunsView: View {
    
    //var Reviews:[Review]
    
    @EnvironmentObject var storeManager: EventStoreManager
    @State private var shouldPresentError: Bool = false
    @State private var alertMessage: String?
    @State private var alertTitle: String?
    @State var selection: Set<EKEvent> = []
    @State var editMode: EditMode = .inactive
    @State var currEvent:EKEvent? = nil
    @StateObject var userReviews = Reviews()
    
    var body: some View {
        
        Label("Review your past runs", systemImage: "figure.run.circle.fill")
        
        
        if storeManager.events.isEmpty {
            MessageView(message: .events)
        } else {
            List(selection: $selection) {
                ForEach(storeManager.events, id: \.self) { event in
                    NavigationLink(destination: ReviewView(reviewEvent: event).environmentObject(userReviews)) {
                            HStack {
                                Text(event.startDate, style: .date)
                                    .foregroundStyle(.primary)
                                    .font(.caption)
                                Text("at")
                                    .foregroundStyle(.primary)
                                    .font(.caption)
                                Text(event.startDate, style: .time)
                                    .foregroundStyle(.primary)
                                    .font(.caption)
                            }
                        }
        
                }
                .environment(\.editMode, $editMode)
            }
            
            
            Label("Reviewed Runs", systemImage: "figure.run.circle.fill")
            
            List(userReviews.rev) { item in
                //unpack from list of reviewed runs
                var displayNote = item.note
                var event = item.event
                var displayRating = item.rating
                
                //make a groped box for each run
                GroupBox(label: Text(event.startDate, style: .date)){
    
                    ProgressView(value: (displayRating / 5.0)){
                        Text("Your safety rating: " + String(displayRating) + "/5")
                    }
    
                    Text("Notes: " + displayNote)
                }
            }
        }
    }
}

//struct PastRuns_Previews: PreviewProvider {
//    static var previews: some View {
//        PastRunsView()
//            .environmentObject(EventStoreManager())
//    }
//}

