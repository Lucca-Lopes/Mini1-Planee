//
//  tela-despesas.swift
//  Teste SwiftUI
//
//  Created by Lucca Lopes on 08/09/22.
//

import SwiftUI
import CoreData

struct TelaDespesas: View {
    
    let screenWidth = UIScreen.main.bounds.size.width
    let screenHeight = UIScreen.main.bounds.size.height
    
    @State var nome = "Luz"
    @State var valor = 0.0
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(entity: Despesa.entity(), sortDescriptors: [])
    var despesas: FetchedResults<Despesa>

//    let nomes: [String] = ["Luz", "Água", "Gás", "Internet", "Telefone", "Softwares", "Personalizado"]
    
    @State var preco: String = "R$ 82,90"
    @State var nomeSeleionado: String = "Luz"
    
    @State var editando = false
    
    let utilitarios = Utilitarios()
    
    var body: some View {
        List {
            ForEach(despesas) { despesaAtual in
                Item_da_lista_de_despesa(item: despesaAtual, editando: editando, nome: $nome, valor: $valor)
                
//                criaDespesa(editando: editando, nomeAtual: &despesaAtual.nome!, preco: &despesaAtual.valor)
            }
            Section(header: Text("")
            ) {
                HStack {
                    Text("Valor total")
                    Spacer()
                    Text("R$ 464,25")
                        .foregroundColor(.gray)
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    if editando {
                        salvarCD()
                    }
                    self.editando.toggle()
                    
                    
                }) {
                    Text(editando ? "Ok" : "Editar")
                }
            }
            ToolbarItem {
                Button(action: addDespesa) {
                    Label("Add Item", systemImage: "plus")
                }
            }
        }
        .navigationTitle("Despesas")
        .environment(\.editMode, .constant(self.editando ? EditMode.active : EditMode.inactive))
    }
//
//    func criaDespesa(editando: Bool, nomeAtual: inout String, precoAtual: inout Double, despesaAtual: Despesa) -> some View {
//
//        let opcoes: [String] = ["Luz", "Água", "Gás", "Internet", "Telefone", "Softwares", "Personalizado"]
//
//        @Binding var nome: String
//
//
//
////        @Published var preco = preco
//
//        let celula = HStack {
//            let despesa = despesaAtual
//            if !editando {
//                Text(nomeAtual)
//                Spacer()
//                Text("R$ \(precoAtual)")
//                    .foregroundColor(.gray)
//            }
//            else {
//                Picker("Escolha um nome",
//                       selection: $nome) {
//                    ForEach(opcoes, id: \.self) { opcao in
//                        Text(opcao)
//                    }
//                    .foregroundColor(.black)
//                }
//                .pickerStyle(.menu)
//                Spacer()
//                TextField(
//                    "Oi",
//                    value: despesa.valor,
//                    formatter: NumberFormatter()
//
//                )
//
//                .multilineTextAlignment(.trailing)
//                .keyboardType(.numberPad)
//                .textFieldStyle(.roundedBorder)
//                .frame(width: screenWidth * 0.35, height: screenHeight * 0.03, alignment: .leading)
//
//            }
//        }
//        nomeAtual = nome
////        despesaAtual.valor = preco
////        if editando {
////            salvarCD()
////        }
//        return celula
//    }
    
    func salvarCD(){
        do {
            try viewContext.save()
        } catch {
            let error = error as NSError
            fatalError("An error occured: \(error)")
        }
    }

    
    func addDespesa(){
            
        let despesa = Despesa(context: viewContext)
        despesa.valor = 0.0
            
        do {
                    try viewContext.save()
                } catch {
                    let error = error as NSError
                    fatalError("An error occured: \(error)")
                }

        print(despesa)
    }
    
}

struct tela_despesas_Previews: PreviewProvider {
    static var previews: some View {
        TelaDespesas()
    }
}
