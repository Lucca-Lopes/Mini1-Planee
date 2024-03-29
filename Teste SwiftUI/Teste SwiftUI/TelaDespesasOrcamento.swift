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
//    @State var editando = false
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        List {
            ForEach (vm.custosTemporarios) { custoVariavel in
                NavigationLink {
                    EditarDespesa(vm: vm, entidade: custoVariavel, nome: custoVariavel.nome ?? "", valor: custoVariavel.valor)
                }
                label: {
                    HStack {
                        Text(custoVariavel.nome ?? "")
                            .font(.system(.body, design: .rounded))
                        Spacer()
                        Text("R$ " + String(format: "%.2f", locale: Locale(identifier: "br"), custoVariavel.valor))
                            .font(.system(.body, design: .rounded))
                    }
                }
                .listRowBackground(colorScheme == .dark ? vm.corDark[3] : Color.white)
                .listRowSeparatorTint(colorScheme == .dark ? vm.corDark[4] : vm.corLight[2])
                .foregroundColor(colorScheme == .dark ? Color.white : vm.corLight[4])
            }
            .onDelete(perform: vm.DeletarCustoTemporario)
            if vm.custosTemporarios.count > 0 {
                Section() {
                    HStack {
                        Text("Valor total")
                            .font(.system(.body, design: .rounded))
                        Spacer()
                        Text("R$ " + String(format: "%.2f", locale: Locale(identifier: "br"), vm.CalcularTotalCustosTemporarios()))
                            .font(.system(.body, design: .rounded))
                    }
                }
                .listRowBackground(colorScheme == .dark ? vm.corDark[3] : Color.white)
                .listRowSeparatorTint(colorScheme == .dark ? vm.corDark[4] : vm.corLight[2])
                .foregroundColor(colorScheme == .dark ? Color.white : vm.corLight[4])
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
                        .font(.system(.body, design: .rounded))
                }
                .sheet(isPresented: $mostrarCriarDespesa){
                    CriarDespesa(vm: vm, nome: "", valor: 0.0)
                }
            }
        }
        .navigationTitle("Custos variáveis")
        .navigationBarTitleDisplayMode(.large)
        .background(colorScheme == .dark ? Color.black : vm.corLight[3])
        .onAppear{
            UITableView.appearance().backgroundColor = .clear
        }
    }
}
