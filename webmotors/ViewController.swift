//
//  ViewController.swift
//  webmotors
//
//  Created by Nikita Fedorenko on 17.12.2021.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    
    private var vehicles: [Vehicle] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        configureTableView()
        fetchData()
    }
    
    private func configureTableView() {
        navigationItem.title = "Vehicles"
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func fetchData(){
        if let url = URL(string: "https://desafioonline.webmotors.com.br/api/OnlineChallenge/Vehicles?Page=1") {
            let task = URLSession.shared.dataTask(with: url, completionHandler: {data, response, error in
                if let error = error {
                    print("client error: \(error.localizedDescription)")
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse,
                      (200...299).contains(httpResponse.statusCode) else {
                          print("server error")
                          return
                      }
                
                if let data = data {
                    do {
                        let result = try JSONDecoder().decode([Vehicle].self, from: data)
                        self.vehicles = result
                        
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                        
                    } catch {
                        print("decoder error")
                    }
                }
            })
            
            task.resume()
        }
    }
}

//MARK: ViewController extension
extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        vehicles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = vehicles[indexPath.row].make
        cell.detailTextLabel?.text = vehicles[indexPath.row].version
        
        return cell
    }
}

