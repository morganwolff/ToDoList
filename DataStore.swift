//
//  DataStore.swift
//  ToDoList
//
//  Created by Morgan Wolff on 16/11/2022.
//

import Foundation
import SwiftUI
import Combine

struct Task : Identifiable {
    var isCompleted: Bool = false
    var id = String()
    var newTask = String()
}

class TaskStore : ObservableObject {
    @Published var tasks = [Task]()
}
