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
    @Published var reviewedSet:Set<EKEvent> = []
    
    func addReview(e:EKEvent, r:Double, n:String){
        rev.append(Review(event:e, rating:r, note:n));
        reviewedSet.insert(e)
        print(rev.count)
    }
}

struct PastRunsView: View {
    
    @EnvironmentObject var storeManager: EventStoreManager
    @StateObject var userReviews = Reviews()
    @State private var selection: Set<EKEvent> = []
    @State private var editMode: EditMode = .inactive
    var currentDate = Date()
    
    var body: some View {
        ZStack {
            // Background gradient
            LinearGradient(gradient: Gradient(colors: [Color(.sRGB, red: 1.0, green: 0.7, blue: 0.85), Color.yellow]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Label("Review your past runs", systemImage: "figure.run.circle.fill")
                
                if storeManager.events.isEmpty {
                    MessageView(message: .events)
                } else {
                    List(selection: $selection) {
                        ForEach(storeManager.events, id: \.self) { event in
                            if (!userReviews.reviewedSet.contains(event) && event.startDate < currentDate) {
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
                        }
                        
                    }
                    .environment(\.editMode, $editMode)
                    .scrollContentBackground(.hidden)
                }
                
                Label("Reviewed Runs", systemImage: "figure.run.circle.fill")
                
                List(userReviews.rev) { item in
                    var displayNote = item.note
                    var event = item.event
                    var displayRating = item.rating
                    
                    GroupBox(label: Text(event.startDate, style: .date)) {
                        ProgressView(value: (displayRating / 5.0)){
                            Text("Your safety rating: " + String(displayRating) + "/5")
                        }
                        
                        Text("Notes: " + displayNote)
                    }
                }
                .environment(\.editMode, $editMode)
                .scrollContentBackground(.hidden)
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

