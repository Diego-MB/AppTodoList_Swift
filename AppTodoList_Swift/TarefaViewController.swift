//
//  TarefaViewController.swift
//  AppTodoList_Swift
//
//  Created by Sundek on 18/12/20.
//

import UIKit

class TarefaViewController: UIViewController {
    
    @IBOutlet weak var tituloTarefa: UITextField!
    @IBOutlet weak var descricaoTarefa: UITextView!
    @IBOutlet weak var dataHoraTarefa: UIDatePicker!
    @IBOutlet weak var prioridadeTarefa: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func salvar(_ sender: Any) {
    }
    
}
