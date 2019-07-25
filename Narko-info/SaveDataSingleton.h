
#import <Foundation/Foundation.h>

@interface SaveDataSingleton : NSObject

@property (nonatomic, retain) NSMutableDictionary *dataList;

+ (id)sharedManager;

+ (void)sendDataByAPI;

@end

