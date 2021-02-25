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
            Form {
                ForEach(self.todos, id: \.self) { todo in
                    
                        Text(todo.name ?? "Unknown")
                        
                   
                }
                .onDelete(perform: deleteTodo)
                
            }
            .navigationBarTitle("TODAY", displayMode: .inline)
            .navigationBarItems(
                leading: EditButton(),
                trailing:
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

struct TodayView_Previews: PreviewProvider {
    static var previews: some View {
       TodayView()
        TodayView()
            .preferredColorScheme(.dark)
    }
}
