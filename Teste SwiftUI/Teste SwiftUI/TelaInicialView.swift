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
                        criaBotao(titulo: "Criar orçamento")
                    }
                    
                    Section{
                      criaBotao(titulo: "Meus orçamentos")
                    }
                    
                    Section{
                        criaBotao(titulo: "Calcular valor da hora")
                    }
                    
                    Section{
                        criaBotao(titulo: "Despesas")
                    }
                    
                    Section{
                        criaBotao(titulo: "Gastos")
                    }
                }
                .cornerRadius(40)
                .ignoresSafeArea()
            }
            .navigationTitle("Nome do app")
        }
        
    }

    func criaBotao(titulo: String) -> some View{
        let destino = NavigationLink {
            switch titulo{
            case "Criar orçamento":
                ContentView()

            case "Meus orçamentos":
                ContentView()

            case "Calcular o valor da hora":
                ContentView()

            case "Despesas":
                ContentView()

            case "Gastos":
                ContentView()

            default:
                ContentView()
            }
        }
        label: {
            Text(titulo)
                .foregroundColor(.black)
                .bold()
                .font(.system(size: 22))
                .frame(height: 55)
//            .padding()
        }
        return destino
    }
}

