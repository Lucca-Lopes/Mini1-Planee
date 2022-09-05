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
    
    @State var hora: Int = 1
    @State var minuto: Int = 0
    
    var body: some View {
        NavigationView {
            List{
                Section(header: Text("Custos")
                ) {
//                    NavigationLink {
//                        Text("Gastos")
//                    }
//                    label: {
//                        Text("Gastos")
//                            .lineLimit(1)
//                        Spacer()
//                        Text("R$ 1250,00")
//                            .foregroundColor(.gray)
//                    }
                    Utilitarios().criaNavigationLink(textoPrincipal: "Gastos", textoSecundario: "R$ 1.250,00", destino: "tela_criar_orcamento")
                    Utilitarios().criaNavigationLink(textoPrincipal: "Despesas", textoSecundario: "R$ 980,00", destino: "tela_criar_orcamento")
                }
                
                Section(header: Text("Mão de obra")
                ) {
                    Utilitarios().criaNavigationLink(textoPrincipal: "Valor da hora de trabalho", textoSecundario: "R$ 20,00", destino: "tela_criar_orcamento")
                    Utilitarios().criaNavigationLink(textoPrincipal: "Custos por hora", textoSecundario: "R$ 16,00", destino: "tela_criar_orcamento")
                    HStack {
//                        Text("Tempo de trabalho")
//                        Spacer()
                        NavigationLink {
                            Picker("Tempo de trabalho", selection: $hora) {
                                ForEach(1..<101) {
                                    Text("\($0) horas")
                                }
                            }.pickerStyle(WheelPickerStyle())
                        }
                        label: {
                            Text("Tempo de trabalho")
                //                .lineLimit(1)
//                            Spacer()
                //                .padding()
                            
                        }
//                        }
                        
//                        }
                            
//                    }
                }
                
            }
            .navigationTitle("Novo orçamento")
        }
        
//        Text("Tela")
//            .position(x: screenWidth * 0.5, y: screenHeight * 0.5)
//            .frame(width: screenWidth / 2, height: screenHeight * 0.5)
    }
}

struct tela_criar_orcamento_Previews: PreviewProvider {
    static var previews: some View {
        tela_criar_orcamento()
        
    }
}
}
