//
//  Teste_SwiftUIApp.swift
//  Teste SwiftUI
//
//  Created by Lucca Lopes on 19/08/22.
//

import SwiftUI
import CoreData

@main
struct Main: App {
    let persistenceController = PersistenceController.shared
    
    @StateObject var vm = PlaneeViewModel()

    var body: some Scene {
        WindowGroup {
            TelaInicial()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

class CoreDataManager {
    static let instance = CoreDataManager()
    let container: NSPersistentContainer
    let context: NSManagedObjectContext
    
    init() {
        container = NSPersistentContainer(name: "Teste_SwiftUI")
        container.loadPersistentStores { (description, error) in
            if let error = error {
                print("Erro ao carregar o Core Data. \(error)")
            }
        }
        context = container.viewContext
    }
    
    func salvar() {
        do {
            try context.save()
        } catch let error {
            print("Erro ao salvar o Core Data, \(error.localizedDescription)")
        }
    }
}

class PlaneeViewModel: ObservableObject {
    let manager = CoreDataManager.instance
    
    @Published var orcamentos: [Orcamento] = []
    @Published var despesas: [Despesa] = []
    @Published var gastos: [Gasto] = []
    @Published var valorDaHora: [ValorHoraDeTrabalho] = []
    
    func addOrcamento() {
        let novoOrcamento = Orcamento(context: manager.context)
        novoOrcamento.nome = ""
        novoOrcamento.nomeDoCliente = ""
        novoOrcamento.custoTotalGastos = 0.0
        novoOrcamento.custoTotalDespesas = 0.0
        novoOrcamento.custoHora = 0.0
        novoOrcamento.tempoDeTrabalho = ""
        novoOrcamento.custoTotal = 0.0
        novoOrcamento.lucro = 0
        novoOrcamento.valorTotal = 0.0
        salvar()
    }
    
    func addDespesa() {
        let novaDespesa = Despesa(context: manager.context)
        novaDespesa.nome = ""
        novaDespesa.valor = 0.0
        salvar()
    }
    
    func addGasto() {
        let novoGasto = Gasto(context: manager.context)
        novoGasto.nome = ""
        novoGasto.valor = 0.0
        novoGasto.vidaUtil = 0
        novoGasto.custo = novoGasto.valor / Double(novoGasto.vidaUtil)
        salvar()
    }
    
    func addVdH() {
        let novoVdT = ValorHoraDeTrabalho(context: manager.context)
        novoVdT.pretensaoSalarial = 0.0
        novoVdT.dias = 0
        novoVdT.horas = 0
        novoVdT.valorFinal = (novoVdT.pretensaoSalarial / Double(novoVdT.dias)) / Double(novoVdT.horas)
        salvar()
    }
    
    func atualizarOrcamento(entidade: Orcamento, nome: String, nomeCliente: String, totalGastos: Double, totalDespesas: Double, custoPorHora: Double, tempoDeTrabalho: String, custoTotal: Double, lucro: Int, valorTotal: Double){
        entidade.nome = nome
        entidade.nomeDoCliente = nomeCliente
        entidade.custoTotalGastos = totalGastos
        entidade.custoTotalDespesas = totalDespesas
        entidade.custoHora = custoPorHora
        entidade.tempoDeTrabalho = tempoDeTrabalho
        entidade.custoTotal = custoTotal
        entidade.lucro = Int64(lucro)
        entidade.valorTotal = valorTotal
        salvar()
    }
    
    func atualizarDespesa(entidade: Despesa, nome: String, valor: Double) {
        entidade.nome = nome
        entidade.valor = valor
        salvar()
    }
    
    func atualizarGasto(entidade: Gasto, nome: String, valor: Double, vidaUtil: Int){
        entidade.nome = nome
        entidade.valor = valor
        entidade.vidaUtil = Int64(vidaUtil)
        entidade.custo = entidade.valor / Double(entidade.vidaUtil)
        salvar()
    }
    
    func salvar(){
        manager.salvar()
    }
}
