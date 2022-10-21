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
    
    @State var mostrarSheetCP = false
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        List{
            HStack {
                Text("Nome do cliente")
                Spacer()
                Text(entidade.nomeDoCliente!)
            }
            .listRowBackground(colorScheme == .dark ? vm.corDark[3] : Color.white)
            .foregroundColor(colorScheme == .dark ? Color.white : vm.corLight[4])
            
            Section(header: Text("Custos")
                .bold()
                .foregroundColor(colorScheme == .dark ? vm.corDark[2] : vm.corLight[2])
            ) {
                HStack {
                   Text("Gastos")
                    Spacer()
                   Text("R$ " + String(format: "%.2f", locale: Locale(identifier: "br"), entidade.custoTotalGastos))
               }
                HStack {
                    Text("Despesas")
                    Spacer()
                    Text("R$ " + String(format: "%.2f", locale: Locale(identifier: "br"), entidade.custoTotalDespesas))
                }
            }
            .listRowBackground(colorScheme == .dark ? vm.corDark[3] : Color.white)
            .listRowSeparatorTint(colorScheme == .dark ? vm.corDark[4] : vm.corLight[2])
            .foregroundColor(colorScheme == .dark ? Color.white : vm.corLight[4])
            
            Section(header: Text("Mão de obra")
                .bold()
                .foregroundColor(colorScheme == .dark ? vm.corDark[2] : vm.corLight[2])
            ) {
                HStack {
                    Text("Hora de trabalho")
                    Spacer()
                    Text("R$ " + String(format: "%.2f", locale: Locale(identifier: "br"), entidade.valorDaHora!.valorFinal))
                }
                HStack {
                    Text("Custos por hora")
                    Spacer()
                    Text("R$ " + String(format: "%.2f", locale: Locale(identifier: "br"), entidade.custoHora))
                }
                HStack {
                    Text("Tempo de trabalho")
                    Spacer()
                    Text("\(entidade.horasDeTrabalho) horas")
                }
                HStack {
                    Text("Custo Total")
                        .bold()
                    Spacer()
                    Text("R$ " + String(format: "%.2f", locale: Locale(identifier: "br"), entidade.custoTotal))
                        .bold()
                }
            }
            .listRowBackground(colorScheme == .dark ? vm.corDark[3] : Color.white)
            .listRowSeparatorTint(colorScheme == .dark ? vm.corDark[4] : vm.corLight[2])
            .foregroundColor(colorScheme == .dark ? Color.white : vm.corLight[4])
            
            Section() {
                HStack {
                    Text("Lucro")
                    Spacer()
                    Text("\(entidade.lucro)%")
                }
            }
            .listRowBackground(colorScheme == .dark ? vm.corDark[3] : Color.white)
            .foregroundColor(colorScheme == .dark ? Color.white : vm.corLight[4])
            
            HStack {
                Text("Valor total")
                    .bold()
                Spacer()
                Text("R$ " + String(format: "%.2f", locale: Locale(identifier: "br"), entidade.valorTotal))
                    .bold()
            }
            .listRowBackground(colorScheme == .dark ? vm.corDark[3] : Color.white)
            .foregroundColor(colorScheme == .dark ? Color.white : vm.corLight[4])
        }
        .toolbar{
            ToolbarItem(placement: .navigationBarTrailing)
            {
                NavigationLink {
                    TelaEditarOrcamento(vm: vm, entidade: entidade, nomeOrcamento: entidade.nome!, nomeCliente: entidade.nomeDoCliente!, hora: Int(entidade.horasDeTrabalho), lucro: Int(entidade.lucro))
                } label: {
                    Text("Editar")
                }
            }
        }
        .navigationTitle(entidade.nome!)
        .navigationBarTitleDisplayMode(.large)
    }
}
