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
//                HStack {
//                    if !editando {
//                        Text(nomeSeleionado)
//                        Spacer()
//                        Text(preco)
//                            .foregroundColor(.gray)
//                    }
//                    else {
//                        Picker("Escolha um nome",
//                               selection: $nomeSeleionado) {
//                            ForEach(nomes, id: \.self) { nome in
//                                Text(nome)
//                            }
//                            .foregroundColor(.black)
//                        }
//                        .pickerStyle(.menu)
//                        Spacer()
//                        TextField(
//                            "Oi",
//                            value: $preco,
//                            formatter: NumberFormatter()
//                        )
//                        .multilineTextAlignment(.trailing)
//                        .keyboardType(.numberPad)
//                        .textFieldStyle(.roundedBorder)
//                        .frame(width: screenWidth * 0.35, height: screenHeight * 0.03, alignment: .leading)
//
//                    }
//                }
                utilitarios.criaDespesa(editando: editando, nomeSelecionado: nomeSeleionado)
//                    Text("Luz")
//                    padding()
//                    Image(systemName: "chevron.right")
                    //criar text, spcer, text nessa ordem, ao clicar em editar o primeiro text vira um picker pra selecionar o nome e o segundo text vira um textfield
//                    NavigationLink {
//                        ContentView()
//                    }
//                    label: {
//                        Text("Luz")
//                        Spacer()
//                        TextField(
//                            "R$ 00,00",
//                            value: $hora,
//                            formatter: NumberFormatter()
//                        )
//                        .multilineTextAlignment(.trailing)
//                            .keyboardType(.numberPad)
//                            .textFieldStyle(.roundedBorder)
//                            .frame(width: screenWidth * 0.35, height: screenHeight * 0.03, alignment: .leading)
//                    }
                    
//                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        self.editando.toggle()
                        
                    }) {
                        Text(editando ? "Ok" : "Editar")
                    }
                }
            }
            .navigationTitle("Despesas")
            .environment(\.editMode, .constant(self.editando ? EditMode.active : EditMode.inactive))
        }
    }
}

struct tela_despesas_Previews: PreviewProvider {
    static var previews: some View {
        tela_despesas()
    }
}
