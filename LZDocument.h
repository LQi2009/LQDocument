//
//  LZDocument.h
//  LZiCloudDemo
//
//  Created by Artron_LQQ on 2016/12/2.
//  Copyright © 2016年 Artup. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LZDocument : UIDocument
@property (nonatomic, strong) UIImage *img;
//@property (nonatomic, assign) id data;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, strong) NSFileWrapper *wrapper;

+ (NSURL *)urlForFile:(NSString *)fileName;
@end
