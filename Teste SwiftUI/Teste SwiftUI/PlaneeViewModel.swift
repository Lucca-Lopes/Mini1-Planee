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
    
    @Published var PDFUrl: URL?
//    @Published var mostraSheetCp: Bool = false
    
    let formatacao: NumberFormatter = {
        let formatacao = NumberFormatter()
        formatacao.numberStyle = .decimal
        formatacao.minimumFractionDigits = 2
        formatacao.maximumFractionDigits = 2
        formatacao.decimalSeparator = ","
        formatacao.zeroSymbol = ""
        return formatacao
    }()
    
    let numFormatacao: NumberFormatter = {
        let numero = NumberFormatter()
        numero.zeroSymbol = ""
        return numero
    }()
    
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
    
    func addOrcamento(nome: String, nomeCliente: String, totalGastos: Double, totalDespesas: Double, valorDaHora: ValorHoraDeTrabalho, tempoDeTrabalho: Int, lucro: Int) {
        let custoPorHora = (((totalGastos + totalDespesas) / Double(valorDaHora.dias)) / Double(valorDaHora.horas))
        let custoTotal = totalGastos + totalDespesas
        let lucroFinal = (Double(lucro) + 100) / 100
        let novoOrcamento = Orcamento(context: manager.context)
        novoOrcamento.nome = nome
        novoOrcamento.nomeDoCliente = nomeCliente
        novoOrcamento.custoTotalGastos = totalGastos
        novoOrcamento.custoTotalDespesas = totalDespesas
        novoOrcamento.custoHora = custoPorHora
        novoOrcamento.horasDeTrabalho = Int64(tempoDeTrabalho)
        novoOrcamento.custoTotal = custoTotal
        novoOrcamento.lucro = Int64(lucro)
        novoOrcamento.valorDaHora = valorDaHora
        novoOrcamento.valorTotal = ((Double(tempoDeTrabalho) * valorDaHora.valorFinal) + (custoPorHora * Double(tempoDeTrabalho))) * lucroFinal
        salvar()
    }
    
    func addDespesa(nome: String, valor: Double) {
        let novaDespesa = Despesa(context: manager.context)
        novaDespesa.nome = nome
        novaDespesa.valor = valor
        novaDespesa.selecionada = false
        salvar()
    }
    
    func addGasto(nome: String, valor: Double, vidaUtil: Int) {
        let novoGasto = Gasto(context: manager.context)
        novoGasto.nome = nome
        novoGasto.valor = valor
        novoGasto.vidaUtil = Int64(vidaUtil)
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
    
    func atualizarOrcamento(entidade: Orcamento, nome: String, nomeCliente: String, tempoDeTrabalho: Int, lucro: Int){
        entidade.nome = nome
        entidade.nomeDoCliente = nomeCliente
        entidade.horasDeTrabalho = Int64(tempoDeTrabalho)
        entidade.lucro = Int64(lucro)
        entidade.valorTotal = (entidade.custoTotal + (valorDaHora[0].valorFinal * 10)) * Double(((lucro + 100) / 100))
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

