//
//  ContentView.swift
//  Shared
//
//  Created by Amalia Toutziaridi on 27/10/21.
//


import SwiftUI

struct ContentView: View {
    let color: UIColor = UIColor(
        red: 255/255.0,
        green: 255/255.0,
        blue: 255/255.0,
        alpha: 1
    )
    
    @State var animate: Bool = false
    @State var showSplash: Bool = true
    
    var body: some View {
        VStack {
            ZStack {
                // content
                VStack {
                    
                }
                // splash animation
                ZStack {
                    Color(color)
                    
                    Image("logo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 135, height: 135)
                        .scaleEffect(animate ? 2.5 : 1)
                        .animation(Animation.easeOut(duration: 0.7))
                }
                .edgesIgnoringSafeArea(.all)
                .animation(Animation.linear(duration : 0.5))
                .opacity(showSplash ? 1 : 0)
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now()+0.3){
                animate.toggle()
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now()+1.3){
                  showSplash.toggle()
               }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


