//
//  Teste_SwiftUIApp.swift
//  Teste SwiftUI
//
//  Created by Lucca Lopes on 19/08/22.
//

import SwiftUI
import CoreData

@main
struct Main: App {
//    let persistenceController = PersistenceController.shared
    
//    @StateObject var vm = PlaneeViewModel()

    var body: some Scene {
        WindowGroup {
            TelaInicial()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
