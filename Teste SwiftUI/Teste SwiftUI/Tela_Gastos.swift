//
//  Tela_Gastos.swift
//  Teste SwiftUI
//
//  Created by Guilherme Lozano Borges on 06/09/22.
//

import SwiftUI

struct Tela_Gastos: View {
   
    var body: some View {
        
        NavigationView {
            List{
                Section(header: Text("Computador")
                ) {
                    Utilitarios().criaNavigationLink(textoPrincipal: "Valor total", textoSecundario: "R$ 10.250,00", destino: "tela_criar_orcamento")
                    Utilitarios().criaNavigationLink(textoPrincipal: "Vida útil", textoSecundario: "43 meses", destino: "tela_criar_orcamento")
                    Utilitarios().criaNavigationLink(textoPrincipal: "Custo mensal", textoSecundario: "R$ 238,37", destino: "tela_criar_orcamento")
                }
                
                Section(header: Text("Calculadora")
                ) {
                    Utilitarios().criaNavigationLink(textoPrincipal: "Valor total", textoSecundario: "R$ 150,00", destino: "tela_criar_orcamento")
                    Utilitarios().criaNavigationLink(textoPrincipal: "Vida útil", textoSecundario: "80 meses", destino: "tela_criar_orcamento")
                    Utilitarios().criaNavigationLink(textoPrincipal: "Custo mensal", textoSecundario: "R$ 1,86", destino: "tela_criar_orcamento")
                   
                }
                Section(header: Text("")
                ) {
                    Utilitarios().criaNavigationLink(textoPrincipal: "Valor total", textoSecundario: "R$ 240,73", destino: "tela_criar_orcamento")
                }
            }
            .navigationTitle("Gastos")
        }
    }
}

    

struct Tela_Gastos_Previews: PreviewProvider {
    static var previews: some View {
        Tela_Gastos()
    }
}
