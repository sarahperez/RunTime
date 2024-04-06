//
//  ReviewView.swift
//  RunTime
//
//  Created by sophie ruetschi on 4/6/24.
//

import SwiftUI
import EventKit
import Foundation

struct ReviewView: View {
    var reviewEvent: EKEvent
    @EnvironmentObject var userReviews:Reviews
    @State private var ratingSlider:Double = 0.0
    @State private var value = ""
    
    var body: some View {
        
        Text("How was your run on").font(.largeTitle)
        
        HStack {
            Text(reviewEvent.startDate, style: .date)
                .foregroundStyle(.primary)
                .font(.title)
            Text("at")
                .foregroundStyle(.primary)
                .font(.title)
            Text(reviewEvent.startDate, style: .time)
                .foregroundStyle(.primary)
                .font(.title)
            Text("?")
                .foregroundStyle(.primary)
                .font(.title)
        }
        
        Slider( value: $ratingSlider,
                in: 0...5,
                step: 0.5
        ).padding(.all, 20)
        
        Text(String(format: "%.01f", ratingSlider) + "/5")
        
        GroupBox() {
            TextField("Additional notes:", text: $value)
        }.padding([.top, .bottom], 30)
        
        Button("Test") {
            buttonClick(e:reviewEvent, r:ratingSlider, n:value)
        }
        .frame(width: 160, height: 150)
        .background(Color.white)
        .foregroundColor(.black)
        .cornerRadius(15)
        .shadow(radius:10)
//        .overlay(
//            Image(systemName: "checkmark.square").foregroundColor(Color.black).font(.system(size:50)).offset(y: -10)
//        ).overlay(Text("Complete review")
//            .foregroundColor(Color.black)
//            .offset(y:40))
//        .padding(.trailing, 15)
        
    }
    
    func buttonClick(e:EKEvent, r:Double, n:String){
        userReviews.addReview(e:reviewEvent, r:ratingSlider, n:value)
    }
}

//struct Review_Previews: PreviewProvider {
//    static var previews: some View {
//        ReviewView(reviewEvent: <#Binding<EKEvent>#>)
//    }
//}
