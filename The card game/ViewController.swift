//
//  ViewController.swift
//  The card game
//
//  Created by xuantien on 08/07/2021.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource,UICollectionViewDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let model = CardModel()
    var cardsArray = [Card]()
    var firstFlippedCardIndex: IndexPath?

    override func viewDidLoad() {
        super.viewDidLoad()
        
   cardsArray = model.getCard()
        // Do any additional setup after loading the view.
        ///???????
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return cardsArray.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath) as! CardCollectionViewCell
            
            
            let card = cardsArray[indexPath.row]
            
            cell.configureCell(card: card)
            return cell
            
        }
        
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
      let cell =  collectionView.cellForItem(at: indexPath) as? CardCollectionViewCell
        
        
        if cell?.card?.isFlipped == false{
            cell?.flipUp(time: 0.3)
            
            if firstFlippedCardIndex == nil {
                
                firstFlippedCardIndex = indexPath
            }else{
                
                checkForMatch(indexPath)
            }
            

        }
        
    }
    
    // - Game Logic Methods
    
    func checkForMatch(_ seconFlippedCardIndex:IndexPath){
        // Get the two card object for the two indices and see if they match
        
        let cardOne = cardsArray[firstFlippedCardIndex!.row]
        let cardTwo = cardsArray[seconFlippedCardIndex.row]
        
        
        
        let cardOneCell = collectionView.cellForItem(at: firstFlippedCardIndex!) as? CardCollectionViewCell

        let cardTwoCell =  collectionView.cellForItem(at: seconFlippedCardIndex)  as? CardCollectionViewCell
        
        if cardOne.imageName == cardTwo.imageName {
            cardOne.isMatched = true
            cardTwo.isMatched = true
            
            cardOneCell?.remove()
            cardTwoCell?.remove()
            
        }else{
            
            cardOneCell?.flipDown(time: 0.3)
            cardTwoCell?.flipDown(time: 0.3)
        }
        firstFlippedCardIndex = nil
    }
}

