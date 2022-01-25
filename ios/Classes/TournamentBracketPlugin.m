#import "TournamentBracketPlugin.h"
#if __has_include(<tournament_bracket/tournament_bracket-Swift.h>)
#import <tournament_bracket/tournament_bracket-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "tournament_bracket-Swift.h"
#endif

@implementation TournamentBracketPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftTournamentBracketPlugin registerWithRegistrar:registrar];
}
@end
