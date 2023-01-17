//
//  ViewController.swift
//  APINumber
//
//  Created by Marc-Antoine BAR on 2022-12-26.
//

import UIKit

class ViewController: UIViewController {

    //MARK: - Properties
    
    @IBOutlet var tableView: UITableView!
    private let numberService = NumberService()
    private var numbersList = [Number]()
    
    //MARK: - Properties
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for number in 0...25 {
            fetchDataNumber(number: number)
        }
    }
    
    //MARK: - Privates
    
    private func fetchDataNumber(number: Int) {
        numberService.fetchDataNumbers(number: number) { result in
            switch result {
            case .success(let value):
                let number = value.number
                let text = value.text
                let item = Number(text: text, number: number)
                self.numbersList.append(item)
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
}

//MARK: - Extension UITableViewDelegate, UITableViewDataSource

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numbersList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        cell.textLabel?.text = numbersList[indexPath.row].text
        return cell
    }
}
