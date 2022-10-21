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
    
    let utilitarios = Utilitarios()
    
    var body: some View {
        List {
            ForEach (vm.custosVariaveis) { custoVariavel in
                HStack {
                    Text(custoVariavel.nome ?? "")
                    Spacer()
                    Text("R$ " + String(format: "%.2f", locale: Locale(identifier: "br"), custoVariavel.valor))
                }
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
    }
}
