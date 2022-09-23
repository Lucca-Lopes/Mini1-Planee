//
//  tela-criar-orcamento.swift
//  Teste SwiftUI
//
//  Created by Lucca Lopes on 01/09/22.
//

import SwiftUI
import CoreData

struct TelaOrcamento: View {
    
    @ObservedObject var vm: PlaneeViewModel
    
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
                NavigationLink {
                    TelaGastos(vm: vm)
               }
               label: {
                   Text("Gastos")
                   Spacer()
                   Text("R$ " + String(format: "%.2f", vm.calcularTotalGastos()))
//                       .foregroundColor(.gray)
               }
                NavigationLink {
                     TelaGastos(vm: vm)
                }
                label: {
                    Text("Despesas")
                    Spacer()
                    Text("R$ " + String(format: "%.2f", vm.calcularTotalDespesa()))
                        .foregroundColor(.gray)
                }
//                utilitarios.criaNavigationLink(textoPrincipal: "Gastos", textoSecundario: "R$ 1.250,00", destino: "tela_criar_orcamento")
//                utilitarios.criaNavigationLink(textoPrincipal: "Despesas", textoSecundario: "R$ 980,00", destino: "tela_criar_orcamento")
            }
            
            Section(header: Text("Mão de obra")
            ) {
                NavigationLink {
                     TelaValorHdT(vm: vm, valor: vm.valorDaHora[0].pretensaoSalarial, dias: Int(vm.valorDaHora[0].dias), horasDiarias: Int(vm.valorDaHora[0].horas))
                }
                label: {
                    Text("Valor hora de trabalho")
                    Spacer()
                    Text("R$ " + String(format: "%.2f", vm.valorDaHora[0].valorFinal))
                        .foregroundColor(.gray)
                }
                HStack {
                    Text("Custos por hora")
                    Spacer()
                    Text("R$ " + String(format: "%.2f", vm.orcamentos.last!.custoTotal))
                }
            }
            Section(header: Text("")
            ) {
                HStack {
                    Text("Lucro")
                    Spacer()
                    Text("\(vm.orcamentos.last!.lucro)%")
                }
            }
            
            Section(header: Text("")
            ) {
                HStack {
                    Text("Valor total")
                    Spacer()
                    Text("R$ " + String(format: "%.2f", vm.orcamentos.last!.valorTotal))
                        .bold()
                }
            }
        }
        .navigationTitle(vm.orcamentos.last!.nome ?? "")
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
