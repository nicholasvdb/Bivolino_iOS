//------------------------------------------------------------------------------
// <wsdl2code-generated>
// This code was generated by http://www.wsdl2code.com iPhone version 1.5
// Date Of Creation: 5/8/2013 9:39:43 AM
//
//  Please dont change this code, regeneration will override your changes
//</wsdl2code-generated>
//
//------------------------------------------------------------------------------
//
//This source code was auto-generated by Wsdl2Code Version
//

#import "Antwoord.h" 


@implementation Antwoord

-(id)initWithArray:(NSArray*)array {
    self = [super init];
    if (self) {
        @try {
            for (int i0 = 0; i0 < [array count]; i0++)
            {
                if ( ([[array objectAtIndex:i0] objectForKey:@"nodeContent"] !=nil) &&  ([[[array objectAtIndex:i0]objectForKey:@"nodeName"]caseInsensitiveCompare:@"Collarsize"]==NSOrderedSame)){
                    NSString *nodeContentValue = [[NSString alloc]initWithString:[[array objectAtIndex:i0] objectForKey:@"nodeContent"]];
                    [self setCollarsize:[nodeContentValue doubleValue]];
                }
                else if ( ([[array objectAtIndex:i0] objectForKey:@"nodeContent"] !=nil) &&  ([[[array objectAtIndex:i0]objectForKey:@"nodeName"]caseInsensitiveCompare:@"CollarsizeSpecified"]==NSOrderedSame)){
                    NSString *nodeContentValue = [[NSString alloc]initWithString:[[array objectAtIndex:i0] objectForKey:@"nodeContent"]];
                    [self setCollarsizeSpecified:[nodeContentValue boolValue]];
                }
                else if ( ([[array objectAtIndex:i0] objectForKey:@"nodeContent"] !=nil) &&  ([[[array objectAtIndex:i0]objectForKey:@"nodeName"]caseInsensitiveCompare:@"Sleeve"]==NSOrderedSame)){
                    NSString *nodeContentValue = [[NSString alloc]initWithString:[[array objectAtIndex:i0] objectForKey:@"nodeContent"]];
                    [self setSleeve:[nodeContentValue doubleValue]];
                }
                else if ( ([[array objectAtIndex:i0] objectForKey:@"nodeContent"] !=nil) &&  ([[[array objectAtIndex:i0]objectForKey:@"nodeName"]caseInsensitiveCompare:@"SleeveSpecified"]==NSOrderedSame)){
                    NSString *nodeContentValue = [[NSString alloc]initWithString:[[array objectAtIndex:i0] objectForKey:@"nodeContent"]];
                    [self setSleeveSpecified:[nodeContentValue boolValue]];
                }
                else if ( ([[array objectAtIndex:i0] objectForKey:@"nodeContent"] !=nil) &&  ([[[array objectAtIndex:i0]objectForKey:@"nodeName"]caseInsensitiveCompare:@"Shoulder"]==NSOrderedSame)){
                    NSString *nodeContentValue = [[NSString alloc]initWithString:[[array objectAtIndex:i0] objectForKey:@"nodeContent"]];
                    [self setShoulder:[nodeContentValue doubleValue]];
                }
                else if ( ([[array objectAtIndex:i0] objectForKey:@"nodeContent"] !=nil) &&  ([[[array objectAtIndex:i0]objectForKey:@"nodeName"]caseInsensitiveCompare:@"ShoulderSpecified"]==NSOrderedSame)){
                    NSString *nodeContentValue = [[NSString alloc]initWithString:[[array objectAtIndex:i0] objectForKey:@"nodeContent"]];
                    [self setShoulderSpecified:[nodeContentValue boolValue]];
                }
                else if ( ([[array objectAtIndex:i0] objectForKey:@"nodeContent"] !=nil) &&  ([[[array objectAtIndex:i0]objectForKey:@"nodeName"]caseInsensitiveCompare:@"Chest"]==NSOrderedSame)){
                    NSString *nodeContentValue = [[NSString alloc]initWithString:[[array objectAtIndex:i0] objectForKey:@"nodeContent"]];
                    [self setChest:[nodeContentValue doubleValue]];
                }
                else if ( ([[array objectAtIndex:i0] objectForKey:@"nodeContent"] !=nil) &&  ([[[array objectAtIndex:i0]objectForKey:@"nodeName"]caseInsensitiveCompare:@"ChestSpecified"]==NSOrderedSame)){
                    NSString *nodeContentValue = [[NSString alloc]initWithString:[[array objectAtIndex:i0] objectForKey:@"nodeContent"]];
                    [self setChestSpecified:[nodeContentValue boolValue]];
                }
                else if ( ([[array objectAtIndex:i0] objectForKey:@"nodeContent"] !=nil) &&  ([[[array objectAtIndex:i0]objectForKey:@"nodeName"]caseInsensitiveCompare:@"Belly"]==NSOrderedSame)){
                    NSString *nodeContentValue = [[NSString alloc]initWithString:[[array objectAtIndex:i0] objectForKey:@"nodeContent"]];
                    [self setBelly:[nodeContentValue doubleValue]];
                }
                else if ( ([[array objectAtIndex:i0] objectForKey:@"nodeContent"] !=nil) &&  ([[[array objectAtIndex:i0]objectForKey:@"nodeName"]caseInsensitiveCompare:@"BellySpecified"]==NSOrderedSame)){
                    NSString *nodeContentValue = [[NSString alloc]initWithString:[[array objectAtIndex:i0] objectForKey:@"nodeContent"]];
                    [self setBellySpecified:[nodeContentValue boolValue]];
                }
                else if ( ([[array objectAtIndex:i0] objectForKey:@"nodeContent"] !=nil) &&  ([[[array objectAtIndex:i0]objectForKey:@"nodeName"]caseInsensitiveCompare:@"Waist"]==NSOrderedSame)){
                    NSString *nodeContentValue = [[NSString alloc]initWithString:[[array objectAtIndex:i0] objectForKey:@"nodeContent"]];
                    [self setWaist:[nodeContentValue doubleValue]];
                }
                else if ( ([[array objectAtIndex:i0] objectForKey:@"nodeContent"] !=nil) &&  ([[[array objectAtIndex:i0]objectForKey:@"nodeName"]caseInsensitiveCompare:@"WaistSpecified"]==NSOrderedSame)){
                    NSString *nodeContentValue = [[NSString alloc]initWithString:[[array objectAtIndex:i0] objectForKey:@"nodeContent"]];
                    [self setWaistSpecified:[nodeContentValue boolValue]];
                }
                else if ( ([[array objectAtIndex:i0] objectForKey:@"nodeContent"] !=nil) &&  ([[[array objectAtIndex:i0]objectForKey:@"nodeName"]caseInsensitiveCompare:@"Arm"]==NSOrderedSame)){
                    NSString *nodeContentValue = [[NSString alloc]initWithString:[[array objectAtIndex:i0] objectForKey:@"nodeContent"]];
                    [self setArm:[nodeContentValue doubleValue]];
                }
                else if ( ([[array objectAtIndex:i0] objectForKey:@"nodeContent"] !=nil) &&  ([[[array objectAtIndex:i0]objectForKey:@"nodeName"]caseInsensitiveCompare:@"ArmSpecified"]==NSOrderedSame)){
                    NSString *nodeContentValue = [[NSString alloc]initWithString:[[array objectAtIndex:i0] objectForKey:@"nodeContent"]];
                    [self setArmSpecified:[nodeContentValue boolValue]];
                }
                else if ( ([[array objectAtIndex:i0] objectForKey:@"nodeContent"] !=nil) &&  ([[[array objectAtIndex:i0]objectForKey:@"nodeName"]caseInsensitiveCompare:@"Wrist"]==NSOrderedSame)){
                    NSString *nodeContentValue = [[NSString alloc]initWithString:[[array objectAtIndex:i0] objectForKey:@"nodeContent"]];
                    [self setWrist:[nodeContentValue doubleValue]];
                }
                else if ( ([[array objectAtIndex:i0] objectForKey:@"nodeContent"] !=nil) &&  ([[[array objectAtIndex:i0]objectForKey:@"nodeName"]caseInsensitiveCompare:@"WristSpecified"]==NSOrderedSame)){
                    NSString *nodeContentValue = [[NSString alloc]initWithString:[[array objectAtIndex:i0] objectForKey:@"nodeContent"]];
                    [self setWristSpecified:[nodeContentValue boolValue]];
                }
                else if ( ([[array objectAtIndex:i0] objectForKey:@"nodeContent"] !=nil) &&  ([[[array objectAtIndex:i0]objectForKey:@"nodeName"]caseInsensitiveCompare:@"Back"]==NSOrderedSame)){
                    NSString *nodeContentValue = [[NSString alloc]initWithString:[[array objectAtIndex:i0] objectForKey:@"nodeContent"]];
                    [self setBack:[nodeContentValue doubleValue]];
                }
                else if ( ([[array objectAtIndex:i0] objectForKey:@"nodeContent"] !=nil) &&  ([[[array objectAtIndex:i0]objectForKey:@"nodeName"]caseInsensitiveCompare:@"BackSpecified"]==NSOrderedSame)){
                    NSString *nodeContentValue = [[NSString alloc]initWithString:[[array objectAtIndex:i0] objectForKey:@"nodeContent"]];
                    [self setBackSpecified:[nodeContentValue boolValue]];
                }
                else if ( ([[array objectAtIndex:i0] objectForKey:@"nodeContent"] !=nil) &&  ([[[array objectAtIndex:i0]objectForKey:@"nodeName"]caseInsensitiveCompare:@"SizePredicition"]==NSOrderedSame)){
                    NSString *nodeContentValue = [[NSString alloc]initWithString:[[array objectAtIndex:i0] objectForKey:@"nodeContent"]];
                    [self setSizePredicition:[nodeContentValue doubleValue]];
                }
                else if ( ([[array objectAtIndex:i0] objectForKey:@"nodeContent"] !=nil) &&  ([[[array objectAtIndex:i0]objectForKey:@"nodeName"]caseInsensitiveCompare:@"SizePredicitionSpecified"]==NSOrderedSame)){
                    NSString *nodeContentValue = [[NSString alloc]initWithString:[[array objectAtIndex:i0] objectForKey:@"nodeContent"]];
                    [self setSizePredicitionSpecified:[nodeContentValue boolValue]];
                }
                else if ( ([[array objectAtIndex:i0] objectForKey:@"nodeContent"] !=nil) &&  ([[[array objectAtIndex:i0]objectForKey:@"nodeName"]caseInsensitiveCompare:@"Bmi"]==NSOrderedSame)){
                    NSString* nodeContentValue = [[NSString alloc] initWithString:[[array objectAtIndex:i0] objectForKey:@"nodeContent"]];
                    if (nodeContentValue !=nil)
                        [self setBmi:nodeContentValue];
                }
                else if ( ([[array objectAtIndex:i0] objectForKey:@"nodeContent"] !=nil) &&  ([[[array objectAtIndex:i0]objectForKey:@"nodeName"]caseInsensitiveCompare:@"UnderBust"]==NSOrderedSame)){
                    NSString* nodeContentValue = [[NSString alloc] initWithString:[[array objectAtIndex:i0] objectForKey:@"nodeContent"]];
                    if (nodeContentValue !=nil)
                        [self setUnderBust:nodeContentValue];
                }
                else if ( ([[array objectAtIndex:i0] objectForKey:@"nodeContent"] !=nil) &&  ([[[array objectAtIndex:i0]objectForKey:@"nodeName"]caseInsensitiveCompare:@"UpperBust"]==NSOrderedSame)){
                    NSString* nodeContentValue = [[NSString alloc] initWithString:[[array objectAtIndex:i0] objectForKey:@"nodeContent"]];
                    if (nodeContentValue !=nil)
                        [self setUpperBust:nodeContentValue];
                }
                else if ( ([[array objectAtIndex:i0] objectForKey:@"nodeContent"] !=nil) &&  ([[[array objectAtIndex:i0]objectForKey:@"nodeName"]caseInsensitiveCompare:@"Hips"]==NSOrderedSame)){
                    NSString* nodeContentValue = [[NSString alloc] initWithString:[[array objectAtIndex:i0] objectForKey:@"nodeContent"]];
                    if (nodeContentValue !=nil)
                        [self setHips:nodeContentValue];
                }
                else if ( ([[array objectAtIndex:i0] objectForKey:@"nodeContent"] !=nil) &&  ([[[array objectAtIndex:i0]objectForKey:@"nodeName"]caseInsensitiveCompare:@"Gender"]==NSOrderedSame)){
                    NSString* nodeContentValue = [[NSString alloc] initWithString:[[array objectAtIndex:i0] objectForKey:@"nodeContent"]];
                    if (nodeContentValue !=nil)
                        [self setGender:nodeContentValue];
                }
            }
        }
        @catch(NSException *ex){
        }
    }
    return self;
}
-(NSString*)toString:(BOOL)addNameWrap {
    NSMutableString *nsString = [NSMutableString string];
    if (addNameWrap == YES)
        [nsString appendString:@"<Antwoord>" ];
    [nsString appendFormat:@"<Collarsize>%lf</Collarsize>" , [self collarsize]];
    [nsString appendFormat:@"<CollarsizeSpecified>%d</CollarsizeSpecified>" , [self collarsizeSpecified]];
    [nsString appendFormat:@"<Sleeve>%lf</Sleeve>" , [self sleeve]];
    [nsString appendFormat:@"<SleeveSpecified>%d</SleeveSpecified>" , [self sleeveSpecified]];
    [nsString appendFormat:@"<Shoulder>%lf</Shoulder>" , [self shoulder]];
    [nsString appendFormat:@"<ShoulderSpecified>%d</ShoulderSpecified>" , [self shoulderSpecified]];
    [nsString appendFormat:@"<Chest>%lf</Chest>" , [self chest]];
    [nsString appendFormat:@"<ChestSpecified>%d</ChestSpecified>" , [self chestSpecified]];
    [nsString appendFormat:@"<Belly>%lf</Belly>" , [self belly]];
    [nsString appendFormat:@"<BellySpecified>%d</BellySpecified>" , [self bellySpecified]];
    [nsString appendFormat:@"<Waist>%lf</Waist>" , [self waist]];
    [nsString appendFormat:@"<WaistSpecified>%d</WaistSpecified>" , [self waistSpecified]];
    [nsString appendFormat:@"<Arm>%lf</Arm>" , [self arm]];
    [nsString appendFormat:@"<ArmSpecified>%d</ArmSpecified>" , [self armSpecified]];
    [nsString appendFormat:@"<Wrist>%lf</Wrist>" , [self wrist]];
    [nsString appendFormat:@"<WristSpecified>%d</WristSpecified>" , [self wristSpecified]];
    [nsString appendFormat:@"<Back>%lf</Back>" , [self back]];
    [nsString appendFormat:@"<BackSpecified>%d</BackSpecified>" , [self backSpecified]];
    [nsString appendFormat:@"<SizePredicition>%lf</SizePredicition>" , [self sizePredicition]];
    [nsString appendFormat:@"<SizePredicitionSpecified>%d</SizePredicitionSpecified>" , [self sizePredicitionSpecified]];
    if (self.bmi != nil) {
        [nsString appendFormat:@"<Bmi>%@</Bmi>" , [self bmi]];
    }
    if (self.underBust != nil) {
        [nsString appendFormat:@"<UnderBust>%@</UnderBust>" , [self underBust]];
    }
    if (self.upperBust != nil) {
        [nsString appendFormat:@"<UpperBust>%@</UpperBust>" , [self upperBust]];
    }
    if (self.hips != nil) {
        [nsString appendFormat:@"<Hips>%@</Hips>" , [self hips]];
    }
    if (self.gender != nil) {
        [nsString appendFormat:@"<Gender>%@</Gender>" , [self gender]];
    }
    if (addNameWrap == YES)
        [nsString appendString:@"</Antwoord>" ];
    return nsString;
}
#pragma mark - NSCoding
-(id)initWithCoder:(NSCoder *)decoder{
    self = [super init];
    if (self){
        self.collarsize = [decoder decodeInt32ForKey:@"collarsize"];
        self.collarsizeSpecified = [decoder decodeInt32ForKey:@"collarsizeSpecified"];
        self.sleeve = [decoder decodeInt32ForKey:@"sleeve"];
        self.sleeveSpecified = [decoder decodeInt32ForKey:@"sleeveSpecified"];
        self.shoulder = [decoder decodeInt32ForKey:@"shoulder"];
        self.shoulderSpecified = [decoder decodeInt32ForKey:@"shoulderSpecified"];
        self.chest = [decoder decodeInt32ForKey:@"chest"];
        self.chestSpecified = [decoder decodeInt32ForKey:@"chestSpecified"];
        self.belly = [decoder decodeInt32ForKey:@"belly"];
        self.bellySpecified = [decoder decodeInt32ForKey:@"bellySpecified"];
        self.waist = [decoder decodeInt32ForKey:@"waist"];
        self.waistSpecified = [decoder decodeInt32ForKey:@"waistSpecified"];
        self.arm = [decoder decodeInt32ForKey:@"arm"];
        self.armSpecified = [decoder decodeInt32ForKey:@"armSpecified"];
        self.wrist = [decoder decodeInt32ForKey:@"wrist"];
        self.wristSpecified = [decoder decodeInt32ForKey:@"wristSpecified"];
        self.back = [decoder decodeInt32ForKey:@"back"];
        self.backSpecified = [decoder decodeInt32ForKey:@"backSpecified"];
        self.sizePredicition = [decoder decodeInt32ForKey:@"sizePredicition"];
        self.sizePredicitionSpecified = [decoder decodeInt32ForKey:@"sizePredicitionSpecified"];
        self.bmi = [decoder decodeObjectForKey:@"bmi"];
        self.underBust = [decoder decodeObjectForKey:@"underBust"];
        self.upperBust = [decoder decodeObjectForKey:@"upperBust"];
        self.hips = [decoder decodeObjectForKey:@"hips"];
        self.gender = [decoder decodeObjectForKey:@"gender"];
    }
    return self;
}
-(void)encodeWithCoder:(NSCoder *)encoder{
    [encoder encodeInt32:self.collarsize forKey:@"collarsize"];
    [encoder encodeInt32:self.collarsizeSpecified forKey:@"collarsizeSpecified"];
    [encoder encodeInt32:self.sleeve forKey:@"sleeve"];
    [encoder encodeInt32:self.sleeveSpecified forKey:@"sleeveSpecified"];
    [encoder encodeInt32:self.shoulder forKey:@"shoulder"];
    [encoder encodeInt32:self.shoulderSpecified forKey:@"shoulderSpecified"];
    [encoder encodeInt32:self.chest forKey:@"chest"];
    [encoder encodeInt32:self.chestSpecified forKey:@"chestSpecified"];
    [encoder encodeInt32:self.belly forKey:@"belly"];
    [encoder encodeInt32:self.bellySpecified forKey:@"bellySpecified"];
    [encoder encodeInt32:self.waist forKey:@"waist"];
    [encoder encodeInt32:self.waistSpecified forKey:@"waistSpecified"];
    [encoder encodeInt32:self.arm forKey:@"arm"];
    [encoder encodeInt32:self.armSpecified forKey:@"armSpecified"];
    [encoder encodeInt32:self.wrist forKey:@"wrist"];
    [encoder encodeInt32:self.wristSpecified forKey:@"wristSpecified"];
    [encoder encodeInt32:self.back forKey:@"back"];
    [encoder encodeInt32:self.backSpecified forKey:@"backSpecified"];
    [encoder encodeInt32:self.sizePredicition forKey:@"sizePredicition"];
    [encoder encodeInt32:self.sizePredicitionSpecified forKey:@"sizePredicitionSpecified"];
    [encoder encodeObject:self.bmi forKey:@"bmi"];
    [encoder encodeObject:self.underBust forKey:@"underBust"];
    [encoder encodeObject:self.upperBust forKey:@"upperBust"];
    [encoder encodeObject:self.hips forKey:@"hips"];
    [encoder encodeObject:self.gender forKey:@"gender"];
}
-(id)copyWithZone:(NSZone *)zone {
    Antwoord *finalCopy = [[[self class] allocWithZone: zone] init];
    
    finalCopy.collarsize = self.collarsize;
    
    finalCopy.collarsizeSpecified = self.collarsizeSpecified;
    
    finalCopy.sleeve = self.sleeve;
    
    finalCopy.sleeveSpecified = self.sleeveSpecified;
    
    finalCopy.shoulder = self.shoulder;
    
    finalCopy.shoulderSpecified = self.shoulderSpecified;
    
    finalCopy.chest = self.chest;
    
    finalCopy.chestSpecified = self.chestSpecified;
    
    finalCopy.belly = self.belly;
    
    finalCopy.bellySpecified = self.bellySpecified;
    
    finalCopy.waist = self.waist;
    
    finalCopy.waistSpecified = self.waistSpecified;
    
    finalCopy.arm = self.arm;
    
    finalCopy.armSpecified = self.armSpecified;
    
    finalCopy.wrist = self.wrist;
    
    finalCopy.wristSpecified = self.wristSpecified;
    
    finalCopy.back = self.back;
    
    finalCopy.backSpecified = self.backSpecified;
    
    finalCopy.sizePredicition = self.sizePredicition;
    
    finalCopy.sizePredicitionSpecified = self.sizePredicitionSpecified;
    
    NSString *copy21 = [self.bmi copy];
    finalCopy.bmi = copy21;
    
    NSString *copy22 = [self.underBust copy];
    finalCopy.underBust = copy22;
    
    NSString *copy23 = [self.upperBust copy];
    finalCopy.upperBust = copy23;
    
    NSString *copy24 = [self.hips copy];
    finalCopy.hips = copy24;
    
    NSString *copy25 = [self.gender copy];
    finalCopy.gender = copy25;
    
    return finalCopy;
}

@end
