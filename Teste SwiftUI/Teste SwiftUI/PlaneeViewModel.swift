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
    
    func dismissKeyboard(){
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
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
    
    let corDark = [Color(red: 0, green: 0.332, blue: 0.546, opacity: 0.84),//0
                   Color(red: 0, green: 0.167, blue: 0.275, opacity: 1),//1
                   Color(red: 0.353, green: 0.784, blue: 0.961, opacity: 1),//2
                   Color(red: 0, green: 0.306, blue: 0.502, opacity: 1)//3
    ]
    
    let corLight = [Color(red: 0.188, green: 0.51, blue: 0.718, opacity: 0.84),//0
                    Color(red: 0.188, green: 0.51, blue: 0.718, opacity: 0.25),//1
                    Color(red: 0.133, green: 0.472, blue: 0.692, opacity: 1),//2
                    Color(red: 0.842, green: 0.916, blue: 0.962, opacity: 1),//3
                    Color(red: 0, green: 0.306, blue: 0.512, opacity: 1)//4
    ]
    
    init() {
        fetchOrcamento()
        fetchDespesa()
        fetchGasto()
        fetchVdH()
//        clearDatabase()
//        salvar()
        if valorDaHora.count < 1 {
            addVdH()
        }
    }
    
    func addOrcamento(nome: String, nomeCliente: String, totalGastos: Double, totalDespesas: Double, valorDaHora: ValorHoraDeTrabalho, tempoDeTrabalho: Int, lucro: Int) {
        
        let custoTotal = totalGastos + totalDespesas
        var custoPorHora = ((custoTotal / Double(valorDaHora.dias)) / Double(valorDaHora.horas))
        let lucroFinal = (Double(lucro) + 100) / 100
        let novoOrcamento = Orcamento(context: manager.context)
        
        if custoPorHora.isNaN || custoPorHora.isInfinite {
            custoPorHora = 0
        }
        
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
        print(custoPorHora)
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
    
    public func ValidaOrcamento(nomeOrcamento: String, nomeCliente: String, qtdHora: Int) -> Bool {
        if nomeOrcamento != "" && nomeCliente != "" && qtdHora > 0{
            return true
        }
        return false
    }
    
    public func ValidaDespesa(nome: String, valor: Double) -> Bool {
        if nome != "" && valor > 0{
            return true
        }
        return false
    }
    
    public func ValidaGasto(nome: String,valor: Double, vidaUtil: Int) -> Bool {
        if nome != "" && valor > 0 && vidaUtil > 0{
            return true
        }
        return false
    }
}
