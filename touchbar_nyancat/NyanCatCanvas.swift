//
//  NyanCatCanvas.swift
//  touchbar_nyancat
//
//  Created by Aslan Vatsaev on 05/11/2016.
//  Copyright © 2016 AVatsaev. All rights reserved.
//

import Cocoa

class NyanCatCanvas: NSImageView {
    @objc var timer:Timer? = nil

    @objc var xPosition: CGFloat = -680 {
        didSet {
            self.frame = CGRect(x: xPosition, y: 0, width: 680, height: 30)
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.animates = true
        self.canDrawSubviewsIntoLayer = true
        
        self.loadLocalImage()
        
        if self.timer == nil {
            timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.moveNyancat), userInfo: nil, repeats: true)
        }
    }

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
    }
    
    override func touchesBegan(with event: NSEvent) {
        // Calling super causes the cat to jump back to its original position 🤔
        //super.touchesBegan(with: event)
    }
    
    
    var direction: CGFloat = 1
    @objc public func moveNyancat() {
        xPosition += direction
        if xPosition > 0 {
            direction = -1
        } else if xPosition < -680 {
            direction = 1
        }
    }

    func loadLocalImage() {
        if let imagePath = Bundle.main.path(forResource: "nyancat", ofType: "gif"),
           let data = try? Data(contentsOf: URL(fileURLWithPath: imagePath)) {
            self.image = NSImage(data: data)
        }
    }
    

    
    override func touchesMoved(with event: NSEvent) {
        if #available(OSX 10.12.2, *) {
            let current = event.allTouches().first?.location(in: self).x ?? 0
            let previous = event.allTouches().first?.previousLocation(in: self).x ?? 0
        
            let dX = (current - previous)
            
            xPosition += dX
        }
    }
    
}
