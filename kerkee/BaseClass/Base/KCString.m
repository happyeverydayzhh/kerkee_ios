//
//  KCString.m
//  kerkee
//
//  Created by zihong on 15/12/14.
//  Copyright © 2015年 zihong. All rights reserved.
//

#import "KCString.h"

@implementation KCString

+ (int)lastIndexOfChar:(char)aChar str:(NSString*)aString
{
    if (!aString) return -1;
    
    int lenth = (int)aString.length;
    for (int i = lenth-1; i >= 0; i--)
    {
        char c = [aString characterAtIndex:i];
        if (aChar == c)
            return i;
    }
    return -1;
}



@end


#pragma mark -
@implementation NSString (KCStringAdditions)

- (BOOL)kc_startsWithChar:(char)aChar
{
    char c = [self characterAtIndex:0];
    return c == aChar;
}
- (BOOL)kc_startsWith:(NSString *)aPrefix
{
    return [self hasPrefix:aPrefix];
}

- (BOOL)kc_endsWith:(NSString *)aSuffix
{
    return [self hasSuffix:aSuffix];
}

- (BOOL)kc_isEmpty
{
    return self.length == 0;
}

- (NSString *)kc_trim:(NSString *)aString
{
    if(aString == nil)
    {
        return nil;
    }
    
    NSString *trimmed = [aString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return trimmed;

}

- (int)kc_indexOf:(NSString*)aSearch
{
    NSRange range = [self rangeOfString:aSearch];
    
    if(range.location != NSNotFound)
    {
        return (int)range.location;
    }
    
    return -1;
}

- (int)kc_indexOf:(NSString*)aSearch startIndex:(NSUInteger)aStartIndex
{
    NSUInteger endIndex = [self length];
    NSRange searchRange = NSMakeRange(aStartIndex, endIndex-aStartIndex);
    NSRange result = [self rangeOfString:aSearch options:NSLiteralSearch range:searchRange];
    if(result.location != NSNotFound)
    {
        return (int)result.location;
    }
    return -1;
}

- (int)kc_indexOfChar:(char)aChar
{
    int lenth = (int)self.length;
    for (int i = 0; i < lenth; ++i)
    {
        char c = [self characterAtIndex:i];
        if (aChar == c)
            return i;
    }
    return -1;
}

- (int)kc_lastIndexOfChar:(char)aChar
{
    
    int lenth = (int)self.length;
    for (int i = lenth-1; i >= 0; i--)
    {
        char c = [self characterAtIndex:i];
        if (aChar == c)
            return i;
    }
    return -1;
}

- (int)kc_lastIndexOf:(NSString*)aSearch
{
    NSRange range = [self rangeOfString:aSearch options:NSBackwardsSearch];
    
    if(range.location != NSNotFound)
    {
        return (int)range.location;
    }
    
    return -1;
}
- (NSString*)kc_replaceChar:(char)aOldChar withChar:(char)aNewChar
{
    const char* src = [self cStringUsingEncoding:NSUTF8StringEncoding];
    int length = (int)strlen(src);
    char* newString = malloc((length+1)*sizeof(char));
    memset(newString, 0, (length+1)*sizeof(char));
    int idx = 0;
    int last = length;
    while (idx < last)
    {
        if (src[idx] == aOldChar)
        {
            newString[idx] = aNewChar;
        }
        else
        {
            newString[idx] = src[idx];
        }
        idx++;
    }
    
    NSString *newReplaceString = [NSString stringWithCString:newString encoding:NSUTF8StringEncoding];
    if (newString)
    {
        free(newString);
        newString = NULL;
    }
    
    return newReplaceString;
}
- (NSString *)kc_replaceAll:(NSString*)aTarget with:(NSString*)aWith
{
    NSMutableString *buffer = [NSMutableString stringWithString:self];
    NSRange searchRange = NSMakeRange(0, [buffer length]);
    [buffer replaceOccurrencesOfString:aTarget withString:aWith options:NSLiteralSearch range:searchRange];
    return [NSString stringWithString:buffer];
}

-(NSString *)kc_substring:(NSUInteger)aStart
{
    return [self substringFromIndex:aStart];
}
-(NSString *)kc_substring:(NSUInteger)aStart end:(NSUInteger)aEnd
{
    NSRange range = NSMakeRange(aStart, aEnd-aStart);
    return [self substringWithRange:range];
}

- (BOOL)kc_equals:(NSString*)aString
{
    return [self isEqualToString:aString];
}

@end


