//
//  ViewController.m
//  LZDocument
//
//  Created by Artron_LQQ on 2016/12/5.
//  Copyright © 2016年 Artup. All rights reserved.
//

#import "ViewController.h"
#import "LZDocument.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self documents];
    //    [self stringDocument];
}

- (void)documents {
    
    UIImage *img = [UIImage imageNamed:@"5fdf8db1cb134954979ddf0d564e9258d0094ad3.jpg"];
    
    NSURL *url = [LZDocument urlForFile:@"wrapper/data"];
    
    // 根据URL创建LZDocument实例
    LZDocument *doc = [[LZDocument alloc]initWithFileURL:url];
    
    doc.text = @"这是一串需要保存的字符串";
    doc.img = img;
    
    [doc saveToURL:url forSaveOperation:UIDocumentSaveForCreating completionHandler:^(BOOL success) {
        
        NSLog(@"%d",success);
    }];
    
    //    [doc openWithCompletionHandler:^(BOOL success) {
    //
    //        NSLog(@"%d",success);
    //        NSLog(@"保存的文件为: %@",doc.text);
    //        NSLog(@"保存的图片为: %@",doc.img);
    //
    //        [doc closeWithCompletionHandler:^(BOOL success) {
    //
    //            NSLog(@"%d",success);
    //        }];
    //
    //        NSLog(@"%@", [NSThread currentThread]);
    //    }];
    //totalUnitCount
    
    NSLog(@"保存的文件为: %@",doc.text);
    NSLog(@"保存的图片为: %@",doc.img);
}

- (void)stringDocument {
    
    NSURL *url = [LZDocument urlForFile:@"data.txt"];
    
    // 根据URL创建LZDocument实例
    LZDocument *doc = [[LZDocument alloc]initWithFileURL:url];
    
    doc.text = @"这是一串需要保存的字符串";
    // 第二个参数
    //UIDocumentSaveForCreating, 新建文件
    //UIDocumentSaveForOverwriting. 覆盖原有的文件
    [doc saveToURL:url forSaveOperation:UIDocumentSaveForCreating completionHandler:^(BOOL success) {
        
        NSLog(@"%d",success);
    }];
    
    
    // 打开文件
    // 当读取完毕后, 它会调用loadFromContents方法,
    // 在loadFromContents方法中获取我们要读取的数据
    //    [doc openWithCompletionHandler:^(BOOL success) {
    //
    //        if (success) {
    //            NSLog(@"打开成功");
    //        } else {
    //
    //            NSLog(@"打开失败");
    //        }
    //    }];
    
    NSLog(@"读取的数据为: %@",doc.text);
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
