//
//  CoreDataManager.m
//  WodNotify
//
//  Created by Tyler Madonna on 12/24/19.
//  Copyright © 2019 Tyler Madonna. All rights reserved.
//

#import "CoreDataManager.h"

@interface CoreDataManager ()

@property (strong, nonatomic) NSPersistentContainer * persistentContainer;

@end

@implementation CoreDataManager

- (instancetype)initWithPersistentContainer:(NSPersistentContainer *)persistentContainer {
    self = [super init];
    if (self) {
        _persistentContainer = persistentContainer;
    }
    return self;
}

- (void)getAllWodsWithCompletion:(nonnull WodQueryCompletion)completion {
    [self.persistentContainer.viewContext performBlock:^{

        NSFetchRequest *fetchRequest = [WodEntity fetchRequest];
        fetchRequest.predicate = [NSPredicate predicateWithValue:YES];
        fetchRequest.sortDescriptors = @[ [[NSSortDescriptor alloc] initWithKey:@"date" ascending:YES] ];

        NSError *error;
        NSArray<WodEntity *> *wods = [self.persistentContainer.viewContext executeFetchRequest:fetchRequest error:&error];

        if (error) {
            completion(nil, error);
            return;
        }

        completion(wods, nil);
    }];
}

@end
