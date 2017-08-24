import UIKit
import WebKit

class ViewController: UIViewController, WKScriptMessageHandler {
    
    @IBOutlet var containerView : UIView! = nil
    var webView: WKWebView?
    
    
    override func loadView() {
        super.loadView()
        
        let contentController = WKUserContentController();
        let fetchTableOfContentsScriptString = try! String(contentsOf: Bundle.main.url(forResource: "Image", withExtension: "js")!, encoding: String.Encoding.utf8)
        print(fetchTableOfContentsScriptString)

        let userScript = WKUserScript(
            source: fetchTableOfContentsScriptString,
            injectionTime: WKUserScriptInjectionTime.atDocumentEnd,
            forMainFrameOnly: true
        )
        contentController.addUserScript(userScript)
        contentController.add(
            self,
            name: "callbackHandler"
        )
        
        let config = WKWebViewConfiguration()
        config.userContentController = contentController
        
        
        self.webView = WKWebView(
            frame: self.containerView.bounds,
            configuration: config
        )
        self.view = self.webView!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = NSURL(string:"https://www.nike.com")
        let req = NSURLRequest(url:url as! URL)
        self.webView!.load(req as URLRequest)
    }
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if(message.name == "callbackHandler") {
            print("JavaScript is sending a message \(message.body)")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
