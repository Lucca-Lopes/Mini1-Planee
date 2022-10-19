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

                Form{

                    Section{
                        NavigationLink {
                            TelaCriarOrcamento(vm: vm)
                        }
                        label: {
                            Text("Criar orçamento")
                                .bold()
                                .font(.system(size: 22))
                                .padding(.vertical)
                        }
                    }

                    Section{
                        NavigationLink {
                            TelaMeusOrcamentos(vm: vm)
                        }
                        label: {
                            Text("Meus orçamentos")
                                .bold()
                                .font(.system(size: 22))
                                .padding(.vertical)
                        }
                    }

                    Section{
                        NavigationLink {
                            TelaValorHdT(vm: vm, valor: vm.valorDaHora[0].pretensaoSalarial, dias: Int(vm.valorDaHora[0].dias), horasDiarias: Int(vm.valorDaHora[0].horas))
                        }
                        label: {
                            Text("Calcular hora de trabalho")
                                .bold()
                                .font(.system(size: 22))
                                .padding(.vertical)
                        }
                    }
                    
                    Section{
                        NavigationLink {
                            TelaGastos(vm: vm)
                        }
                        label: {
                            Text("Custos fixos")
                                .bold()
                                .font(.system(size: 22))
                                .padding(.vertical)
                        }
                    }

                    Section{
                        NavigationLink {
                            TelaDespesas(vm: vm)
                        }
                        label: {
                            Text("Custos variáveis")
                                .bold()
                                .font(.system(size: 22))
                                .padding(.vertical)
                        }
                    }
                }
                .cornerRadius(40)
                .ignoresSafeArea()
                
                
            }
            .navigationBarTitleDisplayMode(.large)
            .navigationTitle("Planee")
        }.navigationViewStyle(.stack)
    }
}
