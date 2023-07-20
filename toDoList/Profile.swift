//
//  Profile.swift
//  toDoList
//
//  Created by Ashika on 7/19/23.
//

import SwiftUI

struct Profile: View {
    @Environment(\.managedObjectContext) var context
    @State private var showNewTask = false
    @FetchRequest(
        entity: ToDo.entity(), sortDescriptors: [ NSSortDescriptor(keyPath: \ToDo.id, ascending: false) ])
    
    var toDoItems: FetchedResults<ToDo>
    
    var body: some View {
        VStack {
            HStack {
                Text("Profile Page")
                    .font(.system(size: 30))
                    .fontWeight(.black)
                
                Spacer()
                Button(action: {
                    self.showNewTask = true
                    
                }) {
                    Text("Click to make a new profile")
                }
            }
            .padding()
            Spacer()
            List {
                ForEach (toDoItems) { toDoItem in
                    if toDoItem.isImportant == true {
                        let profileString = (toDoItem.title ?? "No name") + " \nAge: " + (toDoItem.age ?? "Unknown")
                        Text(profileString + " \nStyle: " + (toDoItem.style ?? "Unknown"))
                    } else {
                        Text("User information not saved")
                    }
                }
                .onDelete(perform: deleteTask)
            }
            .listStyle(.plain)
        }
        if showNewTask {
            NewToDoView(showNewTask: $showNewTask, title: "", age: "", style: "", isImportant: false)
                    }
        }
    private func deleteTask(offsets: IndexSet) {
            withAnimation {
                offsets.map { toDoItems[$0] }.forEach(context.delete)

                do {
                    try context.save()
                } catch {
                    print(error)
                }
            }
        }
    }
    
struct Profile_Previews: PreviewProvider {
    static var previews: some View {
        Profile()
    }
}
