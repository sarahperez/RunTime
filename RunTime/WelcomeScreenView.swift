// RunTime
//
// Created by Minuet Greenberg on 4/6/24.
//
import SwiftUI
struct WelcomeScreenView: View {
  @State private var isShowingText = false
  @State private var isShowingLogo = false
  var body: some View {
    NavigationView {
      LinearGradient(gradient: Gradient(colors: [Color(.sRGB, red: 1.0, green: 0.7, blue: 0.85), Color.yellow]), startPoint: .top, endPoint: .bottom)
        .edgesIgnoringSafeArea(.all)
        .overlay(
          VStack{
            Image("Image")
              .resizable(capInsets: EdgeInsets(), resizingMode: .stretch)
              .frame(width: 300.0, height: 300.0)
            Text("tap anywhere to start").offset(y: 170)
          }
        )
    }
  }
}
#Preview {
  WelcomeScreenView()
}
