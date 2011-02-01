
#import "UIDevice-hardware.h"
#include <sys/types.h>
#include <sys/sysctl.h>

@implementation UIDevice (Hardware)

/*
 Platforms
 iPhone1,1 -> iPhone 1G
 iPhone1,2 -> iPhone 3G 
 iPhone2,1 -> iPPhone 3G S
 iPod1,1   -> iPod touch 1G 
 iPod2,1   -> iPod touch 2G 
*/

+ (NSString *) platform
{
	size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = malloc(size);
	sysctlbyname("hw.machine", machine, &size, NULL, 0);
	NSString *platform = [NSString stringWithCString:machine encoding: NSUTF8StringEncoding];
	free(machine);
	return platform;
}

+ (int) platformType
{
	NSString *platform = [UIDevice platform];
	if ([platform isEqualToString:@"iPhone1,1"]) return UIDevice1GiPhone;
	if ([platform isEqualToString:@"iPhone1,2"]) return UIDevice3GiPhone;
	if ([platform isEqualToString:@"iPhone2,1"]) return UIDevice3GSiPhone;
	if ([platform isEqualToString:@"iPod1,1"])   return UIDevice1GiPod;
	if ([platform isEqualToString:@"iPod2,1"])   return UIDevice2GiPod;
	if ([platform isEqualToString:@"iPad1,1"])   return UIDevice1GiPad;
	if ([platform hasPrefix:@"iPhone"]) return UIDeviceUnknowniPhone;
	if ([platform hasPrefix:@"iPod"]) return UIDeviceUnknowniPod;
	if ([platform hasPrefix:@"iPad"]) return UIDeviceUnknowniPad;
	return UIDeviceUnknown;
}

+ (int) deviceType
{
	NSString *platform = [UIDevice platform];
	if ([platform hasPrefix:@"iPad"] || [platform hasPrefix:@"i386"]) return UIDeviceTypePad;
	return UIDeviceTypePhone;
}

+ (BOOL) isIPad {
	UIDevice *cd = [UIDevice currentDevice];
	if (![cd respondsToSelector:@selector(userInterfaceIdiom)]) return NO;
	return cd.userInterfaceIdiom == UIUserInterfaceIdiomPad;
}

+ (NSString *) platformString
{
	switch ([UIDevice platformType])
	{
		case UIDevice1GiPhone: return IPHONE_1G_NAMESTRING;
		case UIDevice3GiPhone: return IPHONE_3G_NAMESTRING;
		case UIDevice3GSiPhone: return IPHONE_3GS_NAMESTRING;
		case UIDeviceUnknowniPhone: return IPHONE_UNKNOWN_NAMESTRING;
		
		case UIDevice1GiPod: return IPOD_1G_NAMESTRING;
		case UIDevice2GiPod: return IPOD_2G_NAMESTRING;
		case UIDeviceUnknowniPod: return IPOD_UNKNOWN_NAMESTRING;
		case UIDevice1GiPad: return IPAD_1G_NAMESTRING;
		case UIDeviceUnknowniPad: return IPAD_UNKNOWN_NAMESTRING;
		default: return nil;
	}
}

+ (int) platformCapabilities
{
	switch ([UIDevice platformType])
	{
		case UIDevice1GiPhone: return UIDeviceBuiltInSpeaker | UIDeviceBuiltInCamera | UIDeviceBuiltInMicrophone | UIDeviceSupportsExternalMicrophone | UIDeviceSupportsTelephony | UIDeviceSupportsVibration;
		case UIDevice3GiPhone: return UIDeviceSupportsGPS | UIDeviceBuiltInSpeaker | UIDeviceBuiltInCamera | UIDeviceBuiltInMicrophone | UIDeviceSupportsExternalMicrophone | UIDeviceSupportsTelephony | UIDeviceSupportsVibration;
		case UIDevice3GSiPhone: return UIDeviceSupportsGPS | UIDeviceBuiltInSpeaker | UIDeviceBuiltInCamera | UIDeviceBuiltInMicrophone | UIDeviceSupportsExternalMicrophone | UIDeviceSupportsTelephony | UIDeviceSupportsVibration | UIDeviceSupportsMagnetometer;
		case UIDeviceUnknowniPhone: return UIDeviceBuiltInSpeaker | UIDeviceBuiltInCamera | UIDeviceBuiltInMicrophone | UIDeviceSupportsExternalMicrophone | UIDeviceSupportsTelephony | UIDeviceSupportsVibration;

		case UIDevice1GiPod: return 0;
		case UIDevice2GiPod: return UIDeviceBuiltInSpeaker | UIDeviceBuiltInMicrophone | UIDeviceSupportsExternalMicrophone;
		case UIDeviceUnknowniPod: return 0;
		
		default: return 0;
	}
}

@end
