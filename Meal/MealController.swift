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
        self.viewModel.reloadCollectionView = { [weak self] in
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
        generateBT.backgroundColor = .systemIndigo
        generateBT.isEnabled = false
    }

}


extension MealController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return viewModel.categoriesMeal1?.categories?.count ?? 00
        } else {
            return viewModel.categoriesDink.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mealCategoriesCell", for: indexPath) as! MealCategoriesCell
        if indexPath.section == 0 {
            cell.categoriesName.text = viewModel.categoriesMeal1?.categories?[indexPath.row].strCategory
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
        
        let cell = collectionView.cellForItem(at: indexPath)
        if indexPath.section == 0 {
            let name = viewModel.categoriesMeal1?.categories?[indexPath.row].strCategory
            print(name!)
            cell?.contentView.layer.borderWidth = 5
            cell?.contentView.layer.borderColor = UIColor.black.cgColor
            mealSelect = true
        } else {
            let name = viewModel.categoriesDink[indexPath.row].nameDrink
            print(name)
            cell?.contentView.layer.borderWidth = 5
            cell?.contentView.layer.borderColor = UIColor.blue.cgColor
            drinkSelect = true
        }
        if mealSelect == true {
            if drinkSelect == true {
                generateBT.isEnabled = true
                generateBT.backgroundColor = .blue
            }
        }
    }
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        if indexPath.section == 0 {
            cell?.contentView.layer.borderWidth = 0
        } else {
            cell?.contentView.layer.borderWidth = 0
        }
        
    }
    
    
}
