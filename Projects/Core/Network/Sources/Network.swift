import Dependencies
import Foundation
import Moya

public final class Network {
    internal var provider: MoyaProvider<MultiTarget>
    
    public init(provider: MoyaProvider<MultiTarget> = MoyaProvider(plugins: [
        NetworkLoggerPlugin()
    ])) {
        self.provider = provider
    }
}
