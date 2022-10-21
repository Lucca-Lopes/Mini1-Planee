//
//  TelaInicialView.swift
//  Teste SwiftUI
//
//  Created by Guilherme Lozano Borges on 01/09/22.

import CoreData
import SwiftUI

struct TelaInicial: View {
    
    @StateObject var vm = PlaneeViewModel()
    
    let utilitarios = Utilitarios()
    
    @State private var rowHeight: CGFloat = 40
    @State private var headerHeight: CGFloat = 60
    
    @Environment(\.colorScheme) var colorScheme
    
    init() {
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(red: 0.133, green: 0.472, blue: 0.692, alpha: 1)]
        
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(red: 0.133, green: 0.472, blue: 0.692, alpha: 1)]
    }
    
    var body: some View {
        NavigationView{
            VStack {
                Text("Valor da hora de trabalho:")
                    .font(.system(.body, design: .rounded))
                    .bold()
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("R$ " + String(format: "%.2f", locale: Locale(identifier: "br"), vm.valorDaHora[0].valorFinal))
//                    .font(.system(size: 20, weight: .regular, design: .rounded))
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Form{
                    Section{
                        HStack {
                            Text("Criar orçamento")
                                .font(.system(size: 22, weight: .bold, design: .rounded))
                                .padding(.vertical)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 15)
                                .foregroundColor(.white)
                        }
                        .background(
                            NavigationLink(destination: TelaCriarOrcamento(vm: vm)) {}
                                .opacity(0)
                        )
                    }
                    .listRowBackground(colorScheme == .dark ? vm.corDark[0] : vm.corLight[0])
                    
                    Section{
                        HStack {
                            Text("Meus orçamentos")
                                .font(.system(size: 22, weight: .bold, design: .rounded))
                                .padding(.vertical)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 15)
                                .foregroundColor(.white)
                        }
                        .background(
                            NavigationLink(destination: TelaMeusOrcamentos(vm: vm)) {}
                                .opacity(0)
                        )
                    }
                    .listRowBackground(colorScheme == .dark ? vm.corDark[0] : vm.corLight[0])
                    
                    Section{
                        HStack {
                            Text("Calcular hora de trabalho")
                                .font(.system(size: 22, weight: .bold, design: .rounded))
                                .padding(.vertical)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 15)
                                .foregroundColor(.white)
                        }
                        .background(
                            NavigationLink(destination: TelaValorHdT(vm: vm, valor: vm.valorDaHora[0].pretensaoSalarial, dias: Int(vm.valorDaHora[0].dias), horasDiarias: Int(vm.valorDaHora[0].horas))) {}
                                .opacity(0)
                        )
                    }
                    .listRowBackground(colorScheme == .dark ? vm.corDark[0] : vm.corLight[0])
                    
                    Section{
                        HStack {
                            Text("Despesas")
                                .font(.system(size: 22, weight: .bold, design: .rounded))
                                .padding(.vertical)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 15)
                                .foregroundColor(.white)
                        }
                        .background(
                            NavigationLink(destination: TelaDespesas(vm: vm)) {}
                                .opacity(0)
                        )
                    }
                    .listRowBackground(colorScheme == .dark ? vm.corDark[0] : vm.corLight[0])
                    
                    Section{
                        HStack {
                            Text("Gastos")
                                .font(.system(size: 22, weight: .bold, design: .rounded))
                                .padding(.vertical)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 15)
                                .foregroundColor(.white)
                        }
                        .background(
                            NavigationLink(destination: TelaGastos(vm: vm)) {}
                                .opacity(0)
                        )
                    }
                    .listRowBackground(colorScheme == .dark ? vm.corDark[0] : vm.corLight[0])
                }
                .foregroundColor(colorScheme == .dark ? Color.white : Color.white)
                .background(colorScheme == .dark ? vm.corDark[1] : vm.corLight[1])
                .onAppear{
                    UITableView.appearance().backgroundColor = .clear
                }
                .cornerRadius(40)
                .ignoresSafeArea()
            }
            .foregroundColor(vm.corLight[2])
            .navigationBarTitleDisplayMode(.large)
            .navigationTitle(Text("Planee"))
        }.navigationViewStyle(.stack)
    }
}
