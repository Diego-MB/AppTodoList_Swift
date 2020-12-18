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
    
    //Recarrega a tela com novos valores
    override func viewDidAppear(_ animated: Bool) {
        recuperarTarefa()
    }
    
    //Botão para enviar as informações para a tela seguinte
    @IBAction func editar(_ sender: Any) {
        
        performSegue(withIdentifier: "editarTarefa", sender: self.tarefa)
        
    }
    
    //Prepara a segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "editarTarefa" {
            let viewDestino = segue.destination as! TarefaViewController
            
            viewDestino.tarefa = sender as? NSManagedObject
        }
        
    }
    
    //Recupera as informações
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
    
    //Formata a data
    func formatarData(data: Date) -> String {
        
        let formataData = DateFormatter()
        formataData.dateFormat = "dd/MM/yyyy hh:mm"
        return formataData.string(from: data)
    }
    
}
