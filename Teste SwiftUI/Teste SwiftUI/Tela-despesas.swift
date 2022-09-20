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
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(entity: Despesa.entity(), sortDescriptors: [])
    var despesa: FetchedResults<Despesa>

    let nomes: [String] = ["Luz", "Água", "Gás", "Internet", "Telefone", "Softwares", "Personalizado"]
    
    @State var preco: String = "R$ 82,90"
    @State var nomeSeleionado: String = "Luz"
    
    @State var editando = false
    
    let utilitarios = Utilitarios()
    
    var body: some View {
        List {
            ForEach(despesa) { despesa in
                utilitarios.criaDespesa(editando: editando)
            }

            Section(header: Text("")
                .accessibilityHidden(true)
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
                    self.editando.toggle()
                    
                }) {
                    Text(editando ? "Ok" : "Editar")
                }
            }
            ToolbarItem {
                Button(action: printar) {
                    Label("Add Item", systemImage: "plus")
                }
                .accessibilityElement(children: .ignore)
                .accessibilityLabel("Botão adicionar")
            }
        }
        .navigationTitle("Despesas")
        .environment(\.editMode, .constant(self.editando ? EditMode.active : EditMode.inactive))
    }
}

func printar(){
    print("Adicionou")
}

struct tela_despesas_Previews: PreviewProvider {
    static var previews: some View {
        TelaDespesas()
    }
}
