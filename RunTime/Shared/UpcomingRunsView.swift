//
//  UpcomingRunsView.swift
//  RunTime
//
//  Created by Tori Pineda on 4/6/24.
//

import SwiftUI
import EventKit

struct UpcomingRunsView: View {
    
    @State var selectedRunTime: EKEvent?
    
    @EnvironmentObject var storeManager: EventStoreManager
    @State private var shouldPresentError: Bool = false
    @State private var showEventEditViewController = false
    @State private var alertMessage: String?
    @State private var alertTitle: String?
    @State var selection: Set<EKEvent> = []
    @State var editMode: EditMode = .inactive
    @State private var store = EKEventStore()
    
    var body: some View {
        VStack {
            Text("My Upcoming Runs").font(.largeTitle)
                .fontWeight(.heavy).padding(23)
            }
            
            if storeManager.events.isEmpty {
                MessageView(message: .events)
            } else {
                List(selection: $selection) {
                    var recommendations = createUpcoming(calendarEvents: storeManager.events)
                    ForEach(recommendations, id: \.self) { event in
                        VStack(alignment: .leading, spacing: 7) {
                            
                            HStack {
                                
                                Image(systemName: "figure.run")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 50)
                                
                                Text(event.title)
                                    .foregroundStyle(.primary)
                                    .font(.title)
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
                    }
                }
                .environment(\.editMode, $editMode)
            }

        }
    }
    
    func createUpcoming(calendarEvents: [EKEvent]) -> [EKEvent] {
        
        var Return = [EKEvent]()
        var currentDate = Date()
        
        calendarEvents.forEach { event in
            if (event.startDate < currentDate && (event.title.contains("Run") || event.title.contains("Race"))) {
                Return.append(event)
            }
        }
        return Return
    }
}

#Preview {
    UpcomingRunsView()
}
