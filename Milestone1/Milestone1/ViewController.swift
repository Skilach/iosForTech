//
//  ViewController.swift
//  Milestone1
//
//  Created by Илья Сидоров  on 17.11.2023.
//

import UIKit

class ViewController: UITableViewController {

    var flags = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Countries"
        
        for item in items{
            if item.contains("3x"){
                flags.append(item)
            }
        }
        print(flags)
        // Do any additional setup after loading the view.
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return flags.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        cell.textLabel?.text = flags[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController{
            vc.selectedFlag = flags[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}

