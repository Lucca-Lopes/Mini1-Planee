//
//  TelaInicialView.swift
//  Teste SwiftUI
//
//  Created by Guilherme Lozano Borges on 01/09/22.
//
import CoreData
import SwiftUI

struct TelaInicialView: View {
    
    let screenWidth = UIScreen.main.bounds.size.width
    let screenHeight = UIScreen.main.bounds.size.height
    let utilitarios = Utilitarios()
    
    @State private var rowHeight: CGFloat = 40
    @State private var headerHeight: CGFloat = 60
    
    var body: some View {
        NavigationView{
            VStack {
//                Text("")
//                    .frame(width: screenWidth * 0.99, height: screenHeight * 0.01, alignment: .leading)
                
                Text("Valor da hora de trabalho:")
                    .bold()
                .padding()
                .frame(width: screenWidth * 0.99, height: screenHeight * 0.05, alignment: .leading)

                Text("R$ 20,13")
                    .bold()
                    .font(.system(size: 20))
                .frame(width: screenWidth * 0.9, height: screenHeight * 0.0, alignment: .leading)
                
                Text("")
                    .frame(height: screenHeight * 0.05)
                
                Form{
                    
                    Section{
                        utilitarios.criaNLHome(titulo: "Criar orçamento")
//                        utilitarios.criaNavigationLink(destino:"Criar orçamento")
//                        utilitarios.criaNavigationLink(textoPrincipal: "Criar orçamento", textoSecundario: "", destino: "Criar orçamento")
                    }
                    
                    Section{
                        utilitarios.criaNLHome(titulo: "Meus orçamentos")
//                        utilitarios.criaNavigationLink(destino: "Meus orçamentos")
//                        utilitarios.criaNavigationLink(textoPrincipal: "Meus orçamentos", textoSecundario: "", destino: "Meus orçamentos")
                    }
                    
                    Section{
                        utilitarios.criaNLHome(titulo: "Calcular valor da hora")
//                        utilitarios.criaNavigationLink(destino: "Calcular valor da hora")
//                        utilitarios.criaNavigationLink(textoPrincipal: "Calcular valor da hora", textoSecundario: "", destino: "Calcular valor da hora")
                    }
                    
                    Section{
                        utilitarios.criaNLHome(titulo: "Despesas")
//                        utilitarios.criaNavigationLink(destino: "Despesas")
//                        utilitarios.criaNavigationLink(textoPrincipal: "Despesas", textoSecundario: "", destino: "Despesas")
                    }
                    
                    Section{
                        utilitarios.criaNLHome(titulo: "Gastos")
//                        utilitarios.criaNavigationLink(destino: "Gastos")
//                        utilitarios.criaNavigationLink(textoPrincipal: "Gastos", textoSecundario: "", destino: "Gastos")
                    }
                }
                .cornerRadius(40)
                .ignoresSafeArea()
            }
            .navigationTitle("Nome do app")
        }
        
    }
}
//    func criaBotao(titulo: String) -> some View{
//        let destino = NavigationLink {
//            switch titulo{
//            case "Criar orçamento":
//                ContentView()
//
//            case "Meus orçamentos":
//                ContentView()
//
//            case "Calcular o valor da hora":
//                ContentView()
//
//            case "Despesas":
//                ContentView()
//
//            case "Gastos":
//                ContentView()
//
//            default:
//                ContentView()
//            }
//        }
//        label: {
//            Text(titulo)
//                .foregroundColor(.black)
//                .bold()
//                .font(.system(size: 22))
//                .frame(height: 55)
////            .padding()
//        }
//        return destino
//    }
//}
//
