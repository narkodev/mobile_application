
#import "SaveDataSingleton.h"

@implementation SaveDataSingleton

static SaveDataSingleton *sharedMyManager;

+ (id)sharedManager {
    
    @synchronized(self) {
        if (sharedMyManager == nil) {
            sharedMyManager = [[self alloc] init];
            sharedMyManager.dataList = [[NSMutableDictionary alloc] init];
        }

    }
    return sharedMyManager;
}

+ (void)sendDataByAPI {
    
    SaveDataSingleton *sharedManager = [SaveDataSingleton sharedManager];
    
    NSString *bodyData = [NSString stringWithFormat:@"subject=%@&phone=%@&latitude=%@&longitude=%@&photo=%@&status=10",
                          [sharedManager.dataList objectForKey:@"subject"],
                          [sharedManager.dataList objectForKey:@"phone"],
                          [sharedManager.dataList objectForKey:@"latitude"],
                          [sharedManager.dataList objectForKey:@"longitude"],
                          [sharedManager.dataList objectForKey:@"photo"]
                          ];
    
    NSMutableURLRequest *postRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://narko-info.space/api/report"]];
    
    [postRequest setHTTPMethod:@"POST"];
    
    [postRequest setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
//    [postRequest setValue:@"multipart/form-data" forHTTPHeaderField:@"Content-Type"];
    
    [postRequest setHTTPBody:[NSData dataWithBytes:[bodyData UTF8String] length:strlen([bodyData UTF8String])]];

    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:postRequest delegate:self];

}

@end
