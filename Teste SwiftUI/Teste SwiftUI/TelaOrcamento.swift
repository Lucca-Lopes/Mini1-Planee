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
        
    var entidade: Orcamento
    
    let utilitarios = Utilitarios()
    
    var body: some View {
        List{
            HStack {
                Text("Nome do cliente")
                Spacer()
                Text(entidade.nomeDoCliente!)
            }
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
                }
                HStack {
                    Text("Custos por hora")
                    Spacer()
                    Text("R$ " + String(format: "%.2f", vm.orcamentos.last!.custoTotal))
                }
            }
            Section() {
                HStack {
                    Text("Lucro")
                    Spacer()
                    Text("\(vm.orcamentos.last!.lucro)%")
                }
            }
            HStack {
                Text("Valor total")
                Spacer()
                Text("R$ " + String(format: "%.2f", vm.orcamentos.last!.valorTotal))
                    .bold()
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
                NavigationLink {
                    TelaCriarOrcamento(vm: vm)
                } label: {
                    Text("Editar")
                }
//                Button{
//                    TelaCriarOrcamento(vm: vm)
//                }label:{
//                    Text("Editar")
//                }
            }
        }
        
        //            .fixedSize()
        //            .frame(width: screenWidth, height: screenHeight, alignment: .center)
        //        }
    }
}
