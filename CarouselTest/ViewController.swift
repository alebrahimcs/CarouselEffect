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
    let ANIMATION_SPEED = 0.25
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        isFirstTimeTransform = true
        collectionView.delegate = self
        collectionView.dataSource = self
        let nibFile = UINib(nibName: "Cell", bundle: nil)
        collectionView.registerNib(nibFile, forCellWithReuseIdentifier: "Cell")
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
//        collectionView.scrollToItemAtIndexPath(NSIndexPath(forItem: 5, inSection: 0), atScrollPosition: UICollectionViewScrollPosition.CenteredHorizontally, animated: true)
    }
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 15
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath)
        
        //////////////////////////////////////////////////////////////////
        if indexPath.row == 0 && isFirstTimeTransform { //prevent to load scaling transform on the first cell for the first time only
            isFirstTimeTransform = false
        }else {
            cell.transform = TRANSFORM_CELL_VALUE
        }
        /////////////////////////////////////////////////////////////////
        
        return cell
    }
    func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView) {
        //access this if its from button.
//        let cell = collectionView.cellForItemAtIndexPath(NSIndexPath(forItem: 5, inSection: 0))
//        cell?.transform = CGAffineTransformIdentity
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        //setting cell width and height
        cellWidth = collectionView.frame.size.width-100
        cellHeight = collectionView.frame.size.height - collectionView.frame.size.height/4
        return CGSize(width: cellWidth, height: cellHeight)
    }
    func scrollViewWillEndDragging(scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {

        let pageWidth: Float = Float(cellWidth+30) //pageWidth = cellWidth + spacing(spacing set in the storyboard)
        let currentOffset: Float = Float(scrollView.contentOffset.x)
        let targetOffset:Float = Float(targetContentOffset.memory.x)
        var newTargetOffset: Float = 0
        
        if targetOffset > currentOffset {
            newTargetOffset = ceilf(currentOffset / pageWidth) * pageWidth + 10 //10 is the min spacing
        }else {
            newTargetOffset = floorf(currentOffset / pageWidth) * pageWidth + 10 //10 is the min spacing
        }
        
        if newTargetOffset < 0 {
            newTargetOffset = Float(0) //to keep first cell in place and not to scroll beyond it
        }else if newTargetOffset > Float(scrollView.contentSize.width) {
            newTargetOffset = Float(scrollView.contentSize.width) //to keep last cell in place and not to scroll beyond it
        }
        
        targetContentOffset.memory.x = CGFloat(currentOffset)
        scrollView.setContentOffset(CGPointMake(CGFloat(newTargetOffset), 0), animated: true)
        
        var index = Int(newTargetOffset/pageWidth)
        
        if index == 0{
            var cell = collectionView.cellForItemAtIndexPath(NSIndexPath(forItem: index, inSection: 0))
            UIView.animateWithDuration(ANIMATION_SPEED, animations: { 
                cell?.transform = CGAffineTransformIdentity
            })
            
            cell = collectionView.cellForItemAtIndexPath(NSIndexPath(forItem: index+1, inSection: 0))
            UIView.animateWithDuration(ANIMATION_SPEED, animations: { 
                cell?.transform = self.TRANSFORM_CELL_VALUE
            })
        }else {
            var cell = collectionView.cellForItemAtIndexPath(NSIndexPath(forItem: index, inSection: 0))
            UIView.animateWithDuration(ANIMATION_SPEED, animations: { 
                cell?.transform = CGAffineTransformIdentity
            })
            
            index = index - 1
            cell = collectionView.cellForItemAtIndexPath(NSIndexPath(forItem: index, inSection: 0))
            UIView.animateWithDuration(ANIMATION_SPEED, animations: { 
                cell?.transform = self.TRANSFORM_CELL_VALUE
            })
            
            index = index + 2
            cell = collectionView.cellForItemAtIndexPath(NSIndexPath(forItem: index, inSection: 0))
            UIView.animateWithDuration(ANIMATION_SPEED, animations: {
                cell?.transform = self.TRANSFORM_CELL_VALUE
            })
        }

    }
    
    
}
