//
//  NSString+Ext.h
//  WirelessPrinter
//
//  Created by midmirror on 16/9/12.
//  Copyright © 2016年 midmirror. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Ext)

@property(assign,nonatomic,readwrite) NSInteger dataSize;

- (NSInteger)dataSize;

@end

@interface NSMutableString (Ext)

- (void)appendDownloadItem:(NSString *)item value:(NSString *)value;

@end
