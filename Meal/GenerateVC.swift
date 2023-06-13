//
//  GenerateVC.swift
//  Meal
//
//  Created by Ocean97 on 13/06/2023.
//

import UIKit
import SDWebImage

class GenerateVC: UIViewController {
    
    var viewModel = MealViewModel()
    
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
        tableView.reloadData()
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        if let keyMeal = UserDefaults.standard.string(forKey: "Categories_Meal") {
            viewModel.generateMeal(key: keyMeal)
        }
        if let keyDrink = UserDefaults.standard.string(forKey: "Categories_Drink") {
            viewModel.generateDrink(key: keyDrink)
        }
        dispatchGroup.leave()
        dispatchGroup.notify(queue: .main) {
            self.viewModel.reloadData = { [weak self] in
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            }
        }
        
    }

}

extension GenerateVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath) as! TableViewCell
        let meal_Diner = viewModel.mealModel?.meals?.randomElement()
        let drink_Diner = viewModel.drinkModel?.drinks?.randomElement()

        if indexPath.section == 0 {
            cell.lbName.text = meal_Diner?.strMeal
            if let url = URL(string: "\(meal_Diner?.strMealThumb ?? "")") {
                cell.img.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder.png"))
            }
            cell.lbCategories.text = UserDefaults.standard.string(forKey: "Categories_Meal")
            
        } else {
            cell.lbName.text = drink_Diner?.strDrink
            if let url = URL(string: "\(drink_Diner?.strDrinkThumb ?? "")") {
                cell.img.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder.png"))
            }
            cell.lbCategories.text = UserDefaults.standard.string(forKey: "Categories_Drink")
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Meal"
        } else {
            return "Drink"
        }
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    
}
