//
//  MainViewController.m
//  DecodeMobileprovision
//
//  Created by FreeGeek on 16/1/11.
//  Copyright © 2016年 ZhongXi. All rights reserved.
//

#import "MainViewController.h"
#import "ZXDragView.h"
#import "AppDelegate.h"
#import "ZXDecode.h"
#define FileManager  [NSFileManager defaultManager]
@interface MainViewController ()<ZXDragViewDelegate>
@property (weak) IBOutlet ZXDragView *dragView;
@property (weak) IBOutlet NSTextFieldCell *PathLabel;
@property (weak) IBOutlet NSButton *OutputButton;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    _dragView.delegate = self;
}

- (IBAction)OutputAction:(id)sender {
    if (![FileManager fileExistsAtPath:_PathLabel.title]) {
        NSAlert * alert = [[NSAlert alloc]init];
        [alert setMessageText:@"Warning!"];
        [alert addButtonWithTitle:@"I Know"];
        [alert setInformativeText:@"mobileprovision error"];
        [alert setAlertStyle:NSWarningAlertStyle];
        AppDelegate * delegate = (AppDelegate *)[[NSApplication sharedApplication] delegate];
        [alert beginSheetModalForWindow:delegate.window completionHandler:^(NSModalResponse returnCode) {
        }];
        return;
    }
    NSDictionary * mobileprovisionDict = [ZXDecode getMobileProvisionbyPath:_PathLabel.title];
    if (!mobileprovisionDict) {
        NSAlert * alert = [[NSAlert alloc]init];
        [alert setMessageText:@"Warning!"];
        [alert addButtonWithTitle:@"I Know"];
        [alert setInformativeText:@"mobileprovision error"];
        [alert setAlertStyle:NSWarningAlertStyle];
        AppDelegate * delegate = (AppDelegate *)[[NSApplication sharedApplication] delegate];
        [alert beginSheetModalForWindow:delegate.window completionHandler:^(NSModalResponse returnCode) {
        }];
        return;
    }
    NSString * mobileprovisionFileName = [[FileManager displayNameAtPath:_PathLabel.title] componentsSeparatedByString:@".mobileprovision"][0];
    NSString * workPath = [_PathLabel.title componentsSeparatedByString:mobileprovisionFileName][0];
    NSString * plistPath = [workPath stringByAppendingString:[NSString stringWithFormat:@"%@.plist",mobileprovisionFileName]];
    [mobileprovisionDict writeToFile:plistPath atomically:YES];
    [[NSWorkspace sharedWorkspace] openFile:plistPath];
}

- (IBAction)ClickAction:(id)sender {
    NSOpenPanel * openDlg = [NSOpenPanel openPanel];
    [openDlg setCanChooseFiles:YES];
    [openDlg setCanCreateDirectories:NO];
    [openDlg setAllowsMultipleSelection:NO];
    [openDlg setAllowsOtherFileTypes:NO];
    [openDlg setAllowedFileTypes:@[@"mobileprovision"]];
    if ([openDlg runModal] == NSModalResponseOK) {
        NSString * MobileprovisionPath = [[openDlg URLs][0] path];
        _PathLabel.title = MobileprovisionPath;
        _OutputButton.enabled = YES;
    }
}


- (IBAction)OpenWebsites:(id)sender {
    [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:@"https://github.com/XieXieZhongxi/DecodeMobileprovision"]];
}


-(void)dragView:(ZXDragView *)dragView didDragItem:(NSString *)item
{
    _PathLabel.title = item;
    _OutputButton.enabled = YES;
}

@end
