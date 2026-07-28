#import <UIKit/UIKit.h>

@interface DarkDevExecutorUI : UIViewController
+ (instancetype)sharedInstance;
- (void)toggleUI;
@end

static UIButton *floatingBtn = nil;

%hook UIApplication

- (void)applicationDidFinishLaunching:(id)application {
    %orig;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
        if (!keyWindow && [UIApplication sharedApplication].windows.count > 0) {
            keyWindow = [UIApplication sharedApplication].windows.firstObject;
        }
        
        if (keyWindow) {
            // Floating Injector Button
            floatingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            floatingBtn.frame = CGRectMake(20, 150, 45, 45);
            floatingBtn.backgroundColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.18 alpha:0.9];
            [floatingBtn setTitle:@"⚡" forState:UIControlStateNormal];
            floatingBtn.titleLabel.font = [UIFont systemFontOfSize:22];
            floatingBtn.layer.cornerRadius = 22.5;
            floatingBtn.layer.borderColor = [UIColor cyanColor].CGColor;
            floatingBtn.layer.borderWidth = 1.5;
            
            // Pan Drag Gesture
            UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
            [floatingBtn addGestureRecognizer:pan];
            
            [floatingBtn addTarget:self action:@selector(toggleExecutorUI) forControlEvents:UIControlEventTouchUpInside];
            [keyWindow addSubview:floatingBtn];
        }
    });
}

%new
- (void)handlePan:(UIPanGestureRecognizer *)pan {
    CGPoint translation = [pan translationInView:pan.view.superview];
    pan.view.center = CGPointMake(pan.view.center.x + translation.x, pan.view.center.y + translation.y);
    [pan setTranslation:CGPointZero inView:pan.view.superview];
}

%new
- (void)toggleExecutorUI {
    UIViewController *rootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    if (rootVC) {
        DarkDevExecutorUI *ui = [DarkDevExecutorUI sharedInstance];
        if (ui.view.superview) {
            [ui.view removeFromSuperview];
        } else {
            ui.view.frame = CGRectMake((rootVC.view.bounds.size.width - 400)/2, (rootVC.view.bounds.size.height - 270)/2, 400, 270);
            [rootVC.view addSubview:ui.view];
        }
    }
}

%end
