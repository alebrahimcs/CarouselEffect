//
//  customFlowLayout.swift
//  CarouselTest
//
//  Created by Ali Alibrahim on 8/11/16.
//  Copyright © 2016 Ali Alebrahim. All rights reserved.
//

import UIKit

class customFlowLayout: UICollectionViewFlowLayout {
    
    override func targetContentOffsetForProposedContentOffset(proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        
        if let cv = self.collectionView {
            
            let cvBounds = cv.bounds
            let halfWidth = cvBounds.size.width * 0.5;
            let proposedContentOffsetCenterX = proposedContentOffset.x + halfWidth;
            
            if let attributesForVisibleCells = self.layoutAttributesForElementsInRect(cvBounds) {
                
                var candidateAttributes : UICollectionViewLayoutAttributes?
                for attributes in attributesForVisibleCells {
                    
                    // == Skip comparison with non-cell items (headers and footers) == //
                    if attributes.representedElementCategory != UICollectionElementCategory.Cell {
                        continue
                    }
                    
                    if let candAttrs = candidateAttributes {
                        
                        let a = attributes.center.x - proposedContentOffsetCenterX
                        let b = candAttrs.center.x - proposedContentOffsetCenterX
                        
                        if fabsf(Float(a)) < fabsf(Float(b)) {
                            candidateAttributes = attributes;
                        }
                        
                    }
                    else { // == First time in the loop == //
                        
                        candidateAttributes = attributes;
                        continue;
                    }
                    
                    
                }
                
                return CGPoint(x : candidateAttributes!.center.x - halfWidth, y : proposedContentOffset.y);
                
            }
            
        }
        
        // Fallback
        return super.targetContentOffsetForProposedContentOffset(proposedContentOffset)
    }


}



/*
 //
 //  ViewController.swift
 //  CarouselTest
 //
 //  Created by Ali Alibrahim on 8/11/16.
 //  Copyright © 2016 Ali Alebrahim. All rights reserved.
 //
 
 import UIKit
 import Foundation
 
 
 class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
 var cellWidth: CGFloat!
 var cellHeight: CGFloat!
 var isFirstTimeTransform: Bool!
 let TRANSFORM_CELL_VALUE = CGAffineTransformMakeScale(0.8, 0.8)
 let ANIMATION_SPEED = 0.2
 
 @IBOutlet weak var testing: UICollectionView!
 
 override func viewDidLoad() {
 super.viewDidLoad()
 isFirstTimeTransform = true
 testing.delegate = self
 testing.dataSource = self
 
 }
 override func viewDidLayoutSubviews() {
 super.viewDidLayoutSubviews()
 
 }
 override func didReceiveMemoryWarning() {
 super.didReceiveMemoryWarning()
 }
 
 func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
 return 1
 }
 func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
 return 15
 }
 func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
 let cell = testing.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath)
 
 //////////////////////////////////////////////////////////////////
 if indexPath.row == 0 && isFirstTimeTransform {
 isFirstTimeTransform = false
 }else {
 cell.transform = TRANSFORM_CELL_VALUE
 }
 /////////////////////////////////////////////////////////////////
 
 return cell
 }
 
 func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
 cellWidth = collectionView.frame.size.width-60
 cellHeight = collectionView.frame.size.height/2
 return CGSize(width: cellWidth, height: cellHeight)
 }
 func scrollViewWillEndDragging(scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
 let pageWidth: Float = Float(view.frame.size.width + 30)
 let currentOffset: Float = Float(scrollView.contentOffset.x)
 let targetOffset:Float = Float(targetContentOffset.memory.x)
 var newTargetOffset: Float = 0
 
 if targetOffset > currentOffset {
 newTargetOffset = ceilf(currentOffset / pageWidth) * pageWidth
 }else {
 newTargetOffset = floorf(currentOffset / pageWidth) * pageWidth
 }
 
 if newTargetOffset < 0 {
 newTargetOffset = Float(0)
 }else if newTargetOffset > Float(scrollView.contentSize.width) {
 newTargetOffset = Float(scrollView.contentSize.width)
 }
 
 targetContentOffset.memory.x = CGFloat(currentOffset)
 scrollView.setContentOffset(CGPointMake(CGFloat(newTargetOffset), 0), animated: true)
 
 var index = Int(newTargetOffset/pageWidth)
 
 if index == 0{
 var cell = testing.cellForItemAtIndexPath(NSIndexPath(forItem: index, inSection: 0))
 UIView.animateWithDuration(ANIMATION_SPEED, animations: {
 cell?.transform = CGAffineTransformIdentity
 })
 
 cell = testing.cellForItemAtIndexPath(NSIndexPath(forItem: index+1, inSection: 0))
 UIView.animateWithDuration(ANIMATION_SPEED, animations: {
 cell?.transform = self.TRANSFORM_CELL_VALUE
 })
 }else {
 var cell = testing.cellForItemAtIndexPath(NSIndexPath(forItem: index, inSection: 0))
 UIView.animateWithDuration(ANIMATION_SPEED, animations: {
 cell?.transform = CGAffineTransformIdentity
 })
 
 index = index - 1
 cell = testing.cellForItemAtIndexPath(NSIndexPath(forItem: index, inSection: 0))
 UIView.animateWithDuration(ANIMATION_SPEED, animations: {
 cell?.transform = self.TRANSFORM_CELL_VALUE
 })
 
 index = index + 2
 cell = testing.cellForItemAtIndexPath(NSIndexPath(forItem: index, inSection: 0))
 UIView.animateWithDuration(ANIMATION_SPEED, animations: {
 cell?.transform = self.TRANSFORM_CELL_VALUE
 })
 }
 
 
 
 
 
 }
 
 
 }
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 

 */
