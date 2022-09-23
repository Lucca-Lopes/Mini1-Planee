//
//  TelaInicialView.swift
//  Teste SwiftUI
//
//  Created by Guilherme Lozano Borges on 01/09/22.
//
import CoreData
import SwiftUI

struct TelaInicial: View {
    
    @StateObject var vm = PlaneeViewModel()
    
    let screenWidth = UIScreen.main.bounds.size.width
    let screenHeight = UIScreen.main.bounds.size.height
    
    @Environment(\.managedObjectContext) private var viewContext
    
    let utilitarios = Utilitarios()
    
    @State private var rowHeight: CGFloat = 40
    @State private var headerHeight: CGFloat = 60
    
    var body: some View {
        NavigationView{
            VStack {
                Text("Valor da hora de trabalho:")
                    .bold()
                    .padding()
                    .frame(width: screenWidth * 0.99, height: screenHeight * 0.05, alignment: .leading)
                
                Text("R$ " + String(format: "%.2f", vm.valorDaHora[0].valorFinal))
                    .bold()
                    .font(.system(size: 20))
                    .frame(width: screenWidth * 0.9, height: screenHeight * 0.0, alignment: .leading)
                
                Text("")
                    .frame(height: screenHeight * 0.05)
                
                Form{
                    
                    Section{
//                        utilitarios.criaNLHome(titulo: "Criar orçamento", vm: &vm)
                        NavigationLink {
                            TelaCriarOrcamento(vm: vm, entidade: vm.addOrcamento())
                        }
                        label: {
                            Text("Criar orçamento")
                                .foregroundColor(.black)
                                .bold()
                                .font(.system(size: 22))
                                .frame(height: 55)
                        }
                    }
                    
                    Section{
                        NavigationLink {
                            TelaMeusOrcamentos(vm: vm)
                        }
                        label: {
                            Text("Meus orçamentos")
                                .foregroundColor(.black)
                                .bold()
                                .font(.system(size: 22))
                                .frame(height: 55)
                        }
//                        utilitarios.criaNLHome(titulo: "Meus orçamentos", vm: &vm)
                    }
                    
                    Section{
                        NavigationLink {
                            TelaValorHdT(vm: vm, valor: vm.valorDaHora[0].pretensaoSalarial, dias: Int(vm.valorDaHora[0].dias), horasDiarias: Int(vm.valorDaHora[0].horas))
                        }
                        label: {
                            Text("Calcular valor da hora")
                                .foregroundColor(.black)
                                .bold()
                                .font(.system(size: 22))
                                .frame(height: 55)
                        }
//                        utilitarios.criaNLHome(titulo: "Calcular valor da hora", vm: &vm)
                    }
                    
                    Section{
                        NavigationLink {
                            TelaDespesas(vm: vm)
                        }
                        label: {
                            Text("Despesas")
                                .foregroundColor(.black)
                                .bold()
                                .font(.system(size: 22))
                                .frame(height: 55)
                        }
//                        utilitarios.criaNLHome(titulo: "Despesas", vm: &vm)
                    }
                    
                    Section{
                        NavigationLink {
                            TelaGastos(vm: vm)
                        }
                        label: {
                            Text("Gastos")
                                .foregroundColor(.black)
                                .bold()
                                .font(.system(size: 22))
                                .frame(height: 55)
                        }
//                        utilitarios.criaNLHome(titulo: "Gastos", vm: &vm)
                    }
                }
                .cornerRadius(40)
                .ignoresSafeArea()
            }
            .navigationBarTitleDisplayMode(.large)
            .navigationTitle("Planee")
        }
    }
}
