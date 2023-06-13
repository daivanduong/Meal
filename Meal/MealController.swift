//
//  MealController.swift
//  Meal
//
//  Created by Ocean97 on 11/06/2023.
//

import UIKit

final class MealController: UIViewController {
    
    
    var viewModel = MealViewModel()
    var viewModelTest: MealViewModelProtocol!
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var generateBT: UIButton!
    
    var mealSelect = false
    var drinkSelect = false
    var keyDrink = ""
    var keyMeal = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupColectionView()
        setupButton()
        
    }
    
    func setupColectionView() {
        let nib = UINib(nibName: "MealCategoriesCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "mealCategoriesCell")
        
        let nibHeader = UINib(nibName: "Header", bundle: nil)
        collectionView.register(nibHeader, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header")
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.allowsMultipleSelection = true
        collectionView.reloadData()
        self.viewModel.reloadData = { [weak self] in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
        viewModel.getDataAPICategoriesMeal()
        viewModel.getDataDrink()
        //viewModelTest.getDataAPICategoriesMeal()

    }
    
    func setupButton() {
        generateBT.layer.cornerRadius = 5
        
        generateBT.isEnabled = false
    }
    
    
    @IBAction func tapOnGenerate(_ sender: Any) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(identifier: "generateVC")
        navigationController?.pushViewController(vc, animated: true)
    }
    

}


extension MealController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return viewModel.categoriesMeal?.categories?.count ?? 00
        } else {
            return viewModel.categoriesDink.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mealCategoriesCell", for: indexPath) as! MealCategoriesCell
        if indexPath.section == 0 {
            cell.categoriesName.text = viewModel.categoriesMeal?.categories?[indexPath.row].strCategory
        } else {
            cell.categoriesName.text = viewModel.categoriesDink[indexPath.row].nameDrink
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionView.elementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath) as! Header
            
            if indexPath.section == 0 {
                header.lbHeader.text = "Meal"
            } else {
                header.lbHeader.text = "Drink"
            }
            return header
        } else {
            return UICollectionReusableView()
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let w = collectionView.frame.width
        return CGSize(width:w, height:50)

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let w = (view.frame.width - 20) / 3
        return CGSize(width: w, height: w)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            keyMeal = viewModel.categoriesMeal?.categories?[indexPath.row].strCategory ?? ""
            UserDefaults.standard.set(keyMeal, forKey: "Categories_Meal")
            mealSelect = true

        } else {
            drinkSelect = true
            keyDrink = viewModel.categoriesDink[indexPath.row].nameDrink
            UserDefaults.standard.set(keyDrink, forKey: "Categories_Drink")
        }
        if mealSelect == true {
            if drinkSelect == true {
                generateBT.isEnabled = true
                generateBT.backgroundColor = .blue
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        collectionView.indexPathsForSelectedItems?.filter({ $0.section == indexPath.section }).forEach({ collectionView.deselectItem(at: $0, animated: false) })
        
        return true
    }
    func collectionView(_ collectionView: UICollectionView, shouldDeselectItemAt indexPath: IndexPath) -> Bool {
        generateBT.isEnabled = false
        generateBT.backgroundColor = .secondaryLabel
        if indexPath.section == 0 {
            mealSelect = false
        } else {
            drinkSelect = false
        }
        
        return true
    }
    
    
    
}
