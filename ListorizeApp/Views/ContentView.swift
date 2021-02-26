//
//  EntryPointView.swift
//  ListorizeApp
//
//  Created by Jody Clelland on 25/2/21.
//

import SwiftUI

struct SplashScreenView: View {
    
    @State var animate = false
    @State var endSplash = false
    
    var body: some View {
            ZStack {
                Color(.systemRed)
                
                Image("ListorizeImage")
                    .resizable()
                    .renderingMode(.original)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: animate ? nil : 45, height: animate ? nil : 45)
                    
                    .scaleEffect(animate ? 3 : 1)
                    .frame(width: UIScreen.main.bounds.width)
            }
            
            .ignoresSafeArea(.all, edges: .all)
            .onAppear(perform: animateSplash)
            .opacity(endSplash ? 0 : 1)
        
    }
    
    func animateSplash() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            withAnimation(Animation.easeOut(duration: 1.0)) {
                animate.toggle()
            }
            withAnimation(Animation.linear(duration: 1.0)) {
                endSplash.toggle()
            }
        }
    }
}



struct ContentView: View {
    
    @State private var currentDate = Date()
    
    
    var body: some View {
        ZStack {
            Color("BackgroundColor")
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                NavigationView {
                    VStack {
                        Text("LISTORIZE").bold().underline().kerning(2.5)
                            .font(.system(size: 40)).fontWeight(.thin).foregroundColor(Color("TextColor"))
                            .padding(.bottom, 100)
                    
                        HStack {
                            NavigationLink(
                                destination: TodayView()) {
                                Text("TODAY").bold().font(.system(size: 20)).kerning(2.5)
                                    .frame(width: 180, height: 70)
                                    .foregroundColor(.black)
                                    .background(ZStack {
                                        Color("TodayColor")
                                        LinearGradient(gradient: Gradient(colors: [Color.white.opacity(0.3), Color.clear]), startPoint: .top, endPoint: .bottom)
                                    })
                                    .cornerRadius(50)
                                    .padding(.all)
                            }
                            
                            NavigationLink(
                                destination: TomorrowView()) {
                                Text("TOMORROW") .bold().font(.system(size: 20)).kerning(2.5)
                                    .frame(width: 180, height: 70)
                                    .foregroundColor(.black)
                                    .background(ZStack {
                                        Color("TomorrowColor")
                                        LinearGradient(gradient: Gradient(colors: [Color.white.opacity(0.3), Color.clear]), startPoint: .top, endPoint: .bottom)
                                    })
                                    .cornerRadius(50)
                                    .padding(.all)
                            }
                        }
                    
                        NavigationLink(
                            destination: UpcomingView()) {
                            Text("UPCOMING").font(.system(size: 20)).bold().kerning(2.5)
                                .frame(width: 400, height: 70)
                                .foregroundColor(.black)
                                .background(ZStack {
                                    Color("UpcomingColor")
                                    LinearGradient(gradient: Gradient(colors: [Color.white.opacity(0.3), Color.clear]), startPoint: .top, endPoint: .bottom)
                                })
                                .cornerRadius(50)
                                .padding()
                        }
                        
        
                        DatePicker("Current Date", selection: $currentDate, in: Date()..., displayedComponents: .date)
                            .padding()
                            .datePickerStyle(GraphicalDatePickerStyle())
                        
                    }
                }
                
            }
            
        }
    }
}
 

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        ContentView()
            .preferredColorScheme(.dark)
    }
}
