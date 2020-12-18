//
//  TarefaViewController.swift
//  AppTodoList_Swift
//
//  Created by Sundek on 18/12/20.
//

import UIKit
import CoreData

class TarefaViewController: UIViewController {
    
    @IBOutlet weak var tituloTarefa: UITextField!
    @IBOutlet weak var descricaoTarefa: UITextView!
    @IBOutlet weak var dataHoraTarefa: UIDatePicker!
    @IBOutlet weak var prioridadeTarefa: UISegmentedControl!
    
    //Para manipulação das informações
    var context: NSManagedObjectContext!
    var tarefa: NSManagedObject!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tituloTarefa.becomeFirstResponder()
        self.descricaoTarefa.becomeFirstResponder()
        self.dataHoraTarefa.becomeFirstResponder()
        self.prioridadeTarefa.becomeFirstResponder()
        
        if tarefa != nil {
            if let tituloRecuperado = tarefa.value(forKey: "titulo") {
                self.tituloTarefa.text = tituloRecuperado as? String
            }
            if let descricaoRecuperado = tarefa.value(forKey: "descricao") {
                self.descricaoTarefa.text = descricaoRecuperado as? String
            }
            if let dataHoraRecuperado = tarefa.value(forKey: "data") {
                self.dataHoraTarefa.date = dataHoraRecuperado as! Date
            }
            if let prioridadeRecuperado = tarefa.value(forKey: "prioridade") {
                self.prioridadeTarefa.selectedSegmentIndex = converteNomeNumero(nome: prioridadeRecuperado as! String)
            }
        } else {
            self.tituloTarefa.text = ""
            self.descricaoTarefa.text = ""
            self.dataHoraTarefa.date = Date()
            self.prioridadeTarefa.selectedSegmentIndex = 0
        }
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        context = appDelegate.persistentContainer.viewContext
        
    }
    
    @IBAction func salvar(_ sender: Any) {
        
        if tarefa == nil {
            self.salvarTarefa()
        }
        
        //Retornar para tela anteriro
        self.navigationController?.popViewController(animated: true)
    }
    
    func salvarTarefa() {
        
        //Cria o objeto para tarefa
        let novaTarefa = NSEntityDescription.insertNewObject(forEntityName: "Tarefas", into: context)
        
        //Configura o objeto
        novaTarefa.setValue(self.tituloTarefa.text, forKey: "titulo")
        novaTarefa.setValue(self.descricaoTarefa.text, forKey: "descricao")
        novaTarefa.setValue(self.dataHoraTarefa.date, forKey: "data")
        novaTarefa.setValue(converterNumeroNome(indice: self.prioridadeTarefa.selectedSegmentIndex), forKey: "prioridade")
        
        //Salva o objeto
        do {
            try context.save()
            print("Tarefa salva com sucesso!!!")
        } catch let erro {
            print("Erro ao salvar tarefa: \(erro.localizedDescription)")
        }
    }
    
    //Conveter o nome em número da propriedade "prioridade"
    func converteNomeNumero(nome: String) -> Int {
        switch nome {
        case "Baixo":
            return 0
        case "Médio":
            return 1
        case "Alto":
            return 2
        default:
            return 0
        }
    }
    
    //Conveter o indice em nome da propriedade "prioridade"
    func converterNumeroNome(indice: Int) -> String {
        switch indice {
        case 0:
            return "Baixo"
        case 1:
            return "Médio"
        case 2:
            return "Alto"
        default:
            return "Baixo"
        }
    }
    
}
