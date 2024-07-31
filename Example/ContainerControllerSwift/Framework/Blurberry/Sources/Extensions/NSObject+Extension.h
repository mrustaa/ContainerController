//
//  NSObject+Extension.h
//  Blurberry
//
//  Created by Pavel Puzyrev on 07.09.2020.
//
//  Copyright (c) 2020 Pavel Puzyrev <cannedapp@yahoo.com>
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

#import <Foundation/Foundation.h>
#import "ContainerControllerSwift-Swift.h"

struct BlurWrapper;

@class UIColor;

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (Extension)

#pragma mark *** Values getting ***

- (nullable NSArray<NSObject *> *)arrayValueByGetterNamed:(NSString *)getterName NS_SWIFT_NAME(arrayValue(getter:));
- (nullable NSDictionary<NSString *, id> *)dictionaryValueByGetterNamed:(NSString *)getterName NS_SWIFT_NAME(dictionaryValue(getter:));
- (nullable NSString *)stringValueByGetterNamed:(NSString *)getterName NS_SWIFT_NAME(stringValue(getter:));
- (nullable UIColor *)colorValueByGetterNamed:(NSString *)getterName NS_SWIFT_NAME(colorValue(getter:));

#pragma mark *** Values setting ***

- (void)setIVarValue:(nullable id)value getterNamed:(NSString *)getterName NS_SWIFT_NAME(setIVarValue(value:getter:));
- (void)setValueUsingSetter:(nullable id)value getterNamed:(NSString *)getterName NS_SWIFT_NAME(setValueUsingSetter(value:getter:));
- (void)setObjectInDictionary:(id)object
                       forKey:(NSString *)key
                  getterNamed:(NSString *)getterName NS_SWIFT_NAME(setObjectInDictionary(object:key:getter:));

- (nullable id)valueSafeForKey:(NSString *)key NS_SWIFT_NAME(valueSafe(key:));
- (void)setValueSafe:(id)value forKey:(NSString *)key NS_SWIFT_NAME(setValueSafe(value:key:));

#pragma mark *** Methods calling ***

- (void)callMethodNamed:(NSString *)methodName NS_SWIFT_NAME(callMethod(named:));
- (void)callMethodNamed:(NSString *)methodName withObject:(nullable id)argument NS_SWIFT_NAME(callMethod(named:with:));

@end

NS_ASSUME_NONNULL_END
