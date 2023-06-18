//
//  GenerateVC.swift
//  Meal
//
//  Created by Ocean97 on 13/06/2023.
//

import UIKit
import SDWebImage

class GenerateVC: UIViewController {
    
    var viewModel: GenerateViewModelProtocol = GenerateViewModel()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupTableView()
    }
    
    func setupTableView() {
        let nib = UINib(nibName: "TableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "tableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        viewModel.callAPI()
        viewModel.reloadData = { [weak self] in
            self?.tableView.reloadData()
        }
    }

}

extension GenerateVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section: section)
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath) as! TableViewCell
        
        cell.img.sd_setImage(with: viewModel.getURLImage(index: indexPath), placeholderImage: UIImage(named: "placeholder.png"))
        cell.lbName.text = viewModel.getName(index: indexPath)
        cell.lbCategories.text = viewModel.getCategoriesName(index: indexPath)
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        viewModel.titleForHeaderInSection(section: section)
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    
}
