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
    
    @FetchRequest(entity: Saving.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Saving.name, ascending: true)]) var todos:
        FetchedResults<Saving>
    //This will sort the results in alphabetical order with the name
    
    @State private var showingAddToDoView: Bool = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(self.todos, id: \.self) { todo in
                    HStack {
                        Text(todo.name ?? "Unknown")
                        
                    }
                }
                
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
        TodayView()
            .preferredColorScheme(.dark)
    }
}
