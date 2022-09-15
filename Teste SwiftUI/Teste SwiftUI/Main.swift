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
//            TelaInicialView()
            Tela_exportar_pdf()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
