//
//  TelaDespesasOrcamento.swift
//  Planee
//
//  Created by Lucca Lopes on 21/10/22.
//

import SwiftUI

struct TelaDespesasOrcamento: View {
    
    @ObservedObject var vm: PlaneeViewModel
    
    @State var nome = ""
    @State var valor = 0.0
    @State var valorTotal = 0.0
    @State var mostrarCriarDespesa = false
    
    @State var editando = false
    
    let utilitarios = Utilitarios()
    
    var body: some View {
        List {
            ForEach (vm.custosVariaveisAtual) { custoVariavel in
                NavigationLink {
                    EditarDespesa(vm: vm, entidade: custoVariavel, nome: custoVariavel.nome ?? "", valor: custoVariavel.valor)
                }
                label: {
                    Text(custoVariavel.nome ?? "")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("R$ " + String(format: "%.2f", locale: Locale(identifier: "br"), custoVariavel.valor))
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
            }
            .onDelete(perform: vm.DeletarCustoVariavel)
            if vm.custosVariaveisAtual.count > 0 {
                Section() {
                    HStack {
                        Text("Valor total")
                        Spacer()
                        Text("R$ " + String(format: "%.2f", locale: Locale(identifier: "br"), vm.CalcularTotalCustosVariaveis()))
                    }
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                EditButton()
            }
            ToolbarItem {
                Button {
                    mostrarCriarDespesa = true
                } label: {
                    Label("Adicionar Custo Variável", systemImage: "plus")
                }
                .sheet(isPresented: $mostrarCriarDespesa){
                    CriarDespesa(vm: vm, nome: "", valor: 0.0)
                }
            }
        }
        .navigationTitle("Custos variáveis")
        .navigationBarTitleDisplayMode(.large)
    }
}
