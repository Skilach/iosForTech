//
//  ViewController.swift
//  Project7
//
//  Created by Илья Сидоров  on 07.12.2023.
//

import UIKit

class ViewController: UITableViewController {
    
    var petitions = [Petition]()
    var filteredPetitions = [Petition]()
    
    var filterKeyword = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let urlString: String

        if navigationController?.tabBarItem.tag == 0 {
            // urlString = "https://api.whitehouse.gov/v1/petitions.json?limit=100"
            urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
        } else {
            // urlString = "https://api.whitehouse.gov/v1/petitions.json?signatureCountFloor=10000&limit=100"
            urlString = "https://www.hackingwithswift.com/samples/petitions-2.json"
        }

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Credits", style: .plain, target: self, action: #selector(warning))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Filter", style: .plain, target: self, action: #selector(askFilter))
        
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                parse(json: data)
                return
            }
        }
        
        showError()
    }
    
    @objc func warning() {
        let vc = UIAlertController(title: "Attention", message: "Data from 'API We The People'", preferredStyle: .alert)
        vc.addAction(UIAlertAction(title: "OK", style: .default))
        present(vc, animated: true)
    }
    
    @objc func askFilter() {
            let ac = UIAlertController(title: "Filter", message: "Filter the petitions on the following keyword (leave empty to reset filtering)", preferredStyle: .alert)
            ac.addTextField()

            ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            ac.addAction(UIAlertAction(title: "OK", style: .default) {
                [weak self, weak ac] _ in
                self?.filterKeyword = ac?.textFields?[0].text ?? ""
                self?.filterData()
                self?.tableView.reloadData()
            })
            
            present(ac, animated: true)

        }
        
        func filterData() {
            if filterKeyword.isEmpty {
                filteredPetitions = petitions
                navigationItem.leftBarButtonItem?.title = "Filter"
                return
            }

            navigationItem.leftBarButtonItem?.title = "Filter (current: \(filterKeyword))"

            // keep only petition whose title or body contains keyword
            filteredPetitions = petitions.filter() { petition in
                // use range instead of contains to filter in case insentive manner
                // (see https://www.hackingwithswift.com/example-code/strings/how-to-run-a-case-insensitive-search-for-one-string-inside-another)
                if let _ = petition.title.range(of: filterKeyword, options: .caseInsensitive) {
                    return true
                }
                if let _ =  petition.body.range(of: filterKeyword, options: .caseInsensitive) {
                    return true
                }
                return false
            }
        }
//
//    @objc func Filter(){
//        let vc = UIAlertController(title: "Request", message: nil, preferredStyle: .alert)
//        vc.addTextField()
//        
//        let requestAction = UIAlertAction(title: "Go", style: .default) {[ weak self, weak vc] _ in
//            guard let answer = vc?.textFields?[0].text else { return }
//            self?.response(answer)
//        }
//        
//        vc.addAction(requestAction)
//        present(vc, animated: true)
//    }
//    
//    func response(_ answer: String){
//      
//        filteredPetitions.removeAll()
//        
//        for petition in petitions{
//            if petition.body.contains(answer){
//                filteredPetitions.insert(petition, at: 0)
//                let indexPath = IndexPath(row: 0, section: 0)
//                tableView.insertRows(at: [indexPath], with: .automatic)
//                
//                return
//            }
//        }
//    }
    
    func parse(json :Data){
        let decoder = JSONDecoder()
        
        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json){
            petitions = jsonPetitions.results
            filterData()
            tableView.reloadData()
        }
    }

    func showError(){
        let ac = UIAlertController(title: "Loading error", message: "There was a problem loading the feed; please check your connection and try again.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredPetitions.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let petition = filteredPetitions[indexPath.row]
        cell.textLabel?.text = petition.title
        cell.detailTextLabel?.text = petition.body
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.detailItem = filteredPetitions[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

