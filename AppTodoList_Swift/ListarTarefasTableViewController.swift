//
//  ListarTarefasTableViewController.swift
//  AppTodoList_Swift
//
//  Created by Sundek on 18/12/20.
//

import UIKit
import CoreData

class ListarTarefasTableViewController: UITableViewController {
    
    var context: NSManagedObjectContext!
    var tarefas: [NSManagedObject] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        context = appDelegate.persistentContainer.viewContext
    }
    
    override func viewDidAppear(_ animated: Bool) {
        recuperarTarefas()
    }
    
    func recuperarTarefas() {
        
        let requisicao = NSFetchRequest<NSFetchRequestResult>(entityName: "Tarefas")
        
        let ordenacao = NSSortDescriptor(key: "data", ascending: false)
        
        requisicao.sortDescriptors = [ordenacao]
        
        do {
            
            let tarefasRecuperadas = try context.fetch(requisicao)
            
            self.tarefas = tarefasRecuperadas as! [NSManagedObject]
            
            self.tableView.reloadData()
            
        } catch let erro {
            print("Erro ao recuperar tarefas: \(erro.localizedDescription)")
        }
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.tarefas.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "celula", for: indexPath)
        
        // Configurando a cell
        let tarefa = self.tarefas[indexPath.row]
        let tituloRecuperado = tarefa.value(forKey: "titulo")
        let dataHoraRecuperado = tarefa.value(forKey: "data")
        
        //formatando data
        let formataData = DateFormatter()
        formataData.dateFormat = "dd/MM/yyyy hh:mm"
        let novaData = formataData.string(from: dataHoraRecuperado as! Date)
        
        //Preenchendo a lista
        cell.textLabel?.text = tituloRecuperado as? String
        cell.detailTextLabel?.text = novaData

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
