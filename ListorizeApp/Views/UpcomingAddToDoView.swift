//
//  UpcomingAddToDoView.swift
//  ListorizeApp
//
//  Created by Jody Clelland on 26/2/21.
//

import SwiftUI
import CoreData

struct UpcomingAddToDoView: View {
    
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
                    TextField("Listorize Upcoming", text: $name)
                    
                    Button(action: {
                        if self.name != "" {
                            let todo = SavingUpcoming(context: self.managedObjectContext)
                            todo.name = self.name
                            
                            
                            do {
                                try self.managedObjectContext.save()
                                
                            } catch {
                                print(error)
                            }
                        } else {
                            self.errorShowing = true
                            self.errorTitle = "Oops!"
                            self.errorMessage = "Be sure to enter something \nto Listerize Upcoming"
                            return
                        }
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Save")
                    }
                }
            
                Spacer()
            }
            .navigationBarTitle("UPCOMING", displayMode: .inline)
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


struct UpcomingAddToDoView_Previews: PreviewProvider {
    static var previews: some View {
        UpcomingAddToDoView()
    }
}

