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

#import <Foundation/Foundation.h>
#import "BioApp_Enums.h"
#import "Antwoord.h"


@interface BioApp : NSObject
{
}
@property SoapProtocolVersion soapVersion;
@property BOOL allowAutoRedirect;
@property BOOL enableDecompression;
@property (nonatomic, copy) NSString *userAgent;
@property BOOL unsafeAuthenticatedConnectionSharing;
@property BOOL useDefaultCredentials;
@property (nonatomic, copy) NSString *connectionGroupName;
@property BOOL preAuthenticate;
@property (nonatomic, copy) NSString *url;
@property int timeout;
@property (nonatomic, assign) void(*targetAction)(id target,id sender,NSString* xml);
@property (nonatomic,assign) id actionDelegate;
@property (nonatomic, strong) NSURLConnection *wsConnection;
@property (nonatomic, strong) NSMutableData *webData;
@property (nonatomic, strong) NSError *error;
@property (nonatomic, strong) NSMutableDictionary *requestHeaders;
@property (nonatomic, copy)   NSString *eventName;

///Origin Return Type:Antwoord
-(void)CalculateSize:(NSString *)Gender :(NSString *)Cm :(NSString *)Age :(NSString *)Weight :(NSString *)Height :(NSString *)Collarsize :(NSString *)Fit :(NSString *)Email :(NSString *)FCup :(NSString *)FArms :(NSString *)FWaist :(NSString *)FHips ;
-(id) initWithTarget:(id)target  AndAction:(void(*)(id target,id sender ,NSString* xml))action;
-(void) addTarget:(id)target AndAction:(void(*)(id target,id sender ,NSString* xml))action;
@end
