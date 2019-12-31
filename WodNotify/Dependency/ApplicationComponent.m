//
//  ApplicationComponent.m
//  WodNotify
//
//  Created by Tyler Madonna on 12/28/19.
//  Copyright © 2019 Tyler Madonna. All rights reserved.
//

#import "ApplicationComponent.h"
#import <CoreData/CoreData.h>

@interface ApplicationComponent ()

@property (strong, atomic, readonly) NSPersistentContainer * _Nullable persistentContainer;

@end

@implementation ApplicationComponent

- (instancetype)init
{
    self = [super init];
    if (self) {
        _persistentContainer = [self createPersistentContainer];
        _localDataManager = [self createLocalDataManagerWithPersistentContainer:_persistentContainer];
    }
    return self;
}

- (NSPersistentContainer * _Nullable)createPersistentContainer {
    __block BOOL loaded = NO;
    NSPersistentContainer *persistentContainer = [[NSPersistentContainer alloc] initWithName:@"Model"];
    [persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription * _Nonnull description, NSError * _Nullable error) {
        if (!error) {
            loaded = YES;
        }
    }];
    if (loaded)
        return persistentContainer;
    else
        return nil;
}

- (id<LocalDataManagerProtocol> _Nullable)createLocalDataManagerWithPersistentContainer:(NSPersistentContainer * _Nullable)persistentContainer {
    if (!persistentContainer) { return nil; }
    return [[CoreDataManager alloc] initWithPersistentContainer:persistentContainer];
}

@end
