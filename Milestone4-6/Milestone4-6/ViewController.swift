//
//  ViewController.swift
//  Milestone4-6
//
//  Created by Илья Сидоров  on 06.12.2023.
//

import UIKit

class ViewController: UITableViewController {

    var buys = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Must have"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addWord))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "delete all", style: .plain, target: self, action: #selector(reload))
        
        
        // Do any additional setup after loading the view.
    }

    @objc func addWord(){
        let ac = UIAlertController(title: "Write for buy", message: nil, preferredStyle: .alert)
        ac.addTextField()
        let submitAction = UIAlertAction(title: "done", style: .default) { [weak ac, weak self] _ in
            guard let answer = ac?.textFields?[0].text else { return }
            self?.submit(answer)
//            self?.buys.insert(answer.lowercased(), at: 0)
//            let indexPath = IndexPath(row: 0, section: 0)
//            self?.tableView.insertRows(at: [indexPath], with: .automatic)
        }
        
        ac.addAction(submitAction)
        present(ac, animated: true)
    }
    
    @objc func reload(){
        buys.removeAll(keepingCapacity: true)
        tableView.reloadData()
    }
    
    func submit(_ answer: String){
        let lowerAnswer = answer.lowercased()
        if buys.contains(lowerAnswer){ return }
        buys.insert(lowerAnswer, at: 0)
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return buys.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Word", for: indexPath)
        cell.textLabel?.text = buys[indexPath.row]
        return cell
    }

}

