//
//  MealController.swift
//  Meal
//
//  Created by Ocean97 on 11/06/2023.
//

import UIKit

final class MealController: UIViewController {
    
    
    var viewModel: MealViewModelProtocol = MealViewModel()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var generateBT: UIButton!
    
    
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
        viewModel.startAPICall()
        viewModel.reloadData = {[weak self] in
            self?.collectionView.reloadData()
        }

    }
    
    func setupButton() {
        generateBT.layer.cornerRadius = 5
        viewModel.updateBTGenerate = {[weak self] in
            self?.generateBT.isEnabled = self?.viewModel.isChecked() ?? false
            self?.generateBT.backgroundColor = self?.viewModel.isChecked() ?? false ? .blue : .secondaryLabel
            
        }
       
    }
    
    @IBAction func tapOnGenerate(_ sender: Any) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(identifier: "generateVC")
        navigationController?.pushViewController(vc, animated: true)
    }
}


extension MealController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.numberOfSections
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItemsInSection(section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mealCategoriesCell", for: indexPath) as! MealCategoriesCell
        cell.categoriesName.text = viewModel.getCategoriesNameForCell(index: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionView.elementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath) as! Header
            header.lbHeader.text = viewModel.headerTitle(index: indexPath)
            return header
        } else {
            return UICollectionReusableView()
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let w = collectionView.frame.width
        return CGSize(width: w, height: 50)

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let w = (view.frame.width - 20) / 3
        return CGSize(width: w, height: w)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        viewModel.isSelectCell(index: collectionView.indexPathsForSelectedItems!.count)
        viewModel.getCategoriesName(index: indexPath)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        viewModel.isSelectCell(index: collectionView.indexPathsForSelectedItems!.count)
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        
        collectionView.indexPathsForSelectedItems?.filter({ $0.section == indexPath.section }).forEach({ collectionView.deselectItem(at: $0, animated: false) })

        return true
    }
    
}
