import UIKit
import PlaygroundSupport

class MyViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Main view
        view.backgroundColor = .black
        view.frame = CGRect(x: 0, y: 0, width: 500, height: 500)

        // Red view
        let redView = UIView(frame: CGRect(x: 20, y: 20, width: 460, height: 460))
        redView.backgroundColor = .red
        view.addSubview(redView)

        // Blue view
        let blueView = UIView(frame: CGRect(x: 20, y: 20, width: 420, height: 420))
        blueView.backgroundColor = .blue
        redView.addSubview(blueView)

        // Orange view
        let orangeView = UIView(frame: CGRect(x: 20, y: 20, width: 380, height: 380))
        orangeView.backgroundColor = .orange
        blueView.addSubview(orangeView)

        // Yellow view
        let yellowView = UIView(frame: CGRect(x: 20, y: 20, width: 340, height: 100))
        yellowView.backgroundColor = .yellow
        orangeView.addSubview(yellowView)


        // Let's try to convert now
        var resultFrame = CGRect.zero
        let randomRect: CGRect = CGRect(x: 0, y: 0, width: 100, height: 50)

        /*
        func convert(CGRect, from: UIView?)
        Converts a rectangle from the coordinate system of another view to that of the receiver.
        */

        // The following line converts a rectangle (randomRect) from the coordinate system of yellowView to that of self.view:
        resultFrame = view.convert(yellowView.frame, from: yellowView.superview!)

        // Try also one of the following to get a feeling of how it works:
        // resultFrame = view.convert(randomRect, from: orangeView)
        // resultFrame = view.convert(randomRect, from: redView)
        // resultFrame = view.convert(randomRect, from: nil)

        /*
        func convert(CGRect, to: UIView?)
        Converts a rectangle from the receiver’s coordinate system to that of another view.
        */

        // The following line converts a rectangle (randomRect) from the coordinate system of yellowView to that of self.view
        //resultFrame = yellowView.convert(randomRect, to: view)
        // Same as what we did above, using "from:"
        // resultFrame = view.convert(randomRect, from: yellowView)

        // Also try:
        // resultFrame = orangeView.convert(randomRect, to: view)
        // resultFrame = redView.convert(randomRect, to: view)
        // resultFrame = orangeView.convert(randomRect, to: nil)
        print(resultFrame)

        // Add an overlay with the calculated frame to self.view
        let overlay = UIView(frame: resultFrame)
        overlay.backgroundColor = UIColor(white: 1.0, alpha: 0.9)
        overlay.layer.borderColor = UIColor.black.cgColor
        overlay.layer.borderWidth = 1.0
        view.addSubview(overlay)
    }
}

var ctrl = MyViewController()
PlaygroundPage.current.liveView = ctrl.view
