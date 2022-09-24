//
//  Extensoes.swift
//  Teste SwiftUI
//
//  Created by Lucca Lopes on 23/09/22.
//

import SwiftUI

extension View{
    
    func converterParaView<Content: View>(@ViewBuilder content: @escaping ()->Content)->UIScrollView{
        
        let scrollView = UIScrollView()
        
        let controladorDeHospedagem = UIHostingController(rootView: content()).view!
        controladorDeHospedagem.translatesAutoresizingMaskIntoConstraints = false
        
        let contraints = [
            
            controladorDeHospedagem.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            controladorDeHospedagem.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            controladorDeHospedagem.topAnchor.constraint(equalTo: scrollView.topAnchor),
            controladorDeHospedagem.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            controladorDeHospedagem.widthAnchor.constraint(equalToConstant: limitesTela().width )
        ]
        scrollView.addSubview(controladorDeHospedagem)
        scrollView.addConstraints(contraints)
        scrollView.layoutIfNeeded()
        
        return scrollView
    }
    
    func exportarPDF<Content: View>(@ViewBuilder content: @escaping ()->Content,completion: @escaping(Bool,URL?)->()){
    
        let documentoDiretorio = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!

        let resultadoFileUrl = documentoDiretorio.appendingPathComponent("NOMEDOSEUPDF\(UUID().uuidString).pdf")

        let pdfView = converterParaView {
            TelaInicial()
        }
        pdfView.tag = 1009
        let size = pdfView.contentSize
        //Remove o espaco em branco do topo
        pdfView.frame = CGRect(x: 0,y: PegarSafeArea().top, width: size.width, height: size.height)
        
        pegarControlaorRaiz().view.insertSubview(pdfView, at: 0)
        
        let redenrizador = UIGraphicsPDFRenderer(bounds: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        
        do{
            try redenrizador.writePDF(to: resultadoFileUrl, withActions: { context in
                
                context.beginPage()
                pdfView.layer.render(in: context.cgContext)
            })
            completion(true,resultadoFileUrl)
        }
        catch{
            completion(false,nil)
            print(error.localizedDescription)
        }
                
        //remove o added view
        pegarControlaorRaiz().view.subviews.forEach { view in
            if view.tag == 1009{
                print("Remover")
                view.removeFromSuperview()

            }
        }
    }
    
    func limitesTela()->CGRect{
        return UIScreen.main.bounds
    }
    
    func pegarControlaorRaiz()->UIViewController{
        guard let tela = UIApplication.shared.connectedScenes.first as? UIWindowScene else{
            return .init()
        }
        guard let raiz = tela.windows.first?.rootViewController else{
            return .init()
        }
        return raiz
    }
    
    func PegarSafeArea()->UIEdgeInsets{
        guard let tela = UIApplication.shared.connectedScenes.first as? UIWindowScene else{
            return .zero
        }
        guard let safeArea = tela.windows.first?.safeAreaInsets else{
            return .zero
        }
        return safeArea
    }
}
