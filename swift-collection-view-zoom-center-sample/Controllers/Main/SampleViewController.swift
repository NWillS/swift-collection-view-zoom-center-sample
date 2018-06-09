//
//  SampleViewController.swift
//  swift-collection-view-zoom-center-sample
//
//  Created by devWill on 2018/06/09.
//  Copyright © 2018年 devWill. All rights reserved.
//

import UIKit

class SampleViewController: UIViewController {
        let dataSource = SampleCollectionViewProvider()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let nib = UINib(nibName: "SampleCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "SampleCollectionViewCell")
        
        collectionView.dataSource = dataSource
        collectionView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension SampleViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
}
