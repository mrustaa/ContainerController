//
//  NSObject+Extension.m
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

#import "NSObject+Extension.h"
#import <objc/runtime.h>
#import <UIKit/UIKit.h>


//@class BlurWrapper;

NS_ASSUME_NONNULL_BEGIN

@implementation NSObject (Extension)

#pragma mark - Public Methods

#pragma mark *** Values getting ***

- (nullable NSArray<NSObject *> *)arrayValueByGetterNamed:(NSString *)getterName {
    return [self valueOfType:[NSArray class] getterNamed:getterName];
}

- (nullable NSDictionary<NSString *, id> *)dictionaryValueByGetterNamed:(NSString *)getterName {
    return [self valueOfType:[NSDictionary class] getterNamed:getterName];
}

- (nullable NSString *)stringValueByGetterNamed:(NSString *)getterName {
    return [self valueOfType:[NSString class] getterNamed:getterName];
}

- (nullable UIColor *)colorValueByGetterNamed:(NSString *)getterName {
    return [self valueOfType:[UIColor class] getterNamed:getterName];
}

#pragma mark *** Values setting ***

- (void)setIVarValue:(nullable id)value getterNamed:(NSString *)getterName {
    @try {
        SEL getterSelector = NSSelectorFromString(getterName);
        SEL setterSelector = NSSelectorFromString([self setterMethodName:getterName]);
        NSString *ivarName = [NSString stringWithFormat:@"_%@", getterName];
        if ([self respondsToSelector:getterSelector] && [self respondsToSelector:setterSelector]) {
            [self setValue:value forKey:ivarName];
        }
    } @catch (NSException *exception) {

    }
}

- (void)setValueUsingSetter:(nullable id)value getterNamed:(NSString *)getterName {
    [self callMethodNamed:[self setterMethodName:getterName] withObject:value];
}

- (void)setObjectInDictionary:(id)object forKey:(NSString *)key getterNamed:(NSString *)getterName {
    NSMutableDictionary *dictionary = [[self dictionaryValueByGetterNamed:getterName] mutableCopy];
    if (!dictionary) {
        return;
    }

    dictionary[key] = object;

    [self callMethodNamed:[self setterMethodName:getterName] withObject:[dictionary copy]];
}

- (nullable id)valueSafeForKey:(NSString *)key {
    @try {
        return [self valueForKey:key];
    } @catch (NSException *exception) {
        return nil;
    }
}

- (void)setValueSafe:(id)value forKey:(NSString *)key {
    @try {
        [self setValue:value forKey:key];
    } @catch (NSException *exception) {

    }
}

#pragma mark *** Methods calling ***

- (void)callMethodNamed:(NSString *)methodName {
    [self callMethodNamed:methodName withObject:nil];
}

- (void)callMethodNamed:(NSString *)methodName withObject:(nullable id)argument {
    @try {
        SEL selector = NSSelectorFromString(methodName);
        if ([self respondsToSelector:selector]) {
            _Pragma("clang diagnostic push")
            _Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"")
            if (argument) {
                [self performSelector:selector withObject:argument];
            } else {
                [self performSelector:selector];
            }
            _Pragma("clang diagnostic pop")
        }
    } @catch (NSException *exception) {

    }
}


#pragma mark - Private Methods

- (nullable id)valueOfType:(Class)type getterNamed:(NSString *)getterName {
    id typedValue;
    @try {
        SEL selector = NSSelectorFromString(getterName);
        if ([self respondsToSelector:selector]) {
            _Pragma("clang diagnostic push")
            _Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"")
            id value = [self performSelector:selector];
            if ([value isKindOfClass:type]) {
                typedValue = value;
            }_Pragma("clang diagnostic pop")
        }
    } @catch (NSException *exception) {

    } @finally {
        return typedValue;
    }
}

- (NSString *)setterMethodName:(NSString *)getterMethodName {
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en-US"];
    NSString *firstChar = [getterMethodName substringToIndex:1];
    NSString *folded = [firstChar stringByFoldingWithOptions:NSDiacriticInsensitiveSearch locale:locale];
    NSString *pascalCasedResult = [folded.uppercaseString stringByAppendingString:[getterMethodName substringFromIndex:1]];

    return [NSString stringWithFormat:@"set%@:", pascalCasedResult];
}

@end

NS_ASSUME_NONNULL_END
