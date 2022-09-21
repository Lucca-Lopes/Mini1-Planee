//
//  Teste_SwiftUIApp.swift
//  Teste SwiftUI
//
//  Created by Lucca Lopes on 19/08/22.
//

import SwiftUI

@main
struct Main: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            TelaInicial()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
