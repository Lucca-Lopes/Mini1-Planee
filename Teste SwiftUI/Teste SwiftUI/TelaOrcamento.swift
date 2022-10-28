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
            Section(header: Text("Criado em \(vm.formatacaoData.string(from: entidade.dataDoOrcamento!))")){
                HStack {
                    Text("Nome do cliente")
                        .font(.system(.body, design: .rounded))
                    Spacer()
                    Text(entidade.nomeDoCliente!)
                        .font(.system(.body, design: .rounded))
                }
                .listRowBackground(colorScheme == .dark ? vm.corDark[3] : Color.white)
                .listRowInsets(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                .foregroundColor(colorScheme == .dark ? Color.white : vm.corLight[4])
            }
            .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
            .textCase(nil)
            
            Section(header: Text("Custos")
                .font(.system(.body, design: .rounded))
                .bold()
                .foregroundColor(colorScheme == .dark ? vm.corDark[2] : vm.corLight[2])
            ) {
                HStack {
                   Text("Custos fixos")
                        .font(.system(.body, design: .rounded))
                    Spacer()
                    Text("R$ " + String(format: "%.2f", locale: Locale(identifier: "br"), entidade.custoTotalGastos))
                        .font(.system(.body, design: .rounded))
                }
                HStack {
                    Text("Custos variáveis")
                        .font(.system(.body, design: .rounded))
                    Spacer()
                    Text("R$ " + String(format: "%.2f", locale: Locale(identifier: "br"), entidade.custoTotalDespesas))
                        .font(.system(.body, design: .rounded))
                }
            }
            .listRowBackground(colorScheme == .dark ? vm.corDark[3] : Color.white)
            .listRowSeparatorTint(colorScheme == .dark ? vm.corDark[4] : vm.corLight[2])
            .foregroundColor(colorScheme == .dark ? Color.white : vm.corLight[4])
            
            Section(header: Text("Mão de obra")
                .font(.system(.body, design: .rounded))
                .bold()
                .foregroundColor(colorScheme == .dark ? vm.corDark[2] : vm.corLight[2])
            ) {
                HStack {
                    Text("Hora de trabalho")
                        .font(.system(.body, design: .rounded))
                    Spacer()
                    Text("R$ " + String(format: "%.2f", locale: Locale(identifier: "br"), entidade.valorDaHora!.valorFinal))
                        .font(.system(.body, design: .rounded))
                }
                HStack {
                    Text("Custos por hora")
                        .font(.system(.body, design: .rounded))
                    Spacer()
                    Text("R$ " + String(format: "%.2f", locale: Locale(identifier: "br"), entidade.custoHora))
                        .font(.system(.body, design: .rounded))
                }
                HStack {
                    Text("Tempo de trabalho")
                        .font(.system(.body, design: .rounded))
                    Spacer()
                    Text("\(entidade.horasDeTrabalho) horas")
                        .font(.system(.body, design: .rounded))
                }
                HStack {
                    Text("Custo Total")
                        .font(.system(.body, design: .rounded))
//                        .bold()
                    Spacer()
                    Text("R$ " + String(format: "%.2f", locale: Locale(identifier: "br"), entidade.custoTotal))
                        .font(.system(.body, design: .rounded))
//                        .bold()
                }
            }
            .listRowBackground(colorScheme == .dark ? vm.corDark[3] : Color.white)
            .listRowSeparatorTint(colorScheme == .dark ? vm.corDark[4] : vm.corLight[2])
            .foregroundColor(colorScheme == .dark ? Color.white : vm.corLight[4])
            
            Section() {
                HStack {
                    Text("Lucro")
                        .font(.system(.body, design: .rounded))
                    Spacer()
                    Text("\(entidade.lucro)%")
                        .font(.system(.body, design: .rounded))
                }
            }
            .listRowBackground(colorScheme == .dark ? vm.corDark[3] : Color.white)
            .foregroundColor(colorScheme == .dark ? Color.white : vm.corLight[4])
            
            HStack {
                Text("Valor total")
                    .font(.system(.body, design: .rounded))
                    .bold()
                Spacer()
                Text("R$ " + String(format: "%.2f", locale: Locale(identifier: "br"), entidade.valorTotal))
                    .font(.system(.body, design: .rounded))
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
                        .font(.system(.body, design: .rounded))
                }
            }
        }
        .navigationTitle(entidade.nome!)
        .navigationBarTitleDisplayMode(.large)
        .background(colorScheme == .dark ? Color.black : vm.corLight[3])
        .onAppear{
            UITableView.appearance().backgroundColor = .clear
        }
    }
}
