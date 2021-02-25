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
    @State private var errorShowing: Bool = false
    @State private var errorTitle: String = ""
    @State private var errorMessage: String = ""
    
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
                                print("New todo: \(todo.name ?? "")")
                            } catch {
                                print(error)
                            }
                        } else {
                            self.errorShowing = true
                            self.errorTitle = "Oops!"
                            self.errorMessage = "Be sure to enter something \nto Listerize Today"
                            return
                        }
                        self.presentationMode.wrappedValue.dismiss()
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
            .alert(isPresented: $errorShowing) {
                Alert(title: Text(errorTitle), message: Text(errorMessage), dismissButton: .default(Text("Got it, thanks!")))
            }
        }
        
    }
}

struct AddToDoView_Previews: PreviewProvider {
    static var previews: some View {
        AddToDoView()
    }
}
