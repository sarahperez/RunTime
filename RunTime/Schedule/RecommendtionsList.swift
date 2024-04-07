/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
A view to display and delete monthly events.
*/

//
//  ScheduleRunView.swift
//  RunTime
//
//  Created by Sarah Perez on 4/6/24.
//

import SwiftUI
import EventKit

struct RecommendtionsList: View {
    
    @State var selectedRunTime: EKEvent?
    
    @EnvironmentObject var storeManager: EventStoreManager
    @State private var shouldPresentError: Bool = false
    @State private var showEventEditViewController = false
    @State private var alertMessage: String?
    @State private var alertTitle: String?
    @State var selection: Set<EKEvent> = []
    @State var editMode: EditMode = .inactive
    @State private var store = EKEventStore()
    
    /*
        Displays a list of events that occur within this month in all the user's calendars. Removes an event from Calendar when the user deletes it
        from the list.
    */
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [Color(.sRGB, red: 1.0, green: 0.7, blue: 0.85), Color.yellow]), startPoint: .top, endPoint: .bottom)
            .edgesIgnoringSafeArea(.all)
            .overlay(
                VStack {
                    if storeManager.events.isEmpty {
                        MessageView(message: .events)
                    } else {
                        List(selection: $selection) {
                            let recommendations = createRecommendations(calendarEvents: storeManager.events)
                            ForEach(recommendations, id: \.self) { event in
                                VStack(alignment: .leading, spacing: 7) {
                                    HStack {
                                        Image(systemName: "figure.run")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(height: 50)
                                            .foregroundColor(getRunColor(runTypeTitle: event.title))
                                        Text(event.title).font(.title)
                                    }
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
                                } .swipeActions {
                                    Button("Schedule") {
                                        scheduleRunAction(event: event)
                                    }
                                    .tint(.green)
                                }
                                .sheet(isPresented: $showEventEditViewController,
                                       onDismiss: didDismissEventEditController, content: {
                                    EventEditViewController(event: $selectedRunTime, eventStore: store)
                                })
                            }
                        }
                        .environment(\.editMode, $editMode)
                        .scrollContentBackground(.hidden)
                    }
                }
            )
            .alertErrorMessage(message: alertMessage, title: alertTitle, isPresented: $shouldPresentError)
    }
    
    func getRunColor(runTypeTitle: String) -> Color {
        switch runTypeTitle {
        case "Easy Run":
            return .green
        case "Moderate Run":
            return .purple
        case "Tempo Run":
            return .yellow
        case "Threshold Run":
            return .red
        case "Long Run":
            return .orange
        case "Race":
            return .blue
        default:
            return .black
        }
    }
    
    func didDismissEventEditController() {
        selectedRunTime = nil
    }
    
    func createRecommendations(calendarEvents: [EKEvent]) -> [EKEvent] {
        var recommendations: [EKEvent] = []
        let runIntensities = getRunIntensity()
        let runCount = 1...5
        
        let event = EKEvent(eventStore: store)
        let intensity = runIntensities[Int.random(in: 0..<6)]
        // get random run intensity
        
        event.title = intensity.title
        event.startDate = Date()
        event.endDate = event.startDate.addingTimeInterval(TimeInterval(intensity.duration))
        
        recommendations.append(event)
        
        for _ in runCount {
            let event = EKEvent(eventStore: store)
            let intensity = runIntensities[Int.random(in: 0..<6)]
            // get random run intensity
            
            event.title = intensity.title
            event.startDate = Date(timeIntervalSinceNow: TimeInterval(Int.random(in: 0...23400)))
            event.endDate = event.startDate.addingTimeInterval(TimeInterval(intensity.duration))
            
            recommendations.append(event)
        }
        
        return recommendations
    }
    
    private func getRunIntensity() -> [RunIntensity] {
        return [RunIntensity.easy, RunIntensity.moderate, RunIntensity.tempo, RunIntensity.threshold, RunIntensity.long, RunIntensity.race]
    }
    
    func scheduleRunAction(event: EKEvent) {
            
            selectedRunTime = event
            
            self.showEventEditViewController = true;
            print(showEventEditViewController)
            
        
//        }
    }
    
    /// Delete the selected event from Calendar.
    func removeEvents(_ events: [EKEvent]) {
        Task {
            do {
                try await storeManager.removeEvents(events)
                selection.removeAll()
            } catch {
                showError(error, title: "Delete failed.")
            }
        }
    }
    
    func showError(_ error: Error, title: String) {
        alertTitle = title
        alertMessage = error.localizedDescription
        shouldPresentError = true
    }
}

struct EventList_Previews: PreviewProvider {
    static var previews: some View {
        RecommendtionsList()
            .environmentObject(EventStoreManager())
    }
}
