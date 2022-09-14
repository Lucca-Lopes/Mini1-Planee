//
//  tela-criar-orcamento.swift
//  Teste SwiftUI
//
//  Created by Lucca Lopes on 01/09/22.
//

import SwiftUI

struct TelaOrcamento: View {
    
    let screenWidth = UIScreen.main.bounds.size.width
    let screenHeight = UIScreen.main.bounds.size.height
    
    @State var hora: String = ""
    @State var minuto: Int = 0
    @State var titulo: String = ""
    
    let utilitarios = Utilitarios()
    
    var body: some View {
        List{
            Section(header: Text("Custos")
            ) {
                utilitarios.criaNavigationLink(textoPrincipal: "Gastos", textoSecundario: "R$ 1.250,00", destino: "tela_criar_orcamento")
                utilitarios.criaNavigationLink(textoPrincipal: "Despesas", textoSecundario: "R$ 980,00", destino: "tela_criar_orcamento")
            }
            
            Section(header: Text("Mão de obra")
            ) {
                utilitarios.criaNavigationLink(textoPrincipal: "Valor da hora de trabalho", textoSecundario: "R$ 20,00", destino: "tela_criar_orcamento")
                utilitarios.criaNavigationLink(textoPrincipal: "Custos por hora", textoSecundario: "R$ 16,00", destino: "tela_criar_orcamento")
                HStack {
                    Text("Tempo de trabalho")
                    Spacer()
                    Text("6h 30min")
                        .foregroundColor(.gray)
                }
                HStack {
                    Text("Custo total")
                        .bold()
                    Spacer()
                    Text("R$ 200,00")
                        .bold()
                        .foregroundColor(.gray)
                }
            }
            
            Section(header: Text("")
            ) {
                HStack {
                    Text("Lucro")
                    Spacer()
                    Text("25%")
                }
            }
            
            Section(header: Text("")
            ) {
                HStack {
                    Text("Valor total")
                    Spacer()
                    Text("R$ 2000,00")
                        .bold()
                }
            }
        }
        .navigationTitle("Orçamento 1")
        .navigationBarTitleDisplayMode(.large)
        .toolbar{
            ToolbarItem(placement: .navigationBarTrailing)
            {
                Button{
                    print("Adicionou")
                }label:{
                    Image(systemName: "square.and.arrow.up")
                }
            }
            ToolbarItem(placement: .navigationBarTrailing)
            {
                Button{
                    print("Adicionou")
                }label:{
                    Text("Editar")
                }
            }
        }
        
        //            .fixedSize()
        //            .frame(width: screenWidth, height: screenHeight, alignment: .center)
        //        }
    }
}
