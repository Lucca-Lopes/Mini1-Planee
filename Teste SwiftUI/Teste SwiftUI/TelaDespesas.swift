//
//  tela-despesas.swift
//  Teste SwiftUI
//
//  Created by Lucca Lopes on 08/09/22.
//

import SwiftUI

struct TelaDespesas: View {
    
    @ObservedObject var vm: PlaneeViewModel
    
    @State var nome = ""
    @State var valor = 0.0
    @State var valorTotal = 0.0
    @State var mostrarCriarDespesa = false
    
    @State var editando = false
    
    @Environment(\.colorScheme) var colorScheme
    
    let utilitarios = Utilitarios()
    
    var body: some View {
        List {
            ForEach (vm.custosVariaveis) { custoVariavel in
                HStack {
                    Text(custoVariavel.nome ?? "")
                    Spacer()
                    Text("R$ " + String(format: "%.2f", locale: Locale(identifier: "br"), custoVariavel.valor))
                }
                .foregroundColor(colorScheme == .dark ? Color.white : vm.corLight[4])
                .listRowBackground(colorScheme == .dark ? vm.corDark[3] : Color.white)
                .listRowSeparatorTint(colorScheme == .dark ? vm.corDark[4] : vm.corLight[2])
            }
//            .onDelete(perform: vm.DeletarCustoVariavel)
//            if vm.custosVariaveis.count > 0 {
//                Section() {
//                    HStack {
//                        Text("Valor total")
//                        Spacer()
//                        Text("R$ " + String(format: "%.2f", locale: Locale(identifier: "br"), vm.CalcularTotalCustosVariaveis()))
//                    }
//                }
//            }
        }
//        .toolbar {
//            ToolbarItem(placement: .navigationBarTrailing) {
//                EditButton()
//            }
//            ToolbarItem {
//                Button {
//                    mostrarCriarDespesa = true
//                } label: {
//                    Label("Adicionar Custo Variável", systemImage: "plus")
//                }
//                .sheet(isPresented: $mostrarCriarDespesa){
//                    CriarDespesa(vm: vm, nome: "", valor: 0.0)
//                }
//            }
//        }
        .navigationTitle("Custos variáveis")
        .navigationBarTitleDisplayMode(.large)
        .background(colorScheme == .dark ? Color.black : vm.corLight[3])
        .onAppear{
            UITableView.appearance().backgroundColor = .clear
        }
    }
}
