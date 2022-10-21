//
//  ContentView.swift
//  Teste SwiftUI
//
//  Created by Lucca Lopes on 19/08/22.
//

import SwiftUI

struct TelaMeusOrcamentos: View {
    
    @ObservedObject var vm: PlaneeViewModel
    
    @State var editando = false
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        List {
            ForEach(vm.orcamentos) { orcamento in
                if editando {
                    HStack {
                        Text(orcamento.nome ?? "Novo Orçamento")
                        Spacer()
                        Text("R$ " + String(format: "%.2f", orcamento.valorTotal))
                    }
                }
                else {
                    NavigationLink {
                        TelaOrcamento(vm: vm, entidade: orcamento)
                    }
                label: {
                    Text(orcamento.nome ?? "Novo Orçamento")
                        .lineLimit(1)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(colorScheme == .dark ? Color.white : vm.corLight[4])
                    Text("R$ " + String(format: "%.2f", locale: Locale(identifier: "br"), orcamento.valorTotal))
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .foregroundColor(colorScheme == .dark ? Color.white : vm.corLight[4])
                }
                .listRowBackground(colorScheme == .dark ? vm.corDark[3] : Color.white)
                .listRowSeparatorTint(colorScheme == .dark ? vm.corDark[4] : vm.corLight[2])
                }
            }
            .onDelete(perform: vm.deletarOrcamento)
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                EditButton()
            }
            ToolbarItem {
                NavigationLink {
                    TelaCriarOrcamento(vm: vm)
                }
            label: {
                Label("Adicionar Orçamento", systemImage: "plus")
            }
            }
        }
        .navigationTitle("Meus Orçamentos")
        .navigationBarTitleDisplayMode(.large)
        .background(colorScheme == .dark ? Color.black : vm.corLight[3])
        .onAppear{
            UITableView.appearance().backgroundColor = .clear
        }
    }
}
