//
//  MyDataController.swift
//  Money Maker 4
//
//  Created by cedric tape on 2/12/17.
//  Copyright © 2017 cedric tape. All rights reserved.
//

import UIKit

class MyDataController: NSObject, UICollectionViewDataSource, UICollectionViewDelegate {
    
    
    var cellLabels = [UILabel]()
	let labels: [String] = ["Menu", "Refresh", "C", "÷", "1", "2", "3", "×", "4", "5", "6", "-", "7", "8", "9", "+", "0", ".", "="]

    // all collection view stuff here
    var collectionFrame: CGRect?
    init(myFrame: CGRect) {
		super.init()
        collectionFrame = myFrame
        // creates the keypad labels
		
		
        for label in labels{
            let newUILabel = UILabel()
            newUILabel.text = label
            newUILabel.textAlignment = NSTextAlignment.center
//			let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.digitAction(_:)))
//			newUILabel.isUserInteractionEnabled = true
//			newUILabel.addGestureRecognizer(tapGesture)
			
            cellLabels.append(newUILabel)
        }
		
		
    }
    // required data source methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellLabels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
//		let tapGesture = UITapGestureRecognizer(target: collectionView, action: #selector(self.digitAction(_:)))
//		tapGesture.numberOfTapsRequired = 1
//		cellLabels[indexPath.row].isUserInteractionEnabled = true
//		cellLabels[indexPath.row].addGestureRecognizer(tapGesture)
        cell.backgroundView = cellLabels[indexPath.row]
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 0.5//(1/750) * UIScreen.main.bounds.width
		print("##############")
		print("cell index: \(indexPath.section):\(indexPath.row)")
		print("cell origin: \(cell.frame.origin.x), \(cell.frame.origin.y)")
		print("cell width: \(cell.frame.width)")
		print("cell height: \(cell.frame.height)")
                //print("cell collectionview layout origin: \(collectionView.collectionViewLayout.layoutAttributesForItemAtIndexPath(indexPath).frame.origin)")
                //print("collection width: \(collectionFrame!.width % 4)")
		
		
		print("collection view heigh: \(collectionView.bounds.height)")
		print("collection view width: \(collectionView.bounds.width)")
		print("collection view section: \(collectionView.numberOfSections)")
		
        return cell
    }
    // implementation of non required method to identify the size of the cells
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize {
        var itemWidth,itemHeight: CGFloat
        //setting hight and width of keypad cells based on the relatinve size of the parent view
		
		itemHeight = collectionFrame!.height / 10
		
        if(indexPath.row == 16){
            itemWidth = (collectionFrame!.width / 2)//.rounded(.towardZero)
        }
        else{
            itemWidth = (collectionFrame!.width / 4)//.rounded(.towardZero)
        }
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
    // method to create the keypad labels
	func digitAction(_ sender: UITapGestureRecognizer) -> String{
		let n = sender.view as! UICollectionView 
		let b = n.indexPathForItem(at: sender.location(in: sender.view))
		return labels[(b?.row)!]
    }
	
//	func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout,insetForSectionAt section: Int) -> UIEdgeInsets {
//		return UIEdgeInsetsMake(0, 0, 0, 0)
//	}
//	
//	
//	func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout,minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//		return 0.0
//	}
//	
//	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//		return 0.0
//	}
	
}

