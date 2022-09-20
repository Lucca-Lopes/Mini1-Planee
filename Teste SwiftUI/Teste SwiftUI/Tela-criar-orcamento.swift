//
//  tela-criar-orcamento.swift
//  Teste SwiftUI
//
//  Created by Lucca Lopes on 01/09/22.
//

import SwiftUI

struct TelaCriarOrcamento: View {
    
    let screenWidth = UIScreen.main.bounds.size.width
    let screenHeight = UIScreen.main.bounds.size.height
    
    @State var hora: String = ""
    @State var minuto: Int = 0
    @State var titulo: String = ""
    
    let utilitarios = Utilitarios()
    
    var body: some View {
        List{
            TextField("Titulo", text: $titulo)
                .accessibilityElement(children: .ignore)
                .accessibilityLabel("Insira um titulo")
            
            Section(header: Text("Custos")
                .accessibilityRemoveTraits(.isHeader)
                .accessibilityLabel("Seção Custos")
            ) {
                utilitarios.criaNavigationLink(textoPrincipal: "Gastos", textoSecundario: "R$ 1.250,00", destino: "tela_criar_orcamento")
                utilitarios.criaNavigationLink(textoPrincipal: "Despesas", textoSecundario: "R$ 980,00", destino: "tela_criar_orcamento")
            }
            
            Section(header: Text("Mão de obra")
                .accessibilityRemoveTraits(.isHeader)
                .accessibilityLabel("Seção Mão de Obra")
            ) {
                utilitarios.criaNavigationLink(textoPrincipal: "Valor da hora de trabalho", textoSecundario: "R$ 20,00", destino: "tela_criar_orcamento")
                utilitarios.criaNavigationLink(textoPrincipal: "Custos por hora", textoSecundario: "R$ 16,00", destino: "tela_criar_orcamento")
                HStack {
                    Text("Tempo de trabalho")
                    Spacer()
                    TextField(
                        ":",
                        value: $hora,
                        formatter: NumberFormatter()
                    )
                    .multilineTextAlignment(.center)
                    .keyboardType(.numberPad)
                    .textFieldStyle(.roundedBorder)
                    .frame(width: screenWidth * 0.2, height: screenHeight * 0.03, alignment: .trailing)
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
                .accessibilityHidden(true)
            ) {
                HStack {
                    Text("Lucro")
                    Spacer()
                    TextField(
                        "0%",
                        value: $hora,
                        formatter: NumberFormatter()
                    )
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.numberPad)
                    .textFieldStyle(.roundedBorder)
                    .frame(width: screenWidth * 0.2, height: screenHeight * 0.03, alignment: .trailing)
                }
            }
        }
        .toolbar{
            ToolbarItem(placement: .navigationBarTrailing)
            {
                Button{
                    print("Adicionou")
                    
                }label:{
                    Text("Adicionar")
                }
                .accessibilityElement(children: .ignore)
                .accessibilityLabel("Botão Adicionar")
            }
        }
        .navigationBarTitle("Novo orçamento")
        .navigationBarTitleDisplayMode(.inline)
        //            .fixedSize()
        //            .frame(width: screenWidth, height: screenHeight, alignment: .center)
        //        }
    }
}

struct tela_criar_orcamento_Previews: PreviewProvider {
    static var previews: some View {
        TelaCriarOrcamento()
        
    }
}
