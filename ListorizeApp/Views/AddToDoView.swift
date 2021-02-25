//
//  AddToDoView.swift
//  ListorizeApp
//
//  Created by Jody Clelland on 25/2/21.
//

import SwiftUI

struct AddToDoView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @State private var name: String = ""
    
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    TextField("Listorize Today", text: $name)
                    
                    Button(action: {
                        if self.name != "" {
                            let todo = Saving(context: self.managedObjectContext)
                            todo.name = self.name
                            
                            
                            do {
                                try self.managedObjectContext.save()
//                                print("New todo: \(todo.name ?? "")")
                            } catch {
                                print(error)
                            }
                        }
                        
                    }) {
                        Text("Save")
                    }
                }
            
                Spacer()
            }
            .navigationBarTitle("TODAY", displayMode: .inline)
            .navigationBarItems(trailing:
                                    Button(action: {
                                        self.presentationMode.wrappedValue.dismiss()
                                    }) {
                                        Image(systemName: "xmark")
                                            .font(.system(size: 20, weight:.bold))
                                    }
            )
        }
        
    }
}

struct AddToDoView_Previews: PreviewProvider {
    static var previews: some View {
        AddToDoView()
    }
}
