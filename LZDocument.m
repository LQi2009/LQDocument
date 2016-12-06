//
//  LZDocument.m
//  LZiCloudDemo
//
//  Created by Artron_LQQ on 2016/12/2.
//  Copyright © 2016年 Artup. All rights reserved.
//

#import "LZDocument.h"

static NSString *textFileName = @"textfile.txt";
static NSString *imageFileName = @"imageFile.png";
@implementation LZDocument

// 将要保存的数据转换为NSData或者NSFileWrapper
// 转换为NSData比较简单, 直接在这个方法里处理为data返回即可
// 用于保存文件时提供给 UIDocument 要保存的数据，
- (id)contentsForType:(NSString *)typeName error:(NSError * _Nullable __autoreleasing *)outError {
    
    NSLog(@"typeName == %@", typeName);
    
    if (self.wrapper == nil) {
        self.wrapper =[[NSFileWrapper alloc]initDirectoryWithFileWrappers:@{}];
    }
    
    NSDictionary *wrappers = [self.wrapper fileWrappers];
    
    if ([wrappers objectForKey:textFileName] == nil && self.text != nil) {
        
        NSData *textData = [self.text dataUsingEncoding:NSUTF8StringEncoding];
        NSFileWrapper *textWrap = [[NSFileWrapper alloc]initRegularFileWithContents:textData];
        [textWrap setPreferredFilename:textFileName];
        [self.wrapper addFileWrapper:textWrap];
    }
    
    if ([wrappers objectForKey:imageFileName] == nil && self.img != nil) {
        
        NSData *imgData = UIImageJPEGRepresentation(self.img, 1.0);
        
        NSFileWrapper *imgWrap = [[NSFileWrapper alloc]initRegularFileWithContents:imgData];
        [imgWrap setPreferredFilename:imageFileName];
        [self.wrapper addFileWrapper:imgWrap];
    }
   
    return self.wrapper;
}

// 获取已保存德尔数据
// 用于 UIDocument 成功打开文件后，我们将数据解析成我们需要的文件内容，然后再保存起来
- (BOOL)loadFromContents:(id)contents ofType:(NSString *)typeName error:(NSError * _Nullable __autoreleasing *)outError {
    
    // 这个NSFileWrapper对象是a parent
    self.wrapper = (NSFileWrapper*)contents;
    
    NSDictionary *fileWrappers = self.wrapper.fileWrappers;
    // 获取child fileWrapper 这里才能获取到我们保存的内容
    NSFileWrapper *textWrap = [fileWrappers objectForKey:textFileName];
    NSFileWrapper *imgWrap = [fileWrappers objectForKey:imageFileName];
    
    // 获取保存的内容
    if (textWrap.regularFile) {
        
        self.text = [[NSString alloc]initWithData:textWrap.regularFileContents encoding:NSUTF8StringEncoding];
    }
    
    self.img = [UIImage imageWithData:imgWrap.regularFileContents];

    return YES;
}

// 本地的文件路径生成URL
+ (NSURL *)urlForFile:(NSString *)fileName {
    
    // 获取Documents目录
    NSURL *fileUrl = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] firstObject];
    // 拼接文件名称
    NSURL *url = [fileUrl URLByAppendingPathComponent:fileName];
    NSLog(@"%@", url);
    return url;
}
@end
