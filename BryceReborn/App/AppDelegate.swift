import AppKit

@main
class AppDelegate: NSObject, NSApplicationDelegate {

    var mainWindow: BryceMainWindow?

    func applicationDidFinishLaunching(_ notification: Notification) {
        // Create the main window
        let windowRect = NSRect(
            x: 0, y: 0,
            width: BryceMetrics.defaultWindowSize.width,
            height: BryceMetrics.defaultWindowSize.height
        )

        mainWindow = BryceMainWindow(
            contentRect: windowRect,
            styleMask: [],
            backing: .buffered,
            defer: false
        )

        mainWindow?.center()
        mainWindow?.makeKeyAndOrderFront(nil)
    }

    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true
    }
}
