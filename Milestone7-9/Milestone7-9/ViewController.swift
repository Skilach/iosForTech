//
//  ViewController.swift
//  Milestone7-9
//
//  Created by Илья Сидоров  on 29.12.2023.
//

import UIKit

class ViewController: UIViewController {
    var words = [String]()
    var scoreLabel: UILabel!
    var letterButtons = [UIButton]()
    var secret = {(str: String) -> String in
        var s = ""
        for _ in 0..<str.count{
            s.append("?")
        }
        return s
    }
    let letters = ["e","w","c","r","t","y","u","i","o","p","a","s","d","f","g","h","j","k","l","z","x","c","v","b","n","m"]
    
    var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        
        scoreLabel = UILabel()
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        scoreLabel.textAlignment = .right
        scoreLabel.text = "Score: 0"
        view.addSubview(scoreLabel)
        
        
        let buttonsView = UIView()
        buttonsView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(buttonsView)
        
        NSLayoutConstraint.activate([
            scoreLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            scoreLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: 0),
                
            buttonsView.widthAnchor.constraint(equalToConstant: 500),
            buttonsView.heightAnchor.constraint(equalToConstant: 500),
            buttonsView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonsView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -30)
        ])
        
//        buttonsView.backgroundColor = .black
        
        let width = 100
        let height = 100
        
        for row in 0..<5{
            for col in 0..<5{
                let letterButton = UIButton(type: .system)
                
                letterButton.titleLabel?.font = UIFont.systemFont(ofSize: 30)
                
                letterButton.setTitle("?", for: .normal)
                letterButton.frame = CGRect(x: width * col, y: height * row, width: width, height: height)
                letterButton.layer.borderWidth = 1
                letterButton.layer.borderColor = UIColor.gray.cgColor
                
                buttonsView.addSubview(letterButton)
                letterButtons.append(letterButton)
                
                letterButton.addTarget(self, action: #selector(letterTapped), for: .touchUpInside)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let wordsLoaded = Bundle.main.url(forResource: "words", withExtension: "txt"){
            if let wordsContent = try? String(contentsOf: wordsLoaded){
                words = wordsContent.components(separatedBy: "\n")
                words.removeLast()
                words.shuffle()
                print(words)
            }
        }
        
        loadLevel()
        
        
        // Do any additional setup after loading the view.
    }
    
    @objc func letterTapped(_ sender: UIButton){
        guard let buttonTitle = sender.titleLabel?.text else {return}
        let wordLowerCased = words[0].lowercased()
        for (idx, char) in wordLowerCased.enumerated() {
            if String(char) == buttonTitle {
                title?.insert(char, at: String.Index(encodedOffset: 12 + idx))
                title?.remove(at: String.Index(encodedOffset: 12 + idx + 1))
                score += 1
            }
        }
        if (title?.contains("?") == false){
            greatJob()
        }
    }
    
    func greatJob(){
        let ac = UIAlertController(title: "next word for you", message: "Ready?", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "ok", style: .default, handler: levelUp))
        present(ac, animated: true)
    }
    
    func levelUp(_ action: UIAlertAction){
        words.remove(at: 0)
        loadLevel()
    }
    
    func loadLevel(){
        if words.count == 0{
            let ac = UIAlertController(title: "The end", message: "congratulations", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "so sad", style: .destructive))
            present(ac, animated: true)
            return
        }
        title = "First word: \(secret(words[0]))"
        for i in 0..<letterButtons.count{
            letterButtons[i].setTitle(letters[i], for: .normal)
        }
    }
}

