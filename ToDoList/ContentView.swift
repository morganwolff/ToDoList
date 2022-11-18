//
//  ContentView.swift
//  ToDoList
//
//  Created by Morgan Wolff on 16/11/2022.
//

import SwiftUI
import Combine

struct ContentView: View {
    @ObservedObject var taskStore = TaskStore()
    @ State var newnewTask : String = ""
    
    enum Sections: String, CaseIterable {
        case pending = "Pending"
        case completed = "Completed"
    }
    
    var searchBar : some View {
        HStack {
            TextField("Insert New Tasks", text: self.$newnewTask)
                .onSubmit {
                    withAnimation {
                        addNewNewTask()
                    }
                }
            Button(action: self.addNewNewTask, label: {Image(systemName: "square.and.pencil")})
        }
    }
    
    var PendingTasks: [Binding<Task>] {
        $taskStore.tasks.filter { !$0.isCompleted.wrappedValue}
    }
    
    var CompletedTasks: [Binding<Task>] {
        $taskStore.tasks.filter { $0.isCompleted.wrappedValue}
    }

    var body: some View {
        NavigationView{
            ScrollViewReader { proxy in
                VStack {
                    Rectangle()
                        .frame(height: 0)
                        .background(.ultraThinMaterial)
                    searchBar
                        .padding()
                    List {
                        ForEach(Sections.allCases, id: \.self) { section in
                            Section {
                                
                                let filteredTasks = section == .pending ? PendingTasks: CompletedTasks
                                
                                if filteredTasks.isEmpty {
                                    Text("No tasks available.")
                                        .foregroundColor(.gray)
                                }
                                
                                ForEach(filteredTasks) { $task in
                                    TaskViewCell(task: $task)
                                }
                            } header: {
                                Text(section.rawValue)
                            }
                        }.onMove(perform: self.move)
                            .onDelete(perform: self.delete)
                    }.navigationBarTitleDisplayMode(.inline)
                        .toolbar {
                            ToolbarItem(placement: .principal) {
                                Text("ToDoList")
                                    .font(.largeTitle.bold())
                                    .accessibilityAddTraits(.isHeader)
                            }
                        }
                }
                .navigationBarItems(leading: HStack {
                    Button(action: self.deleteAllTasks, label: {Image(systemName: "trash").foregroundColor(.red) })
                }, trailing: HStack {
                    EditButton()
                })
            }
        }
    }
    
    func move (from source: IndexSet, to destination: Int) {
        taskStore.tasks.move(fromOffsets: source, toOffset: destination)
    }
    
    func delete (at offsets: IndexSet) {
        taskStore.tasks.remove(atOffsets: offsets)
    }
    
    func addNewNewTask () {
        taskStore.tasks
            .insert(Task(id: String(taskStore.tasks.count + 1), newTask:newnewTask), at: 0)
        
        self.newnewTask = ""
    }
    
    func deleteAllTasks () {
        taskStore.tasks.removeAll()
    }

}

struct TaskViewCell: View {
    @Binding var task: Task
    
    var body: some View {
        HStack {
            Image(systemName: task.isCompleted ? "checkmark.square" : "square")
                .onTapGesture {
                    task.isCompleted.toggle()
                }
            Text(task.newTask)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
