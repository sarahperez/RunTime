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
        LinearGradient(gradient: Gradient(colors: [Color(.sRGB, red: 0.4, green: 0.9, blue: 1.0), Color.purple]), startPoint: .top, endPoint: .bottom)
            .edgesIgnoringSafeArea(.all)
            .overlay(
            VStack {
                if storeManager.events.isEmpty {
                    MessageView(message: .events)
                } else {
                    List(selection: $selection) {
                        var recommendations = createRecommendations(calendarEvents: storeManager.events)
                        ForEach(recommendations, id: \.self) { event in
                            VStack(alignment: .leading, spacing: 7) {
                                Image(systemName: "figure.run")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 30)
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
                                }.sheet(isPresented: $showEventEditViewController,
                                        onDismiss: didDismissEventEditController, content: {
                                    EventEditViewController(event: $selectedRunTime, eventStore: store)
                             })
                                .tint(.green)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding().background(Color.clear).cornerRadius(15).shadow(color: Color.black.opacity(0.2), radius: 5)
                        }
                    }
                    .environment(\.editMode, $editMode)
                    .scrollContentBackground(.hidden)
                }
            }
                .cornerRadius(10)
        )
            .alertErrorMessage(message: alertMessage, title: alertTitle, isPresented: $shouldPresentError)
    }
    
    func didDismissEventEditController() {
        selectedRunTime = nil
    }
    
    func createRecommendations(calendarEvents: [EKEvent]) -> [EKEvent] {
        
        
//        ForEach(storeManager.events, id: \.self) { event in
//            
//            
//        }
        
        return storeManager.events
    }
    
    func scheduleRunAction(event: EKEvent) {
//        Task {
//            if #unavailable(iOS 17) {
//                do {
//                    guard try await store.requestAccess(to: .event) else {
//                        selection = nil
//                        let message = "The app doesn't have permission to access calendar data. Please grant the app access to Calendar in Settings."
//                        showError(message, title: "Calendar access denied")
//                        return
//                    }
//                } catch {
//                    selection = nil
//                    showError(error.localizedDescription, title: "Failed to request calendar access")
//                    return
//                }
//            }
            
            selectedRunTime = event
            
            showEventEditViewController.toggle()
            print(showEventEditViewController)
            print(selectedRunTime!)
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
