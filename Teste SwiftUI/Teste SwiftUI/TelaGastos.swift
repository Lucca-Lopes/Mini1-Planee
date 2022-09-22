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
                    SheetView(vm: vm, entidade: gastoAtual)
                }
                        label: {
                    Text(gastoAtual.nome ?? "")
                        .lineLimit(1)
                    
                }
                ) {
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
                    vm.addGasto()
                    mostrarSheet = true
                }, label: {
                    Label("Add Item", systemImage: "plus")
                })
                .sheet(isPresented: $mostrarSheet){
                    SheetView(vm: vm, entidade: vm.gastos.last!)
                }
            }
        }
        .navigationTitle("Gastos")
        .environment(\.editMode, .constant(self.editando ? EditMode.active : EditMode.inactive))
    }
}

//struct Tela_Gastos_Previews: PreviewProvider {
//    static var previews: some View {
//        TelaGastos(vm: vm)
//    }
//}

struct SheetView: View {
    
    @ObservedObject var vm: PlaneeViewModel
    
    @State var editando = false
    @State var nome: String = ""
    @State var valor: Double = 0.0
    @State var vidaUtil: Int = 0
    
    @State var entidade: Gasto
    
    let transition = AnyTransition.asymmetric(insertion: .slide, removal: .scale).combined(with: .opacity)
    
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    
    var body: some View{
        NavigationView{
            List{
                HStack {
                    Text("Título")
                    Spacer()
                    TextField(
                        "Nome",
                        text: $nome
                    )
                    .fixedSize()
                }
                HStack{
                    Text("Valor total")
                    Spacer()
                    TextField(
                        "R$ 0,00",
                        value: $valor,
                        formatter: NumberFormatter()
                    )
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.numberPad)
                    .textFieldStyle(.roundedBorder)
                    .frame(width: vm.screenWidth * 0.35, height: vm.screenHeight * 0.03, alignment: .leading)
                }
                HStack{
                    Text("Vida útil")
                    Spacer()
                    TextField(
                        "R$ 0,00",
                        value: $vidaUtil,
                        formatter: NumberFormatter()
                    )
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.numberPad)
                    .textFieldStyle(.roundedBorder)
                    .frame(width: vm.screenWidth * 0.35, height: vm.screenHeight * 0.03, alignment: .leading)
                }
            }
            .listStyle(.grouped)
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        vm.atualizarGasto(entidade: entidade, nome: nome, valor: valor, vidaUtil: vidaUtil)
                        self.mode.wrappedValue.dismiss()
                    }, label: {
                        Text("OK")
                    })
                }
            }
            .navigationBarTitle("Adicionar gasto")
            .navigationBarTitleDisplayMode(.inline)
            //                .frame(width: screenWidth, height: screenHeight * 0.9, alignment: .center)
        }
    }
}
