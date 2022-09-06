//
//  tela-criar-orcamento.swift
//  Teste SwiftUI
//
//  Created by Lucca Lopes on 01/09/22.
//

import SwiftUI

struct tela_criar_orcamento: View {
    
    let screenWidth = UIScreen.main.bounds.size.width
    let screenHeight = UIScreen.main.bounds.size.height
    
    @State var hora: String = ""
    @State var minuto: Int = 0
    
    
    var body: some View {
        NavigationView {
            List{
                Section(header: Text("Custos")
                ) {
                    Utilitarios().criaNavigationLink(textoPrincipal: "Gastos", textoSecundario: "R$ 1.250,00", destino: "tela_criar_orcamento")
                    Utilitarios().criaNavigationLink(textoPrincipal: "Despesas", textoSecundario: "R$ 980,00", destino: "tela_criar_orcamento")
                }
                
                Section(header: Text("Mão de obra")
                ) {
                    Utilitarios().criaNavigationLink(textoPrincipal: "Valor da hora de trabalho", textoSecundario: "R$ 20,00", destino: "tela_criar_orcamento")
                    Utilitarios().criaNavigationLink(textoPrincipal: "Custos por hora", textoSecundario: "R$ 16,00", destino: "tela_criar_orcamento")
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
                
                Section(header: Text("")
                ) {
                    Button {
                        print("salvou")
                    } label: {
                        Text("Salvar").bold()
                    }
                        
                    
                    .frame(width: screenWidth * 0.8, height: screenHeight * 0.03, alignment: .center)
                }
                
            }
            .navigationTitle("Novo orçamento")
        }
    }
}

struct tela_criar_orcamento_Previews: PreviewProvider {
    static var previews: some View {
        tela_criar_orcamento()
        
    }
}
