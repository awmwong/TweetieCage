//
//  NSManagedObject+JSONHelpers.h
//  Gathering
//
//  Created by Saul Mora on 6/28/11.
//  Copyright 2011 Magical Panda Software LLC. All rights reserved.
//

#import <CoreData/CoreData.h>

extern NSString * const kMagicalRecordImportDefaultDateFormatString;
extern NSString * const kMagicalRecordImportAttributeKeyMapKey;
extern NSString * const kMagicalRecordImportAttributeValueClassNameKey;

extern NSString * const kMagicalRecordImportRelationshipMapKey;
extern NSString * const kMagicalRecordImportRelationshipPrimaryKey;
extern NSString * const kMagicalRecordImportRelationshipTypeKey;

@interface NSManagedObject (NSManagedObject_DataImport)

- (void) MR_setValuesForKeysWithJSONDictionary:(NSDictionary *)jsonData;
+ (id) MR_importFromDictionary:(NSDictionary *)data;

@end


#ifdef MR_SHORTHAND
    #define importFromDictionary                    MR_importFromDictionary
    #define setValuesForKeysWithJSDONDictionary     MR_setValuesForKeysWithJSONDictionary
#endif