//
//  ViewController.swift
//  Money Maker 4
//
//  Created by cedric tape on 2/12/17.
//  Copyright © 2017 cedric tape. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var screenView: [UIView] = []
	let screen = UIView()
	var holdingViews = [UIView]()
	var screenPairs = [[UILabel]]()
	let keyPad = UIView()
	var dataList = screenContent(titles: ["PV","FV","PMT","PERIOD","RATE","TYPE"], values: [500000000,-1.5,12.33333,-450000.0,0.054467,0.0])
    var calculator = simpleCalculator()
	var currentPair = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.view.translatesAutoresizingMaskIntoConstraints = false
        
        
        screen.translatesAutoresizingMaskIntoConstraints = false
        screen.backgroundColor = UIColor.red
        self.view.addSubview(screen)
		var constrainsScreen = [NSLayoutAttribute : (view: UIView, attribute: NSLayoutAttribute, multiple: CGFloat, constant: CGFloat)]()
		constrainsScreen[.left] = (view: screen.superview!, attribute: .left, multiple: 1.0, constant: 0)
		constrainsScreen[.top] = (view: screen.superview!, attribute: .top, multiple: 1.0, constant: 0)
		constrainsScreen[.right] = (view: screen.superview!, attribute: .right, multiple: 1.0, constant: 0)
		constrainsScreen[.width] = (view: screen.superview!, attribute: .width, multiple: 1.0, constant: 0)
		constrainsScreen[.height] = (view: screen.superview!, attribute: .height, multiple: 0.5, constant: 0)
		constrainView(screen, viewDictionary: constrainsScreen)
		
		
		for num in 1...6{
			holdingViews.append(UIView())
			let currentView = holdingViews[num - 1]
			
			let r = CGFloat(36 + (num - 1) * 10) / 255.0
			let g = CGFloat(133 + (num - 1) * 10) / 255.0
			let b = CGFloat(139 + (num - 1) * 10) / 255.0
			currentView.backgroundColor = UIColor(red: r, green: g, blue: b, alpha: 1)
			currentView.translatesAutoresizingMaskIntoConstraints = false
			screen.addSubview(currentView)
			var constrains = [NSLayoutAttribute : (view: UIView, attribute: NSLayoutAttribute, multiple: CGFloat, constant: CGFloat)]()
			constrains[.left] = (view: currentView.superview!, attribute: .left, multiple: 1.0, constant: 0)
			constrains[.right] = (view: currentView.superview!, attribute: .right, multiple: 1.0, constant: 0)
			constrains[.width] = (view: currentView.superview!, attribute: .width, multiple: 1.0, constant: 0)

			if (num == 1){
				constrains[.top] = (view: currentView.superview!, attribute: .top, multiple: 1.0, constant: 0)
				constrains[.height] = (view: currentView.superview!, attribute: .height, multiple: 0.2, constant: 0)
			}
			else{
				let previousView = holdingViews[num - 2]
				constrains[.top] = (view: previousView, attribute: .bottom, multiple: 1.0, constant: 0)
				constrains[.height] = (view: currentView.superview!, attribute: .height, multiple: 0.16, constant: 0)
			}
			constrainView(currentView, viewDictionary: constrains)
			
		}
		for num in 1...holdingViews.count{
			screenPairs.append([UILabel]())
			for i in 0...1{
				screenPairs[num - 1].append(UILabel())
				screenPairs[num - 1][i].translatesAutoresizingMaskIntoConstraints = false
				screenPairs[num - 1][i].attributedText = dataList.contentArray[num - 1][i]
				holdingViews[num - 1].addSubview(screenPairs[num - 1][i])
				var constrains = [NSLayoutAttribute : (view: UIView, attribute: NSLayoutAttribute, multiple: CGFloat, constant: CGFloat)]()
				constrains[.top] = (view: screenPairs[num - 1][i].superview!, attribute: .top, multiple: 1.0, constant: 0)
				constrains[.width] = (view: screenPairs[num - 1][i].superview!, attribute: .width, multiple: 0.5, constant: 0)
				constrains[.height] = (view: screenPairs[num - 1][i].superview!, attribute: .height, multiple: 1.0, constant: 0)
				if (i == 0){
					constrains[.left] = (view: screenPairs[num - 1][i].superview!, attribute: .left, multiple: 1.0, constant: 0)
				}
				else{
					constrains[.left] = (view: screenPairs[num - 1][i - 1], attribute: .right, multiple: 1.0, constant: 0)
				}
				constrainView(screenPairs[num - 1][i], viewDictionary: constrains)
			}
			
		}
		
		
		keyPad.translatesAutoresizingMaskIntoConstraints = false
		keyPad.backgroundColor = UIColor.orange
		self.view.addSubview(keyPad)
		var constrainskeypad = [NSLayoutAttribute : (view: UIView, attribute: NSLayoutAttribute, multiple: CGFloat, constant: CGFloat)]()
		constrainskeypad[.left] = (view: keyPad.superview!, attribute: .left, multiple: 1.0, constant: 0)
		constrainskeypad[.top] = (view: screen, attribute: .bottom, multiple: 1.0, constant: 0)
		constrainskeypad[.right] = (view: keyPad.superview!, attribute: .right, multiple: 1.0, constant: 0)
		constrainskeypad[.width] = (view: keyPad.superview!, attribute: .width, multiple: 1.0, constant: 0)
		constrainskeypad[.height] = (view: keyPad.superview!, attribute: .height, multiple: 0.5, constant: 0)
		constrainView(keyPad, viewDictionary: constrainskeypad)
		
		
		keyPad.addSubview(collectionView)
        
		print("##############")
		print("screen")
		print("screen origin: \(screen.frame.origin.x), \(screen.frame.origin.y)")
		print("screen width: \(screen.frame.width)")
		print("screen height: \(screen.frame.height)")
		
		print("##############")
		print("keypad")
		print("keypad origin: \(keyPad.frame.origin.x), \(keyPad.frame.origin.y)")
		print("keypad width: \(keyPad.frame.width)")
		print("keypad height: \(keyPad.frame.height)")
		
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
	func constrainView(_ item: UIView, viewDictionary: [NSLayoutAttribute : (view: UIView, attribute: NSLayoutAttribute, multiple: CGFloat, constant: CGFloat)]){
        
        for (key, value) in viewDictionary{
                NSLayoutConstraint.activate([(NSLayoutConstraint(item: item, attribute: key, relatedBy: .equal, toItem: value.view, attribute: value.attribute, multiplier: value.multiple, constant: value.constant))])
        }
        
        
        if(item.hasAmbiguousLayout){
            print("given view has ambiguous layout")
        }
        for value in viewDictionary.values{
                if(value.view.hasAmbiguousLayout){
                    print("a border has ambiguous layout")
                }
        }
		
    }
    
    
    
    lazy var collectionView: UICollectionView = {
        
        let layout = CustomViewFlowLayout()
		//let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
		let width = UIScreen.main.bounds.width
		let height = UIScreen.main.bounds.height
		layout.itemSize = CGSize(width: width / 4, height: height / 10)
        //var layoutFrame = CGRect(origin: CGPoint(x: 0, y: self.view.bounds.size.height / 2), size: CGSize(width: self.view.bounds.size.width, height: self.view.bounds.size.height / 2))
        var layoutFrame = self.view.frame
        let collectionView = UICollectionView(frame: layoutFrame, collectionViewLayout: layout)
        collectionView.dataSource = self.dataController
        collectionView.delegate = self.dataController
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView.backgroundColor = UIColor.yellow
        collectionView.translatesAutoresizingMaskIntoConstraints = false
		
		let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.keyboardAction(_:)))
		collectionView.isUserInteractionEnabled = true
		collectionView.addGestureRecognizer(tapGesture)
		
        return collectionView
    }()
    
    lazy var dataController: MyDataController = {
        
        let dataController = MyDataController(myFrame: self.view.frame)
        // more setup if needed
        
        return dataController
    }()
	
	@objc func keyboardAction(_ sender: UITapGestureRecognizer){
		calculator.parseKeyboardAction(data: dataController.digitAction(sender))
	}
	
}

class simpleCalculator{
	
	var pressedKey = String()
	var curCalKey = String()
	var numberInMemory: Double? = 0.0
	var n = 1.0
	var m = 0.0
	var isDecimalOn = false
	var numberStored: Double?
	
	init(){
		
	}
	
	func parseKeyboardAction(data: String){
		pressedKey = data
		switch(data){
			
			//"C", "÷", "1", "2", "3", "×", "4", "5", "6", "-", "7", "8", "9", "+", "0", ".", "="
		case "Menu": print("Menu Pressed!!")
		case "Refresh": refreshPressed()
		case "C": cancelPressed()
		case ".": decimalPressed()
		case "÷","×","-","+","=": operationPressed()
		default: Pressed()
		}
	}
	func menuPressed(){
		print("\(pressedKey) Pressed!!")
	}
	func refreshPressed(){
		print("\(pressedKey) Pressed!!")
	}
	func cancelPressed(){
		print("\(pressedKey) Pressed!!")
	}
	func operationPressed(){
		print("\(pressedKey) Pressed!!")
		switch(pressedKey){
			case "÷","×","-","+": curCalKey = pressedKey
			default: break
		}
		if(numberStored != nil && numberInMemory != nil){
			calculateTotal()
		}
		else{
			numberStored = numberInMemory
			numberInMemory = 0.0
			print("\(numberStored) Number Stored!!")
		}
	}
	func calculateTotal(){
		switch(curCalKey){
		case "÷":
			numberInMemory = numberStored! / numberInMemory!
			numberStored = nil
			print("\(numberInMemory) Number Stored!! and then erased")
		case "×":
			numberInMemory = numberStored! * numberInMemory!
			numberStored = nil
			print("\(numberInMemory) Number Stored!! and then erased")
		case "+":
			numberInMemory = numberStored! + numberInMemory!
			numberStored = nil
			print("\(numberInMemory) Number Stored!! and then erased")
		case "-":
			numberInMemory = numberStored! - numberInMemory!
			numberStored = nil
			print("\(numberInMemory) Number Stored!! and then erased")
		default:
			break
		}
	}
	func decimalPressed(){
		isDecimalOn = true
		if(m == 0.0){
			m -= 1
		}
	}
	func Pressed(){
		print("\(pressedKey) Pressed!!")
		numberInMemory = ((numberInMemory! * pow(10.0, n)) + Double(pressedKey)!) * pow(10.0, m)
		if (isDecimalOn){
			n += 1
			m -= 1
		}
		print("\(numberInMemory) Memory!!")
	}
}



class screenContent{
	var contentArray = [[NSAttributedString]]()
	var currencyFormatA = NumberFormatter()
	var currencyFormatB = NumberFormatter()
	var percentageFormat = NumberFormatter()
	var stringFormat = NumberFormatter()
	
	
	init(titles: [String], values: [Double]){
		
		currencyFormatA.numberStyle = .currency
		currencyFormatA.locale = Locale.current
		currencyFormatA.usesGroupingSeparator = true
		
		currencyFormatB.numberStyle = .scientific
		currencyFormatB.maximumIntegerDigits = 1
		currencyFormatB.minimumFractionDigits = 3
		currencyFormatB.maximumFractionDigits = 3
		
		percentageFormat.numberStyle = .percent
		percentageFormat.minimumFractionDigits = 2
		
		let paragraphStyle = NSMutableParagraphStyle()
		paragraphStyle.alignment = .right
		paragraphStyle.tailIndent = -15.0
		
		let textAttributes = [
			NSForegroundColorAttributeName: UIColor.white,
			NSParagraphStyleAttributeName: paragraphStyle
		]
		
		for n in 1...titles.count{
			let a = NSAttributedString(string: titles[n-1])
			var b = NSAttributedString()
			if(n == 5){
				b = NSAttributedString(string: formatter(myCase: "percent", num: values[n-1]*100), attributes: textAttributes)
			}
			else if (n == 6){
				if (values[n-1] == 0){
					b = NSAttributedString(string: "END", attributes: textAttributes)
				}
				else{
					b = NSAttributedString(string: "BEG", attributes: textAttributes)
				}
			}
			else{
				b = NSAttributedString(string: formatter(myCase: "number", num: values[n-1]), attributes: textAttributes)
			}
			contentArray.append([a,b])
		}
		
	}
	
	func formatter(myCase: String, num: Double)->String{
		var n = (num * 100).rounded() / 100
		switch myCase{
			case "number":
				if n < 100000000{
					return currencyFormatA.string(from: NSNumber(value: n))!
				}
				else{
					return currencyFormatB.string(from: NSNumber(value: n))!
				}
		default:
				return percentageFormat.string(from: NSNumber(value: n/100))!
			
		}
	}
	
}
// Subclassing UICollectionViewFlowLayout in order to overide the layoutAttributesForElements function to ensure that cell spacing is completely flush: http://stackoverflow.com/questions/19250284/ios-uicollectionview-spacing-still-there-when-set-to-0-how-to-set-with-no-sp/32225207#32225207
class CustomViewFlowLayout : UICollectionViewFlowLayout {
	
	let cellSpacing:CGFloat = 0
	
	override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
		if let attributes = super.layoutAttributesForElements(in: rect) {
			for (index, attribute) in attributes.enumerated() {
				if index == 0 { continue }
				let prevLayoutAttributes = attributes[index - 1]
				let originx = prevLayoutAttributes.frame.maxX
				
				if(originx + cellSpacing + attribute.frame.size.width < self.collectionViewContentSize.width) {
					attribute.frame.origin.x = originx + cellSpacing
				}
				if index < 4{continue}
				let originy = attributes[index - 4].frame.maxY
				if(originy + cellSpacing + attribute.frame.size.height < self.collectionViewContentSize.height) {
					attribute.frame.origin.y = originy + cellSpacing
				}
			}
			return attributes
		}
		return nil
	}
}

