//
//  ViewController.m
//  HTMLParsing
//
//  Created by Arun Sivakumar on 10/12/16.
//  Copyright © 2016 Arun. All rights reserved.
//

#import "ViewController.h"
#import "TFHpple.h"
#import <WebKit/WebKit.h>

@interface ViewController ()
//@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (nonatomic, readonly) WKWebView *webView;

@end

@implementation ViewController

- (WKWebView *)webView {
    return  (WKWebView *)self.view;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    [self loadTutorials];
//    self.webView.delegate = self;
    NSURL *url = [NSURL URLWithString:@"https://www.google.com"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//    [self.webView setScalesPageToFit:YES];
    [self.webView loadRequest:request];
    
}

- (void)loadView {
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    
    [self addUserScriptsToUserContentController:configuration.userContentController];
    
    WKWebView *webView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:configuration];
    
    self.view = webView;
}

- (void)addUserScriptsToUserContentController:(WKUserContentController *)userContentController {

    
    NSString *fetchTableOfContentsScriptString = [NSString stringWithContentsOfURL:[[NSBundle mainBundle] URLForResource:@"Image" withExtension:@"js"] encoding:NSUTF8StringEncoding error:NULL];
    
    WKUserScript *fetchTableOfContentsScript = [[WKUserScript alloc] initWithSource:fetchTableOfContentsScriptString injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
    [userContentController addUserScript:fetchTableOfContentsScript];
    
    [userContentController addScriptMessageHandler:self name:@"didFetchTableOfContents"];
}

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
//    if ([message.name isEqual:@"didFetchTableOfContents"])
        NSLog(@"Message: %@",message.body);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (void)loadTutorials {
//    // 1
//    NSURL *tutorialsUrl = [NSURL URLWithString:@"http://www.forever21.com/Product/Product.aspx?BR=f21&Category=app-main&ProductID=2000234136&VariantID="];
//    NSData *tutorialsHtmlData = [NSData dataWithContentsOfURL:tutorialsUrl];
//    
//    // 2
//    TFHpple *tutorialsParser = [TFHpple hppleWithHTMLData:tutorialsHtmlData];
//    
//    // 3
//    NSString *tutorialsXpathQueryString = @"//img";
//    NSArray *tutorialsNodes = [tutorialsParser searchWithXPathQuery:tutorialsXpathQueryString];
//    
//    // 4
//    NSMutableArray *newTutorials = [[NSMutableArray alloc] initWithCapacity:0];
//    for (TFHppleElement *element in tutorialsNodes) {
//        NSLog(@"%@",element);
//        
//    }
//
//}
@end
