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
    
    @Environment(\.colorScheme) var colorScheme
    
    let utilitarios = Utilitarios()
    
    var body: some View {
        List{
            ForEach (vm.custosFixos) { custoFixoAtual in
                NavigationLink {
                    EditarGasto(vm: vm, entidade: custoFixoAtual, nome: custoFixoAtual.nome ?? "", valor: custoFixoAtual.valorTotal, vidaUtil: Int(custoFixoAtual.vidaUtil))
                }
                label: {
                    Text(custoFixoAtual.nome ?? "")
                        .font(.system(.body, design: .rounded))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("R$ " + String(format: "%.2f", locale: Locale(identifier: "br"), custoFixoAtual.valorMensal))
                        .font(.system(.body, design: .rounded))
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
                .foregroundColor(colorScheme == .dark ? Color.white : vm.corLight[4])
                .listRowBackground(colorScheme == .dark ? vm.corDark[3] : Color.white)
                .listRowSeparatorTint(colorScheme == .dark ? vm.corDark[4] : vm.corLight[2])
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
                        .font(.system(.body, design: .rounded))
                })
                .sheet(isPresented: $mostrarSheet){
                    CriarGasto(vm: vm)
                }
            }
        }
        .navigationTitle("Custos fixos")
        .navigationBarTitleDisplayMode(.large)
        .background(colorScheme == .dark ? Color.black : vm.corLight[3])
        .onAppear{
            UITableView.appearance().backgroundColor = .clear
        }
    }
}
