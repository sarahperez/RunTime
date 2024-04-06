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
      LinearGradient(gradient: Gradient(colors: [Color(.sRGB, red: 0.4, green: 0.9, blue: 1.0), Color.purple]), startPoint: .top, endPoint: .bottom)
        .edgesIgnoringSafeArea(.all)
        .overlay(
          VStack{
            Image("RunTime Logo")
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
