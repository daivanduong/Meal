//
//  MealViewModel.swift
//  Meal
//
//  Created by Ocean97 on 11/06/2023.
//

import Foundation

class MealViewModel: MealViewModelProtocol {
    
    var updateBTGenerate: (() -> ())?
    private var categoriesMeal: CategoriesMeal?
    private var categoriesDink: CategoriesDink?
    private var checked: Bool?
    var reloadData: (() -> ())?
    
    func headerTitle(index: IndexPath) -> String {
        if index.section == 0 {
            return "Meal"
        } else {
            return " Drink"
        }
    }
    
    var numberOfSections: Int {
        return 2
    }
    
    func isSelectCell(index: Int){
        if index == 2 {
          checked = true
            
        } else {
          checked = false
            
        }
        updateBTGenerate?()
    }
    
    func isChecked() -> Bool {
        return checked ?? false
    }
    
    func numberOfItemsInSection(section: Int) -> Int {
        if section == 0 {
            return categoriesMeal?.categories?.count ?? 0
        } else {
            return categoriesDink?.drinks?.count ?? 0
        }
    }

    func getCategoriesNameForCell(index: IndexPath) -> String {
        if index.section == 0 {
            return categoriesMeal?.categories?[index.row].strCategory ?? ""
        } else {
            return categoriesDink?.drinks?[index.row].strCategory ?? ""
        }
    }
    
    func startAPICall() {
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        let urlApiMeal = URL(string: "https://www.themealdb.com/api/json/v1/1/categories.php")!
        URLSession.shared.dataTask(with: urlApiMeal) { [weak self] data, reponse, error in
            if let data = data {
                let categoriesData = try! JSONDecoder().decode(CategoriesMeal.self, from: data)
                self?.categoriesMeal = categoriesData
                dispatchGroup.leave()
            }
        }.resume()
        dispatchGroup.enter()
        let urlApiDrink = URL(string: "https://www.thecocktaildb.com/api/json/v1/1/list.php?c=list")!
        URLSession.shared.dataTask(with: urlApiDrink) { [weak self] data, reponse, error in
            if let data = data {
                let categoriesData = try! JSONDecoder().decode(CategoriesDink.self, from: data)
                self?.categoriesDink = categoriesData
                dispatchGroup.leave()
            }
        }.resume()
        
        dispatchGroup.notify(queue: .main) {
            self.reloadData?()
        }
    }
    
    func getCategoriesName(index: IndexPath) {
        if index.section == 0 {
            let categories = categoriesMeal?.categories?[index.row].strCategory
            UserDefaults.standard.set(categories, forKey: "CategoriesMeal")
        } else {
            let categories = categoriesDink?.drinks?[index.row].strCategory
            UserDefaults.standard.set(categories, forKey: "CategoriesDrink")
        }
    }

}


