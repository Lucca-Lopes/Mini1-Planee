//
//  Tela_Gastos.swift
//  Teste SwiftUI
//
//  Created by Guilherme Lozano Borges on 06/09/22.
//

import SwiftUI

struct Tela_Gastos: View {
    
    @State var editando = false
    @State var mostrarSheet = false
    
    
    
    @Environment(\.managedObjectContext) private var viewContext
   
    var body: some View {
        
        NavigationView {
            List{
                Section(header: Text("Computador")
                ) {
                    Utilitarios().criaNavigationLink(textoPrincipal: "Valor total", textoSecundario: "R$ 10.250,00", destino: "tela_criar_orcamento")
                    Utilitarios().criaNavigationLink(textoPrincipal: "Vida útil", textoSecundario: "43 meses", destino: "tela_criar_orcamento")
                    Utilitarios().criaNavigationLink(textoPrincipal: "Custo mensal", textoSecundario: "R$ 238,37", destino: "tela_criar_orcamento")
                }
                
                Section(header: Text("Calculadora")
                ) {
                    Utilitarios().criaNavigationLink(textoPrincipal: "Valor total", textoSecundario: "R$ 150,00", destino: "tela_criar_orcamento")
                    Utilitarios().criaNavigationLink(textoPrincipal: "Vida útil", textoSecundario: "80 meses", destino: "tela_criar_orcamento")
                    Utilitarios().criaNavigationLink(textoPrincipal: "Custo mensal", textoSecundario: "R$ 1,86", destino: "tela_criar_orcamento")
                   
                }
                Section(header: Text("")
                ) {
                    Utilitarios().criaNavigationLink(textoPrincipal: "Valor total", textoSecundario: "R$ 240,73", destino: "tela_criar_orcamento")
                    
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
                                Button(action: {
                                    mostrarSheet = true
                                }, label: {
                                    Label("Add Item", systemImage: "plus")
                                })
                                .sheet(isPresented: $mostrarSheet){
                                    SheetView()
                                }
                            }
                        }
            .navigationTitle("Gastos")
            .environment(\.editMode, .constant(self.editando ? EditMode.active : EditMode.inactive))
        }
    }
    
    struct SheetView: View {
        
        @State var editando = false
        @State var mostrarTelaGastos = Tela_Gastos()
        
        
        let screenWidth = UIScreen.main.bounds.size.width
        let screenHeight = UIScreen.main.bounds.size.height
        
        @Environment(\.presentationMode) var mode: Binding<PresentationMode>
        
        
        var body: some View{
            
            NavigationView{
                
            List{
                Section() {
                    HStack{
                    Text("Título")
                    Spacer()
                    Text("Cadeira")
                        .foregroundColor(.gray)
                    }
                    HStack{
                        Text("Valor total")
                        Spacer()
                        Text("R$ 720,00")
                            .foregroundColor(.gray)
                    }
                    HStack{
                        Text("Vida útil")
                        Spacer()
                        Text("75 meses")
                            .foregroundColor(.gray)
                    }
                        
                }
                .multilineTextAlignment(.trailing)
            }
            .listStyle(.grouped)
            .toolbar{
                ToolbarItem(placement: .principal){
                    Text("Adiconar gasto")
                        .bold()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        self.mode.wrappedValue.dismiss()
                    }, label: {
                        Text("OK")
                    })
                }
            }
            .frame(width: screenWidth, height: screenHeight * 0.85, alignment: .center)
        }
      }
    }
}

struct Tela_Gastos_Previews: PreviewProvider {
    static var previews: some View {
        Tela_Gastos()
    }
}
