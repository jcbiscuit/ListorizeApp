//
//  TodayView.swift
//  ListorizeApp
//
//  Created by Jody Clelland on 25/2/21.
//

import SwiftUI
import CoreData

struct TodayView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @State private var showingAddToDoView: Bool = false
    
    var body: some View {
        NavigationView {
            List(/*@START_MENU_TOKEN@*/0 ..< 5/*@END_MENU_TOKEN@*/) { item in
                Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            }
            .navigationBarTitle("TODAY", displayMode: .inline)
            .navigationBarItems(trailing:
                                    Button(action: {
                                        self.showingAddToDoView.toggle()
                                    }) {
                                        Image(systemName: "plus")
                                            .foregroundColor(Color(.systemBlue))
                                            .font(.system(size: 30, weight:.bold))
                                        
                                    }
                .sheet(isPresented: $showingAddToDoView) {
                    AddToDoView().environment(\.managedObjectContext, self.managedObjectContext)
                }
            )
            
        }
        
    }
}

struct TodayView_Previews: PreviewProvider {
    static var previews: some View {
        TodayView()
    }
}
