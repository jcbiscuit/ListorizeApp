//
//  TestView.swift
//  ListorizeApp
//
//  Created by Jody Clelland on 26/2/21.
//

import SwiftUI
import CoreData

struct UpcomingView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(entity: SavingUpcoming.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \SavingUpcoming.name, ascending: true)]) var todos: FetchedResults<SavingUpcoming>
    @State private var showingUpcomingAddToDoView: Bool = false
    
    var body: some View {
        Form {
            ForEach(self.todos, id: \.self) { todo in
                
                    Text(todo.name ?? "Unknown")
                    
               
            }
            .onDelete(perform: deleteTodo)
            
        }
        .navigationBarTitle("UPCOMING", displayMode: .inline)
        .navigationBarItems(
            trailing: EditButton()
            
            .sheet(isPresented: $showingUpcomingAddToDoView) {
                UpcomingAddToDoView().environment(\.managedObjectContext, self.managedObjectContext)
            }
        )
        
   
    
    Button(action: {
        self.showingUpcomingAddToDoView.toggle()
                        }) {
                            Image(systemName: "plus")
                                .foregroundColor(Color(.systemBlue))
                                .font(.system(size: 30, weight:.bold))
                            
                        }
    
}

private func deleteTodo(at offsets: IndexSet) {
    for index in offsets {
        let todo = todos[index]
        managedObjectContext.delete(todo)
        
        do {
            try managedObjectContext.save()
        } catch {
            print(error)
        }
    }
}
}


struct UpcomingView_Previews: PreviewProvider {
    static var previews: some View {
        UpcomingView()
    }
}
