//
//  ItemDespesaSelecionada.swift
//  Teste SwiftUI
//
//  Created by Lucca Lopes on 22/09/22.
//

//import SwiftUI
//
//struct ItemDespesaSelecionada: View {
//
//    @State var selecionado: Bool
//    @State var vm: PlaneeViewModel
//    @State var entidade: Despesa
//
//
//    var body: some View {
//        HStack {
//            Toggle("", isOn: $entidade.selecionada)
////                .onTapGesture(perform: selecionarDespesa)
//            Text(entidade.nome ?? "")
//                .lineLimit(1)
//            Spacer()
//            Text("R$ " + String(format: "%.2f", entidade.valor))
//                .foregroundColor(.gray)
//        }
//    }
//
//    func selecionarDespesa(){
//        entidade.selecionada = selecionado
//        vm.salvar()
//    }
//
//
//}
//    func ManipularDespesasSelecionadas() {
//        if selecionado{
//            despesasSelecionadas.append(entidade)
//        }
//        else {
//            for i in 0...despesasSelecionadas.count {
//                if despesasSelecionadas[i] == entidade {
//                    despesasSelecionadas.remove(at: i)
//                    return
//                }
//            }
//        }
//    }
//}

//struct ItemDespesaSelecionada_Previews: PreviewProvider {
//    static var previews: some View {
//        ItemDespesaSelecionada()
//    }
//}
