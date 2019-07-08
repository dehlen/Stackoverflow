import AppKit

// MARK: - NSRect Extension
extension NSRect {
    var flippedScreenBounds: NSRect {
        let screenHeight = NSScreen.screens.first?.frame.maxY ?? 0
        var flippedBounds = self
        flippedBounds.origin.y = screenHeight - maxY

        return flippedBounds
    }
}
