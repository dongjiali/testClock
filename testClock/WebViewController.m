//
//  WebViewController.m
//  testClock
//
//  Created by Curry on 13-8-19.
//  Copyright (c) 2013年 刘晨光. All rights reserved.
//

#import "WebViewController.h"
#import "Utils.h"
@interface WebViewController (){
    int totalPage;
}
@end    

@implementation WebViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    UIWebView *webview = [[UIWebView alloc]initWithFrame:self.view.frame];
//    [webview setBackgroundColor:[UIColor clearColor]];
//    [webview setOpaque:NO];//使网页透明
//    [webview setDelegate:self];
//    webview.scalesPageToFit = YES;
//    [self.view addSubview:webview];
//    
//    [self loadDocument:@"OpenGL.pdf" inView:webview];

    
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"OpenGL.pdf" ofType:nil];
//    NSURL *url = [NSURL fileURLWithPath:@"OpenGL.pdf"];
    
//
//    UIDocumentInteractionController *documentController = [UIDocumentInteractionController interactionControllerWithURL:url];
//    documentController.delegate = self;
//    [documentController retain];
////    documentController.UTI = @"OpenGL.pdf";
//    [documentController presentOpenInMenuFromRect:CGRectZero
//                                           inView:self.view
//                                         animated:YES];
    NSMutableArray *pdfArray = [[NSMutableArray alloc]init];
    CGPDFDocumentRef pdf = [self createPDFFromExistFile:[[NSBundle mainBundle] pathForResource:@"OpenGL.pdf" ofType:nil]];
    for (int pageIndex = 1; pageIndex <= totalPage; pageIndex++)
    {
        CGImageRef imageRef = PDFPageToCGImage(pageIndex,pdf);
        UIImage *pdfImg = [[UIImage alloc] initWithCGImage:imageRef];
        [pdfArray addObject:pdfImg];
        CGImageRelease(imageRef);
        [pdfImg release];   
        imageRef = nil;
    }
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
    [imageView setImage:[pdfArray objectAtIndex:0]];
    NSLog(@"%d,%f,%f,%f,%f",pdfArray.count,self.view.bounds.origin.x,self.view.bounds.origin.y,self.view.bounds.size.width,self.view.bounds.size.height);
    [self.view addSubview:imageView];
    [imageView release];
}

//判断pdf文件是否存在
-(CGPDFDocumentRef)createPDFFromExistFile:(NSString *)aFilePath
{
    CFStringRef path;
    CFURLRef url;
    CGPDFDocumentRef document;
    path = CFStringCreateWithCString(NULL, [aFilePath UTF8String], kCFStringEncodingUTF8);
    url = CFURLCreateWithFileSystemPath(NULL, path, kCFURLPOSIXPathStyle, NO);
    CFRelease(path);
    document = CGPDFDocumentCreateWithURL(url);
    CFRelease(url);
    int count = CGPDFDocumentGetNumberOfPages (document);
    //文档中一共有多少页，设置一个变量存储
    totalPage = count;
    if (count == 0)
    {
        return nil;
    }
    else
    {
        return document ;
    }
}


-(void)loadDocument:(NSString*)documentName inView:(UIWebView*)webView
{
    NSString *path = [[NSBundle mainBundle] pathForResource:documentName ofType:nil];
    NSURL *url = [NSURL fileURLWithPath:path];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
}

//开始加载数据
- (void)webViewDidStartLoad:(UIWebView *)webView {

}

//数据加载完
- (void)webViewDidFinishLoad:(UIWebView *)webView {
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
