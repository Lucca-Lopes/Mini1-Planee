//
//  tela-criar-orcamento.swift
//  Teste SwiftUI
//
//  Created by Lucca Lopes on 01/09/22.
//

import SwiftUI
import CoreData

struct TelaCriarOrcamento: View {
    
    @ObservedObject var vm: PlaneeViewModel
    
    let screenWidth = UIScreen.main.bounds.size.width
    let screenHeight = UIScreen.main.bounds.size.height
    
    @State var hora: String = ""
    @State var minuto: Int = 0
    @State var titulo: String = ""
    
    let utilitarios = Utilitarios()
    
    var body: some View {
        List{
            TextField("Titulo", text: $titulo)
            
            Section(header: Text("Custos")
            ) {
                NavigationLink {
                    TelaGastos(vm: vm)
               }
               label: {
                   Text("Gastos")
                   Spacer()
                   Text("R$ 1.250,00")
                       .foregroundColor(.gray)
               }
                NavigationLink {
                     TelaGastos(vm: vm)
                }
                label: {
                    Text("Despesas")
                    Spacer()
                    Text("R$ 980,00")
                        .foregroundColor(.gray)
                }
//                utilitarios.criaNavigationLink(textoPrincipal: "Gastos", textoSecundario: "R$ 1.250,00", destino: "tela_criar_orcamento")
//                utilitarios.criaNavigationLink(textoPrincipal: "Despesas", textoSecundario: "R$ 980,00", destino: "tela_criar_orcamento")
            }
            
            Section(header: Text("Mão de obra")
            ) {
                NavigationLink {
                     TelaValorHdT(vm: vm)
                }
                label: {
                    Text("Despesas")
                    Spacer()
                    Text("R$ 980,00")
                        .foregroundColor(.gray)
                }
                HStack {
                    Text("Despesas")
                    Spacer()
                    Text("R$ 980,00")
                }
//                utilitarios.criaNavigationLink(textoPrincipal: "Valor da hora de trabalho", textoSecundario: "R$ 20,00", destino: "tela_criar_orcamento")
//                utilitarios.criaNavigationLink(textoPrincipal: "Custos por hora", textoSecundario: "R$ 16,00", destino: "tela_criar_orcamento")
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
        }
        .toolbar{
            ToolbarItem(placement: .navigationBarTrailing)
            {
                Button{
                    print("Adicionou")
                    
                }label:{
                    Text("Adicionar")
                }
            }
        }
        .navigationBarTitle("Novo orçamento")
        .navigationBarTitleDisplayMode(.inline)
        //            .fixedSize()
        //            .frame(width: screenWidth, height: screenHeight, alignment: .center)
        //        }
    }
}

//struct tela_criar_orcamento_Previews: PreviewProvider {
//    static var previews: some View {
//        TelaCriarOrcamento()
//        
//    }
//}
