//
//  ViewController.swift
//  MyGesture
//
//  Created by student on 2018/11/22.
//  Copyright © 2018年 huxinqian. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var backView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    //添加
    @IBAction func add(_ sender: Any) {
        //随机位置
        let x = Int(arc4random()) % Int(self.backView.bounds.width)
        let y = Int(arc4random()) % Int(self.backView.bounds.height)
        let label = UILabel(frame: CGRect(x: x , y: y, width: 30, height: 30))
        
        //定义label
        label.text = "H"
        label.backgroundColor = UIColor.white
        label.textAlignment = .center
        
        //给label加阴影
        label.layer.shadowColor = UIColor.gray.cgColor
        label.layer.shadowOffset = CGSize(width: 5, height: 5)
        label.layer.shadowOpacity = 1
        
        //可以手动移动
        let panRecognizer = UIPanGestureRecognizer(target: self, action: #selector(pan(recognizer:)))
        label.addGestureRecognizer(panRecognizer)
        label.isUserInteractionEnabled = true
         //可以手动拍击
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(tap(recognizer:)))
        label.addGestureRecognizer(tapRecognizer)
        tapRecognizer.numberOfTapsRequired = 2
        //可以手动缩放
        let pinchRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(pinch(recognizer:)))
        self.backView.addGestureRecognizer(pinchRecognizer)
        //可以手动旋转
        let rotationRecognizer = UIRotationGestureRecognizer(target: self, action: #selector(rotation(recognizer:)))
        self.backView.addGestureRecognizer(rotationRecognizer)
        
        self.backView.addSubview(label)
    }
    
    @objc func pan(recognizer: UIPanGestureRecognizer) {
        if recognizer.state == .changed || recognizer.state == .ended {
            let translation = recognizer.translation(in: self.backView)
            self.backView.center.x += translation.x
            self.backView.center.y += translation.y
            recognizer.setTranslation(.zero, in: self.backView)
        }
    }
    
    @objc func pinch(recognizer:UIPinchGestureRecognizer) {
        if recognizer.state == .changed || recognizer.state == .ended {
            self.backView.bounds = CGRect(x: 0, y: 0, width: self.backView.bounds.width * recognizer.scale, height: self.backView.bounds.height * recognizer.scale)
            recognizer.scale = 1
        }
    }
    
    @objc func tap(recognizer: UITapGestureRecognizer) {
        if recognizer.state == .recognized {
            print("tap recognized")
        }
    }
    
    @objc func rotation(recognizer: UIRotationGestureRecognizer) {
        //let rotation = recognizer.rotation
        self.backView.transform = self.backView.transform.rotated(by: recognizer.rotation)
        recognizer.rotation = 0
    }
    
    
    //移动
    @IBAction func move(_ sender: Any) {
        for label in self.backView.subviews {
            if label is UILabel {
                UIView.animate(withDuration: 1) {
                    let x = Int(arc4random()) % Int(self.backView.bounds.width)
                    let y = Int(arc4random()) % Int(self.backView.bounds.height)
                    label.center = CGPoint(x: x, y: y)
                }
            }
        }
    }
    
    //删除
    @IBAction func del(_ sender: Any) {
        for label in self.backView.subviews {
            if label is UILabel {
                label.removeFromSuperview()
            }
        }
    }
    
}

