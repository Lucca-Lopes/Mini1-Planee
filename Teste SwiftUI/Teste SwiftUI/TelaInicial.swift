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
            //Use this if NavigationBarTitle is with Large Font
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(red: 0.133, green: 0.472, blue: 0.692, alpha: 1)]

            //Use this if NavigationBarTitle is with displayMode = .inline
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(red: 0.133, green: 0.472, blue: 0.692, alpha: 1)]
        }
    
    var body: some View {
        NavigationView{
            VStack {
                Text("Valor da hora de trabalho:")
                    .bold()
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("R$ " + String(format: "%.2f", locale: Locale(identifier: "br"), vm.valorDaHora[0].valorFinal))
                    .bold()
                    .font(.system(size: 20))
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
//                Color(colorScheme == .dark ? Color(red: 0, green: 43, blue: 70, opacity: 1) : Color(red: 48, green: 130, blue: 183, opacity: 0.25))
                Form{

                    Section{
                        HStack {
                            Text("Criar Orçamento")
                                .bold()
                                .font(.system(size: 22))
                                .padding(.vertical)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 15)
                                .foregroundColor(.white) //Apply color for arrow only
                        }
                        .background(
                            NavigationLink(destination: TelaCriarOrcamento(vm: vm)) {}
                                .opacity(0)
                        )
                    }
                    .listRowBackground(colorScheme == .dark ? Color(red: 0, green: 0.332, blue: 0.546, opacity: 0.84) : Color(red: 0.188, green: 0.51, blue: 0.718, opacity: 0.84))

                    Section{
                        HStack {
                            Text("Meus orçamentos")
                                .bold()
                                .font(.system(size: 22))
                                .padding(.vertical)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 15)
                                .foregroundColor(.white) //Apply color for arrow only
                        }
                        .background(
                            NavigationLink(destination: TelaMeusOrcamentos(vm: vm)) {}
                                .opacity(0)
                        )
                    }
                    .listRowBackground(colorScheme == .dark ? Color(red: 0, green: 0.332, blue: 0.546, opacity: 0.84) : Color(red: 0.188, green: 0.51, blue: 0.718, opacity: 0.84))

                    Section{
                        HStack {
                            Text("Calcular hora de trabalho")
                                .bold()
                                .font(.system(size: 22))
                                .padding(.vertical)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 15)
                                .foregroundColor(.white) //Apply color for arrow only
                        }
                        .background(
                            NavigationLink(destination: TelaValorHdT(vm: vm, valor: vm.valorDaHora[0].pretensaoSalarial, dias: Int(vm.valorDaHora[0].dias), horasDiarias: Int(vm.valorDaHora[0].horas))) {}
                                .opacity(0)
                        )
                    }
                    .listRowBackground(colorScheme == .dark ? Color(red: 0, green: 0.332, blue: 0.546, opacity: 0.84) : Color(red: 0.188, green: 0.51, blue: 0.718, opacity: 0.84))

                    Section{
                        HStack {
                            Text("Despesas")
                                .bold()
                                .font(.system(size: 22))
                                .padding(.vertical)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 15)
                                .foregroundColor(.white) //Apply color for arrow only
                        }
                        .background(
                            NavigationLink(destination: TelaDespesas(vm: vm)) {}
                                .opacity(0)
                        )
                    }
                    .listRowBackground(colorScheme == .dark ? Color(red: 0, green: 0.332, blue: 0.546, opacity: 0.84) : Color(red: 0.188, green: 0.51, blue: 0.718, opacity: 0.84))

                    Section{
                        HStack {
                            Text("Gastos")
                                .bold()
                                .font(.system(size: 22))
                                .padding(.vertical)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 15)
                                .foregroundColor(.white) //Apply color for arrow only
                        }
                        .background(
                            NavigationLink(destination: TelaGastos(vm: vm)) {}
                                .opacity(0)
                        )
                    }
                    .listRowBackground(colorScheme == .dark ? Color(red: 0, green: 0.332, blue: 0.546, opacity: 0.84) : Color(red: 0.188, green: 0.51, blue: 0.718, opacity: 0.84))
                }
                .foregroundColor(colorScheme == .dark ? Color.white : Color.white)
                .background(colorScheme == .dark ? Color(red: 0, green: 0.167, blue: 0.275, opacity: 1) : Color(red: 0.188, green: 0.51, blue: 0.718, opacity: 0.25))
                .onAppear{
                    UITableView.appearance().backgroundColor = .clear
                }
                .cornerRadius(40)
                .ignoresSafeArea()
            }
            .foregroundColor(Color(red: 0.133, green: 0.472, blue: 0.692, opacity: 1))
            .navigationBarTitleDisplayMode(.large)
            .navigationTitle("Planee")
        }.navigationViewStyle(.stack)
    }
}
