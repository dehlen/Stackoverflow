//
//  ViewController.swift
//  Capture
//
//  Created by Ehlen, David on 08.07.19.
//  Copyright © 2019 David Ehlen. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    private lazy var window: NSWindow = self.view.window!
    private var highlightWindowController: HighlightWindowController?
    private var mouseLocation: NSPoint = NSEvent.mouseLocation {
        didSet {
            //TODO: don't highlight if its the same window
            if let window = WindowList.window(at: mouseLocation), !window.isCapture {
                highlight(window: window)
            } else {
                removeHighlight()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        registerMouseEvents()
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    private func registerMouseEvents() {
        NSEvent.addLocalMonitorForEvents(matching: [.mouseMoved]) {
            self.mouseLocation = NSEvent.mouseLocation
            return $0
        }
        NSEvent.addGlobalMonitorForEvents(matching: [.mouseMoved]) { _ in
            self.mouseLocation = NSEvent.mouseLocation
        }
    }

    private func removeHighlight() {
        highlightWindowController?.close()
        highlightWindowController = nil
    }

    private func highlight(window: Window) {
        removeHighlight()
        highlightWindowController = HighlightWindowController()
        highlightWindowController?.highlight(frame: window.frame, animate: false)
        highlightWindowController?.showWindow(nil)
    }
}
