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
        if valorDaHora.count < 1 {
            addVdH()
        }
    }
    
    func addOrcamento(nome: String, nomeCliente: String, totalGastos: Double, totalDespesas: Double, custoPorHora: Double, tempoDeTrabalho: String, custoTotal: Double, lucro: Int, valorTotal: Double) {
        let novoOrcamento = Orcamento(context: manager.context)
        novoOrcamento.nome = nome
        novoOrcamento.nomeDoCliente = nomeCliente
        novoOrcamento.custoTotalGastos = totalGastos
        novoOrcamento.custoTotalDespesas = totalDespesas
        novoOrcamento.custoHora = custoPorHora
        novoOrcamento.tempoDeTrabalho = tempoDeTrabalho
        novoOrcamento.custoTotal = custoTotal
        novoOrcamento.lucro = Int64(lucro)
        novoOrcamento.valorTotal = valorTotal
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
        novoVdT.valorFinal = 0.0
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
    
    func calcularTotalDespesa(despesasSelecionadas: [Despesa]) -> Double{
        var soma = 0.0
        for despesa in despesas {
            soma += despesa.valor
        }
        return soma
    }
    
    func calcularTotalGastos(gastosSelecionados: NSSet?) -> Double {
        var soma = 0.0
        for gasto in gastos {
            soma += gasto.custo
        }
        return soma
    }
    
}
