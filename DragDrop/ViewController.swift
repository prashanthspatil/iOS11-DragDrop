//
//  ViewController.swift
//  DragDrop
//
//  Created by Prashanth on 15/06/17.
//  Copyright © 2017 Prashanth. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIDropInteractionDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.addInteraction(UIDropInteraction(delegate:self))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func dropInteraction(_ interaction: UIDropInteraction, canHandle session: UIDropSession) -> Bool {
        return session.canLoadObjects(ofClass: UIImage.self)
    }
    
    func dropInteraction(_ interaction: UIDropInteraction, sessionDidUpdate session: UIDropSession) -> UIDropProposal {
        return UIDropProposal(operation: .copy)
    }
    
    func dropInteraction(_ interaction: UIDropInteraction, performDrop session: UIDropSession) {
        for dragItem in session.items {
            dragItem.itemProvider.loadObject(ofClass: UIImage.self, completionHandler: { (provider, error) in
                if let dropError = error {
                    print("failed to drop \(dropError.localizedDescription)")
                }
                guard let draggedImage = provider as? UIImage else { return }
                DispatchQueue.main.async {
                    let dragImage = UIImageView.init(image: draggedImage)
                    self.view.addSubview(dragImage)
                    dragImage.frame = CGRect(x: 0, y: 0, width: draggedImage.size.width, height: draggedImage.size.height)
                    dragImage.center = session.location(in: self.view)
                }
            })
        }
    }
}
