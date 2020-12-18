//
//  DetalheViewController.swift
//  AppTodoList_Swift
//
//  Created by Sundek on 18/12/20.
//

import UIKit
import CoreData

class DetalheViewController: UIViewController {
    
    
    @IBOutlet weak var tituloTarefa: UILabel!
    @IBOutlet weak var descricaoTarefa: UILabel!
    @IBOutlet weak var dataHoraTarefa: UILabel!
    @IBOutlet weak var prioridadeTarefa: UILabel!
    
    var context: NSManagedObjectContext!
    var tarefa: NSManagedObject!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        recuperarTarefa()
        
    }
    
    func recuperarTarefa() {
        
        if tarefa != nil {
            if let tituloRecuperado = tarefa.value(forKey: "titulo") {
                self.tituloTarefa.text = tituloRecuperado as? String
            }
            if let descricaoRecuperado = tarefa.value(forKey: "descricao") {
                self.descricaoTarefa.text = descricaoRecuperado as? String
            }
            if let dataHoraRecuperado = tarefa.value(forKey: "data") {
                self.dataHoraTarefa.text = formatarData(data: dataHoraRecuperado as! Date)
            }
            if let prioridadeRecuperado = tarefa.value(forKey: "prioridade") {
                self.prioridadeTarefa.text = prioridadeRecuperado as? String
            }
        }
        
    }
    
    func formatarData(data: Date) -> String {
        
        let formataData = DateFormatter()
        formataData.dateFormat = "dd/MM/yyyy hh:mm"
        return formataData.string(from: data)
    }
    
}
