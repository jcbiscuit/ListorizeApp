//
//  TomorrowView.swift
//  ListorizeApp
//
//  Created by Jody Clelland on 26/2/21.
//

import SwiftUI
import CoreData

struct TomorrowView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(entity: SavingTomorrow.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \SavingTomorrow.name, ascending: true)]) var todos:
        FetchedResults<SavingTomorrow>
    @State private var showingTomorrowAddToDoView: Bool = false
    
    var body: some View {
        Form {
            ForEach(self.todos, id: \.self) { todo in
                
                    Text(todo.name ?? "Unknown")
                    
               
            }
            .onDelete(perform: deleteTodo)
            
        }
        .navigationBarTitle("TODAY", displayMode: .inline)
        .navigationBarItems(
            trailing: EditButton()
            
            .sheet(isPresented: $showingTomorrowAddToDoView) {
                TomorrowAddToDoView().environment(\.managedObjectContext, self.managedObjectContext)
            }
        )
        
   
    
    Button(action: {
                            self.showingTomorrowAddToDoView.toggle()
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


struct TomorrowView_Previews: PreviewProvider {
    static var previews: some View {
        TomorrowView()
    }
}
