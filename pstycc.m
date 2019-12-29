#import "pstycc.h"

@implementation pstycc

//Return the icon of your module here
- (UIImage *)iconGlyph {
	return [UIImage imageNamed:@"Module-Glyph" inBundle:[NSBundle bundleForClass:[self class]] compatibleWithTraitCollection:nil];
}

//Return the color selection color of your module here
- (UIColor *)selectedColor {
	return [UIColor blackColor];
}

- (BOOL)isSelected {
  return NO;
}

- (void)setSelected:(BOOL)selected {
    NSString *paste = UIPasteboard.generalPasteboard.string;
    if (paste.length > 0) {
        NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:@"https://psty.io/api"]];
        [urlRequest setHTTPMethod:@"POST"];
        [urlRequest setHTTPBody:[[NSString stringWithFormat:@"lang=plaintext&code=%@", [paste stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.new]] dataUsingEncoding:NSUTF8StringEncoding]];
        NSURLSession *session = [NSURLSession sharedSession];
        NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
            NSError *parseError = nil;
            NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&parseError];
            if(httpResponse.statusCode == 200)
            {
                NSString *pasteLink = [responseDictionary objectForKey:@"paste_link"];
                [UIApplication.sharedApplication openURL:[NSURL URLWithString:pasteLink] options:@{} completionHandler:nil];
            }
        }];
        [dataTask resume];
    }
    NSLog(@"[psty] Clipboard: %@", UIPasteboard.generalPasteboard.string);
}

@end
