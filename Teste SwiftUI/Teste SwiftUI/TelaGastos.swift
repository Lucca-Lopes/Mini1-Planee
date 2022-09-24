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
            ForEach (vm.gastos) { gastoAtual in
                Section(header:
                    NavigationLink {
                        EditarGasto(vm: vm, entidade: gastoAtual)
                    }
                label: {
                    HStack {
                        
                        Text(gastoAtual.nome ?? "Novo gasto")
                            .foregroundColor(.black)
                            .lineLimit(1)
                        Label("", systemImage: "chevron.right")
                            .labelStyle(.iconOnly)
                            .foregroundColor(.black)
                    }
                }) {
                    HStack {
                        Text("Valor total")
                        Spacer()
                        Text("R$ " + String(format: "%.2f", gastoAtual.valor))
                    }
                    HStack {
                        Text("Vida útil")
                        Spacer()
                        Text("\(gastoAtual.vidaUtil) meses")
                    }
                    HStack {
                        Text("Custo mensal")
                        Spacer()
                        Text("R$ " + String(format: "%.2f", gastoAtual.custo))
                    }
                }
            }
            .onDelete(perform: vm.deletarGasto)
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    self.editando.toggle()
                }) {
                    Text(editando ? "Ok" : "Editar")
                }
            }
            ToolbarItem {
                Button(action: {
                    mostrarSheet = true
                }, label: {
                    Label("Add Item", systemImage: "plus")
                })
                .sheet(isPresented: $mostrarSheet){
                    CriarGasto(vm: vm)
                }
            }
        }
        .navigationTitle("Gastos")
        .environment(\.editMode, .constant(self.editando ? EditMode.active : EditMode.inactive))
    }
}

//struct RowGastoEditando: View {
//
//    @ObservedObject var vm: PlaneeViewModel
//    @State var gastoAtual: Gasto
//    var body: some View {
//        List{
//            Section(header:
//                Button {
//                    vm.deletarGasto(indexSet: [0])
//                } label: {
//                    Text("X")
//                    Text(gastoAtual.nome ?? "Novo gasto")
//                        .foregroundColor(.black)
//                        .lineLimit(1)
//                }
//            ){
//                HStack {
//                    Text("Valor total")
//                    Spacer()
//                    Text("R$ " + String(format: "%.2f", gastoAtual.valor))
//                }
//                HStack {
//                    Text("Vida útil")
//                    Spacer()
//                    Text("\(gastoAtual.vidaUtil) meses")
//                }
//                HStack {
//                    Text("Custo mensal")
//                    Spacer()
//                    Text("R$ " + String(format: "%.2f", gastoAtual.custo))
//                }
//            }
//        }
//    }
//
//}



//struct Tela_Gastos_Previews: PreviewProvider {
//    static var previews: some View {
//        TelaGastos(vm: vm)
//    }
//}

