//
//  tela-despesas.swift
//  Teste SwiftUI
//
//  Created by Lucca Lopes on 08/09/22.
//

import SwiftUI

struct tela_despesas: View {
    
    let screenWidth = UIScreen.main.bounds.size.width
    let screenHeight = UIScreen.main.bounds.size.height
    
    let nomes: [String] = ["Luz", "Água", "Gás", "Internet", "Telefone", "Softwares", "Personalizado"]
    
    @State var preco: String = "R$ 82,90"
    @State var nomeSeleionado: String = "Luz"
    
    @State var editando = false
    
    let utilitarios = Utilitarios()
    
    var body: some View {
        NavigationView {
            List {
                
                utilitarios.criaDespesa(editando: editando)
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
                        self.editando.toggle()
                        
                    }) {
                        Text(editando ? "Ok" : "Editar")
                    }
                }
                ToolbarItem {
                    Button(action: printar) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
            .navigationTitle("Despesas")
            .environment(\.editMode, .constant(self.editando ? EditMode.active : EditMode.inactive))
        }
    }
}

func printar(){
    print("Adicionou")
}

//func criarDespesa() {
//    Utilitarios().criaDespesa(editando: false)
//}

struct tela_despesas_Previews: PreviewProvider {
    static var previews: some View {
        tela_despesas()
    }
}
