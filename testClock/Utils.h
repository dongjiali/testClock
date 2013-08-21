//
//  Utils.h
//  testClock
//
//  Created by Curry on 13-8-20.
//  Copyright (c) 2013年 刘晨光. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Utils : NSObject
CGImageRef PDFPageToCGImage(size_t pageNumber, CGPDFDocumentRef document);
@end
