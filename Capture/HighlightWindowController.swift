import AppKit

//TODO: detect mouse click to set recording to highlighted frame
class HighlightWindowController: NSWindowController, NSWindowDelegate {
    // MARK: - Initializers
    init() {
        let bounds = NSRect(x: 0, y: 0, width: 100, height: 100)
        let window = NSWindow(contentRect: bounds, styleMask: .borderless, backing: .buffered, defer: true)
        window.isOpaque = false
        window.level = .screenSaver
        window.backgroundColor = NSColor.blue
        window.alphaValue = 0.2
        window.ignoresMouseEvents = true
        super.init(window: window)
        window.delegate = self
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public API
    func highlight(frame: CGRect, animate: Bool) {
        if animate {
            NSAnimationContext.current.duration = 0.1
        }
        let target = animate ? window?.animator() : window
        target?.setFrame(frame, display: false)
    }
}
