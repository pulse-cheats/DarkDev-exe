#import <UIKit/UIKit.h>

@interface DarkDevExecutorUI : UIViewController <UITextViewDelegate>
@property (nonatomic, strong) UITextView *scriptEditor;
@property (nonatomic, strong) UIButton *executeBtn;
@property (nonatomic, strong) UIButton *clearBtn;
@property (nonatomic, strong) UIButton *saveBtn;
@end

@implementation DarkDevExecutorUI

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:0.05 green:0.05 blue:0.08 alpha:0.95];
    self.view.layer.cornerRadius = 16;
    self.view.layer.masksToBounds = YES;
    
    // Title
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(20, 15, 250, 30)];
    title.text = @"⚡ DARKDEV EXECUTOR v1.0";
    title.textColor = [UIColor cyanColor];
    title.font = [UIFont boldSystemFontOfSize:14];
    [self.view addSubview:title];
    
    // Script Text View (Paste Area)
    self.scriptEditor = [[UITextView alloc] initWithFrame:CGRectMake(15, 50, 370, 160)];
    self.scriptEditor.backgroundColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.15 alpha:1.0];
    self.scriptEditor.textColor = [UIColor whiteColor];
    self.scriptEditor.font = [UIFont fontWithName:@"Courier" size:12];
    self.scriptEditor.layer.cornerRadius = 8;
    self.scriptEditor.text = @"-- Paste your Lua script here\nprint('DarkDev Executor Loaded!')";
    [self.view addSubview:self.scriptEditor];
    
    // Execute Button
    self.executeBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    self.executeBtn.frame = CGRectMake(15, 220, 115, 35);
    self.executeBtn.backgroundColor = [UIColor colorWithRed:0.4 green:0.2 blue:0.8 alpha:1.0];
    [self.executeBtn setTitle:@"▶ EXECUTE" forState:UIControlStateNormal];
    [self.executeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.executeBtn.layer.cornerRadius = 6;
    [self.executeBtn addTarget:self action:@selector(executeScript) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.executeBtn];
    
    // Clear Button
    self.clearBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    self.clearBtn.frame = CGRectMake(142, 220, 115, 35);
    self.clearBtn.backgroundColor = [UIColor colorWithRed:0.2 green:0.2 blue:0.3 alpha:1.0];
    [self.clearBtn setTitle:@"🗑 CLEAR" forState:UIControlStateNormal];
    [self.clearBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.clearBtn.layer.cornerRadius = 6;
    [self.clearBtn addTarget:self action:@selector(clearScript) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.clearBtn];
    
    // Save Button
    self.saveBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    self.saveBtn.frame = CGRectMake(270, 220, 115, 35);
    self.saveBtn.backgroundColor = [UIColor colorWithRed:0.0 green:0.6 blue:0.6 alpha:1.0];
    [self.saveBtn setTitle:@"💾 SAVE" forState:UIControlStateNormal];
    [self.saveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.saveBtn.layer.cornerRadius = 6;
    [self.saveBtn addTarget:self action:@selector(saveScript) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.saveBtn];
}

- (void)executeScript {
    NSString *luaCode = self.scriptEditor.text;
    NSLog(@"[DarkDev Executing]: %@", luaCode);
}

- (void)clearScript {
    self.scriptEditor.text = @"";
}

- (void)saveScript {
    [[NSUserDefaults standardUserDefaults] setObject:self.scriptEditor.text forKey:@"DarkDevSavedScript"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
