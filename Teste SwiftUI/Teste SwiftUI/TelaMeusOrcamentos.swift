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
                        .frame(width: .infinity, alignment: .leading)
                    Text("R$ " + String(format: "%.2f", locale: Locale(identifier: "br"), orcamento.valorTotal))
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
                }
            }
            .onDelete(perform: vm.DeletarOrcamento)
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
        .navigationTitle("Meus orçamentos")
        .navigationBarTitleDisplayMode(.large)
    }
}
