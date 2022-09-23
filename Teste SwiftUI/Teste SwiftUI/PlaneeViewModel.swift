//
//  PlaneeViewModel.swift
//  Teste SwiftUI
//
//  Created by Lucca Lopes on 22/09/22.
//

import SwiftUI
import CoreData

class PlaneeViewModel: ObservableObject {
    
    let screenWidth = UIScreen.main.bounds.size.width
    let screenHeight = UIScreen.main.bounds.size.height
    
    let manager = CoreDataManager.instance
    
    @Published var orcamentos: [Orcamento] = []
    @Published var despesas: [Despesa] = []
    @Published var gastos: [Gasto] = []
    @Published var valorDaHora: [ValorHoraDeTrabalho] = []
    
    init() {
        fetchOrcamento()
        fetchDespesa()
        fetchGasto()
        fetchVdH()
//        clearDatabase()
//        salvar()
//        limparCoreData()
        if valorDaHora.count < 1 {
            addVdH()
        }
    }
    
    func addOrcamento() -> Orcamento {
        let novoOrcamento = Orcamento(context: manager.context)
        novoOrcamento.nome = ""
        novoOrcamento.nomeDoCliente = ""
        novoOrcamento.custoTotalGastos = calcularTotalGastos()
        novoOrcamento.custoTotalDespesas = calcularTotalDespesa()
        novoOrcamento.custoHora = 0.0
        novoOrcamento.horasDeTrabalho = 0
        novoOrcamento.custoTotal = 0.0
        novoOrcamento.lucro = 0
        novoOrcamento.valorTotal = 0
        salvar()
        return novoOrcamento
    }
    
    func addDespesa() {
        let novaDespesa = Despesa(context: manager.context)
        novaDespesa.nome = ""
        novaDespesa.valor = 0.0
        novaDespesa.selecionada = false
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
        novoVdT.valorFinal = 0.0
        salvar()
    }
    
    func atualizarOrcamento(entidade: Orcamento, nome: String, nomeCliente: String, totalGastos: Double, totalDespesas: Double, custoPorHora: Double, tempoDeTrabalho: Int, custoTotal: Double, lucro: Int){
        entidade.nome = nome
        entidade.nomeDoCliente = nomeCliente
        entidade.custoTotalGastos = totalGastos
        entidade.custoTotalDespesas = totalDespesas
        entidade.custoHora = custoPorHora
        entidade.horasDeTrabalho = Int64(tempoDeTrabalho)
        entidade.custoTotal = custoTotal
        entidade.lucro = Int64(lucro)
        entidade.valorTotal = (custoTotal + (valorDaHora[0].valorFinal * 10)) * Double(((lucro + 100) / 100))
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
    
    func atualizarVdH(entidade: ValorHoraDeTrabalho, pretensaoSalarial: Double, dias: Int, horas: Int){
        entidade.pretensaoSalarial = pretensaoSalarial
        entidade.dias = Int64(dias)
        entidade.horas = Int64(horas)
        entidade.valorFinal = (entidade.pretensaoSalarial / Double(entidade.dias)) / Double(entidade.horas)
        salvar()
    }
    
    func fetchOrcamento() {
        let request = NSFetchRequest<Orcamento>(entityName: "Orcamento")
        
        do {
            orcamentos = try manager.context.fetch(request)
        } catch let error {
            print("Erro ao fazer o fetch. \(error)")
        }
    }
    
    func fetchDespesa() {
        let request = NSFetchRequest<Despesa>(entityName: "Despesa")
        
        do {
            despesas = try manager.context.fetch(request)
        } catch let error {
            print("Erro ao fazer o fetch. \(error)")
        }
    }
    
    func fetchGasto() {
        let request = NSFetchRequest<Gasto>(entityName: "Gasto")
        
        do {
            gastos = try manager.context.fetch(request)
        } catch let error {
            print("Erro ao fazer o fetch. \(error)")
        }
    }
    
    func fetchVdH() {
        let request = NSFetchRequest<ValorHoraDeTrabalho>(entityName: "ValorHoraDeTrabalho")
        
        do {
            valorDaHora = try manager.context.fetch(request)
        } catch let error {
            print("Erro ao fazer o fetch. \(error)")
        }
    }
    
    func deletarOrcamento(indexSet: IndexSet) {
        guard let index = indexSet.first else {return}
        let entidade = orcamentos[index]
        manager.container.viewContext.delete(entidade)
        salvar()
    }
    
    func deletarDespesa(indexSet: IndexSet) {
        guard let index = indexSet.first else {return}
        let entidade = despesas[index]
        manager.container.viewContext.delete(entidade)
        salvar()
    }
    
    func deletarGasto(indexSet: IndexSet) {
        guard let index = indexSet.first else {return}
        let entidade = gastos[index]
        manager.container.viewContext.delete(entidade)
        salvar()
    }
    
    func salvar(){
        manager.salvar()
        fetchOrcamento()
        fetchDespesa()
        fetchGasto()
        fetchVdH()
    }
    
    func calcularTotalDespesa() -> Double{
        var soma = 0.0
        for despesa in despesas {
            soma += despesa.valor
        }
        return soma
    }
    
    func calcularTotalGastos() -> Double {
        var soma = 0.0
        for gasto in gastos {
            soma += gasto.custo
        }
        return soma
    }
    
    func limparCoreData(){
        orcamentos = []
        despesas = []
        gastos = []
        valorDaHora = []
        salvar()
    }
    
    public func clearDatabase() {
        guard let url = manager.container.persistentStoreDescriptions.first?.url else { return }
        
        let persistentStoreCoordinator = manager.container.persistentStoreCoordinator

         do {
             try persistentStoreCoordinator.destroyPersistentStore(at:url, ofType: NSSQLiteStoreType, options: nil)
             try persistentStoreCoordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: nil)
         } catch {
             print("Attempted to clear persistent store: " + error.localizedDescription)
         }
    }
    
    
    
//    func criarVariaveisToggleDespesa(despesas: [Despesa]) -> [Bool] {
//        @State var selecionado = false
//        var conjuntoToggle: [Bool] = []
//        for _ in 1...despesas.count {
//            conjuntoToggle.append(selecionado)
//        }
//        return conjuntoToggle
//    }
    
    
//    func AdicionarDespesaAoOrcamento(despesas: [Despesa], orcamento: Orcamento){
//        var despesasSelecionadas: [Despesa] = []
//        for despesa in despesas {
//            if despesa.selecionada {
//                let novaDespesa = Despesa(context: manager.context)
//                novaDespesa.nome = despesa.nome
//                novaDespesa.valor = despesa.valor
//                novaDespesa.selecionada = despesa.selecionada
//                despesasSelecionadas.append(novaDespesa)
//            }
//        }
//        orcamento.despesas = despesasSelecionadas
//    }
    
//    func verificaDespesas(despesasNSSet: NSSet? = nil, despesasArray: [Despesa] = []) -> [Despesa] {
//        if let despesas = despesasNSSet as? [Despesa] {
//            return despesas
//        }
//        else {
//            return despesasArray
//        }
//    }
    
}

