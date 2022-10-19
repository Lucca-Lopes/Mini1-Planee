//
//  Tela_Gastos.swift
//  Teste SwiftUI
//
//  Created by Guilherme Lozano Borges on 06/09/22.
//

import SwiftUI

struct TelaGastos: View {
    
    @ObservedObject var vm: PlaneeViewModel
    
    @State var editando = false
    @State var mostrarSheet = false
    
    let utilitarios = Utilitarios()
    
    var body: some View {
        List{
            ForEach (vm.custosFixos) { custoFixoAtual in
                NavigationLink {
                    EditarGasto(vm: vm, entidade: custoFixoAtual, nome: custoFixoAtual.nome ?? "", valor: custoFixoAtual.valorTotal, vidaUtil: Int(custoFixoAtual.vidaUtil))
                }
                label: {
                    Text(custoFixoAtual.nome ?? "")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("R$ " + String(format: "%.2f", locale: Locale(identifier: "br"), custoFixoAtual.valorMensal))
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
            }
            .onDelete(perform: vm.DeletarCustoFixo)
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                EditButton()
            }
            ToolbarItem {
                Button(action: {
                    mostrarSheet = true
                }, label: {
                    Label("Adicionar custo fixo", systemImage: "plus")
                })
                .sheet(isPresented: $mostrarSheet){
                    CriarGasto(vm: vm)
                }
            }
        }
        .navigationTitle("Custos fixos")
        .navigationBarTitleDisplayMode(.large)
    }
}
