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
    @Published var custosVariaveis: [CustoVariavel] = []
    @Published var custosVariaveisAtual: [CustoVariavel] = []
    @Published var custosFixos: [CustoFixo] = []
    @Published var valorDaHora: [ValorHoraDeTrabalho] = []
    
//    @Published var PDFUrl: URL?
    
    func DismissKeyboard(){
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
    
    init() {
        FetchOrcamento()
        FetchCustoVariavel()
        FetchCustoFixo()
        FetchVdH()
        ClearDatabase()
        salvar()
        if valorDaHora.count < 1 {
            AddVdH()
        }
    }
    
    func AddOrcamento(nome: String, nomeCliente: String, valorDaHora: ValorHoraDeTrabalho, tempoDeTrabalho: Int, lucro: Int) {
        let custoPorHora = CalcularCustosHora(valorDaHora: valorDaHora)
        let lucroFinal = (Double(lucro) + 100) / 100
        let novoOrcamento = Orcamento(context: manager.context)
        let set = NSSet(array: custosVariaveisAtual)
        novoOrcamento.nome = nome
        novoOrcamento.nomeDoCliente = nomeCliente
        novoOrcamento.custoTotalGastos = CalcularTotalCustosFixos()
        novoOrcamento.custoTotalDespesas = CalcularTotalCustosVariaveis()
        novoOrcamento.custosVariaveis = set
        novoOrcamento.custoHora = custoPorHora
        novoOrcamento.horasDeTrabalho = Int64(tempoDeTrabalho)
        novoOrcamento.custoTotal = CalcularTotalCustosFixos() + CalcularTotalCustosVariaveis()
        novoOrcamento.lucro = Int64(lucro)
        novoOrcamento.valorDaHora = valorDaHora
        novoOrcamento.valorTotal = ((Double(tempoDeTrabalho) * valorDaHora.valorFinal) + (custoPorHora * Double(tempoDeTrabalho))) * lucroFinal
        AddCVAtuais()
        custosVariaveisAtual = []
        salvar()
    }
    
    func AddCustoVariavel(nome: String, valor: Double) {
        let novoCustoVariavel = CustoVariavel(context: manager.context)
        novoCustoVariavel.nome = nome
        novoCustoVariavel.valor = valor
        custosVariaveisAtual.append(novoCustoVariavel)
    }
    
    func AddCVAtuais() {
        for custoVariavel in custosVariaveisAtual {
            custosVariaveis.append(custoVariavel)
        }
    }
    
    func AddCustoFixo(nome: String, valorTotal: Double, vidaUtil: Int) {
        let novoCustoFixo = CustoFixo(context: manager.context)
        novoCustoFixo.nome = nome
        novoCustoFixo.valorTotal = valorTotal
        if vidaUtil == 0 {
            novoCustoFixo.vidaUtil = 1
        }
        else {
            novoCustoFixo.vidaUtil = Int64(vidaUtil)
        }
        novoCustoFixo.valorMensal = valorTotal / Double(novoCustoFixo.vidaUtil)
        salvar()
    }
    
    func AddVdH() {
        let novoVdT = ValorHoraDeTrabalho(context: manager.context)
        novoVdT.pretensaoSalarial = 0.0
        novoVdT.dias = 0
        novoVdT.horas = 0
        novoVdT.valorFinal = 0.0
        salvar()
    }
    
    func AtualizarOrcamento(entidade: Orcamento, nome: String, nomeCliente: String, tempoDeTrabalho: Int, lucro: Int){
        entidade.nome = nome
        entidade.nomeDoCliente = nomeCliente
        entidade.horasDeTrabalho = Int64(tempoDeTrabalho)
        entidade.lucro = Int64(lucro)
        entidade.valorTotal = (entidade.custoTotal + (valorDaHora[0].valorFinal * 10)) * Double(((lucro + 100) / 100))
        salvar()
    }
    
    func AtualizarCustoVariavel(entidade: CustoVariavel, nome: String, valor: Double) {
        entidade.nome = nome
        entidade.valor = valor
//        salvar()
    }
    
    func AtualizarCustoFixo(entidade: CustoFixo, nome: String, valor: Double, vidaUtil: Int){
        entidade.nome = nome
        entidade.valorTotal = valor
        if vidaUtil == 0 {
            entidade.vidaUtil = 1
        }
        else {
            entidade.vidaUtil = Int64(vidaUtil)
        }
        entidade.valorMensal = valor / Double(entidade.vidaUtil)
        salvar()
    }
    
    func AtualizarVdH(entidade: ValorHoraDeTrabalho, pretensaoSalarial: Double, dias: Int, horas: Int){
        entidade.pretensaoSalarial = pretensaoSalarial
        entidade.dias = Int64(dias)
        entidade.horas = Int64(horas)
        entidade.valorFinal = (entidade.pretensaoSalarial / Double(entidade.dias)) / Double(entidade.horas)
        salvar()
    }
    
    func FetchOrcamento() {
        let request = NSFetchRequest<Orcamento>(entityName: "Orcamento")
        
        do {
            orcamentos = try manager.context.fetch(request)
        } catch let error {
            print("Erro ao fazer o fetch. \(error)")
        }
    }
    
    func FetchCustoVariavel() {
        let request = NSFetchRequest<CustoVariavel>(entityName: "CustoVariavel")
        
        do {
            custosVariaveis = try manager.context.fetch(request)
        } catch let error {
            print("Erro ao fazer o fetch. \(error)")
        }
    }
    
    func FetchCustoFixo() {
        let request = NSFetchRequest<CustoFixo>(entityName: "CustoFixo")
        
        do {
            custosFixos = try manager.context.fetch(request)
        } catch let error {
            print("Erro ao fazer o fetch. \(error)")
        }
    }
    
    func FetchVdH() {
        let request = NSFetchRequest<ValorHoraDeTrabalho>(entityName: "ValorHoraDeTrabalho")
        
        do {
            valorDaHora = try manager.context.fetch(request)
        } catch let error {
            print("Erro ao fazer o fetch. \(error)")
        }
    }
    
    func DeletarOrcamento(indexSet: IndexSet) {
        guard let index = indexSet.first else {return}
        let entidade = orcamentos[index]
        manager.container.viewContext.delete(entidade)
        salvar()
    }
    
    func DeletarCustoVariavel(indexSet: IndexSet) {
        guard let index = indexSet.first else {return}
        let entidade = custosVariaveis[index]
        manager.container.viewContext.delete(entidade)
        salvar()
    }
    
    func DeletarCustoFixo(indexSet: IndexSet) {
        guard let index = indexSet.first else {return}
        let entidade = custosFixos[index]
        manager.container.viewContext.delete(entidade)
        salvar()
    }
    
    func salvar(){
        manager.salvar()
        FetchOrcamento()
        FetchCustoVariavel()
        FetchCustoFixo()
        FetchVdH()
    }
    
    func CalcularTotalCustosVariaveis() -> Double{
        var soma = 0.0
        for custoVariavel in custosVariaveisAtual {
            soma += custoVariavel.valor
        }
        return soma
    }
    
    func CalcularTotalCustosFixos() -> Double {
        var soma = 0.0
        for custosFixo in custosFixos {
            soma += custosFixo.valorMensal
        }
        return soma
    }
    
    func CalcularCustosHora(valorDaHora: ValorHoraDeTrabalho) -> Double {
        let totalCustos = CalcularTotalCustosFixos() + CalcularTotalCustosVariaveis()
        let totalHorasTrabalhadas = valorDaHora.dias * valorDaHora.horas
        var custoPorHora = totalCustos / Double(totalHorasTrabalhadas)
        
        if custoPorHora.isNaN || custoPorHora.isInfinite {
            custoPorHora = 0
        }
        
        return custoPorHora
    }
    
    public func ClearDatabase() {
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
    
    public func ValidaCustoVariavel(nome: String, valor: Double) -> Bool {
        if nome != "" && valor > 0 {
            return true
        }
        return false
    }
    
    public func ValidaCustoFixo(nome: String, valor: Double) -> Bool {
        if nome != "" && valor > 0 {
            return true
        }
        return false
    }
}
