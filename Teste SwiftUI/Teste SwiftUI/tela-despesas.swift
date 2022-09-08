//
//  tela-despesas.swift
//  Teste SwiftUI
//
//  Created by Lucca Lopes on 08/09/22.
//

import SwiftUI

struct tela_despesas: View {
    var body: some View {
        NavigationView{
            List {
                Text("Luz")
            }
            .navigationTitle("Despesas")
        }
    }
}

struct tela_despesas_Previews: PreviewProvider {
    static var previews: some View {
        tela_despesas()
    }
}
