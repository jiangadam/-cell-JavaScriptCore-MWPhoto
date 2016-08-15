//
//  YYShowController.m
//  自定义cell——text
//
//  Created by 蒋永忠 on 16/8/2.
//  Copyright © 2016年 chinamyo. All rights reserved.
//

#import "YYShowController.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "MWPhotoBrowser.h"

@interface YYShowController ()<UIWebViewDelegate, MWPhotoBrowserDelegate>
@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) JSContext *jsContext;

@property (nonatomic, strong) NSMutableArray *photos;

@end

@implementation YYShowController

- (UIWebView *)webView
{
    if (!_webView) {
        _webView = [[UIWebView alloc] init];
        _webView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    }
    return _webView;
}

- (NSMutableArray *)photos
{
    if (!_photos) {
        _photos = [NSMutableArray array];
    }
    return _photos;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.webView];
    NSURL *u = [NSURL URLWithString:self.url];
    [self.webView loadRequest:[NSURLRequest requestWithURL:u]];
    
    self.webView.delegate = self;
    
    self.title = @"JS OC 交互";
    self.navigationItem.backBarButtonItem.title = @"back";
    
    
    UIBarButtonItem *reload = [[UIBarButtonItem alloc] initWithTitle:@"Reload" style:UIBarButtonItemStyleDone target:self action:@selector(reloadData)];
    self.navigationItem.rightBarButtonItem = reload;
}

- (void) reloadData{
    [self.webView reload];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    if (self.jsContext == nil) {
        self.jsContext = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
        
        self.jsContext.exceptionHandler = ^(JSContext *context, JSValue *exceptionValue){
            context.exception = exceptionValue;
            NSLog(@"%@", exceptionValue);
        };
        
        // 调用JavaScript的函数
        self.jsContext[@"activityList"] = ^(NSDictionary *params){
            NSLog(@"%@", params);
        };
        
        id userAgent = [webView stringByEvaluatingJavaScriptFromString:@"navigator.userAgent"];
        NSLog(@"%@", userAgent);
        
        // JavaScript调用OC的函数
        self.jsContext[@"showLog"] = ^(){
            NSLog(@"showLog begin");
            
            NSArray *args = [JSContext currentArguments];
            for (JSValue *vol in args) {
                NSLog(@"%@", vol);
            }
            JSValue *this = [JSContext currentThis];
            NSLog(@"this %@", this);
            NSLog(@"showLog end");
        };
        
        __block typeof(self) bself = self;
        
        // JavaScript 调用OC大图浏览
        self.jsContext[@"showBigView"] = ^(){
            NSLog(@"showBigView");
            
            NSArray *args = [JSContext currentArguments];
            
            JSValue *urls = args[0];
            JSValue *jsIndex = args[1];
            NSLog(@"%@", urls);
            
            NSNumber *index = [jsIndex toNumber];
            NSLog(@"index == %@", index);
            NSArray *urlArr = [urls toArray];
            
//            NSArray *urlArr = [urls componentsSeparatedByString:@","];
            NSLog(@"%@", urlArr);
            
            if (bself.photos.count <= 0) {
                for (NSString *str in urlArr) {
                    [bself.photos addObject:[MWPhoto photoWithURL:[NSURL URLWithString:str]]];
                }
            }
            
            NSLog(@"photos ------- %@--%ld", bself.photos, bself.photos.count);
            [bself showPhotoViewWith:[index integerValue]];
        };
    }
}

- (void) showPhotoViewWith:(NSUInteger )index
{
    
    MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
    
    // Set options
    browser.displayActionButton = YES; // Show action button to allow sharing, copying, etc (defaults to YES)
    browser.displayNavArrows = NO; // Whether to display left and right nav arrows on toolbar (defaults to NO)
    browser.displaySelectionButtons = NO; // Whether selection buttons are shown on each image (defaults to NO)
    browser.zoomPhotosToFill = YES; // Images that almost fill the screen will be initially zoomed to fill (defaults to YES)
    browser.alwaysShowControls = NO; // Allows to control whether the bars and controls are always visible or whether they fade away to show the photo full (defaults to NO)
    browser.enableGrid = YES; // Whether to allow the viewing of all the photo thumbnails on a grid (defaults to YES)
    browser.startOnGrid = NO; // Whether to start on the grid of thumbnails instead of the first photo (defaults to NO)
    browser.autoPlayOnAppear = NO; // Auto-play first video
    
    // Optionally set the current visible photo before displaying
    [browser setCurrentPhotoIndex:index];
    
    // 主线程
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"-------------------------%@", [NSThread currentThread]);
        [self.navigationController pushViewController:browser animated:YES];
    });
    
    
    
}

- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser
{
    return self.photos.count;
}

- (id<MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index
{
    if (index < self.photos.count) {
        return [self.photos objectAtIndex:index];
    }
    return nil;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
