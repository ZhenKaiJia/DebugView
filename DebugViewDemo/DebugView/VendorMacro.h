//
//  VendorMacro.h
//  DebugView
//
//  Created by Justin on 16/10/31.
//  Copyright © 2016年 Justin. All rights reserved.
//

#import "EnvironMents.h"

#ifndef VendorMacro_h
#define VendorMacro_h

#ifdef Develop
#define IsDevelopEnvironment YES
#endif


#ifdef Master
#define IsDevelopEnvironment NO
#endif

#define DebugToolEnable IsDevelopEnvironment

#endif
