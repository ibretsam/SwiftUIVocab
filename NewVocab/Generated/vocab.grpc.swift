//
// DO NOT EDIT.
// swift-format-ignore-file
//
// Generated by the protocol buffer compiler.
// Source: vocab.proto
//
import GRPC
import NIO
import NIOConcurrencyHelpers
import SwiftProtobuf


/// Usage: instantiate `Vocab_VocabServiceClient`, then call methods of this protocol to make API calls.
public protocol Vocab_VocabServiceClientProtocol: GRPCClient {
  var serviceName: String { get }
  var interceptors: Vocab_VocabServiceClientInterceptorFactoryProtocol? { get }

  func getRecentWords(
    _ request: Vocab_GetRecentWordsRequest,
    callOptions: CallOptions?
  ) -> UnaryCall<Vocab_GetRecentWordsRequest, Vocab_GetRecentWordsResponse>
}

extension Vocab_VocabServiceClientProtocol {
  public var serviceName: String {
    return "vocab.VocabService"
  }

  /// Unary call to GetRecentWords
  ///
  /// - Parameters:
  ///   - request: Request to send to GetRecentWords.
  ///   - callOptions: Call options.
  /// - Returns: A `UnaryCall` with futures for the metadata, status and response.
  public func getRecentWords(
    _ request: Vocab_GetRecentWordsRequest,
    callOptions: CallOptions? = nil
  ) -> UnaryCall<Vocab_GetRecentWordsRequest, Vocab_GetRecentWordsResponse> {
    return self.makeUnaryCall(
      path: Vocab_VocabServiceClientMetadata.Methods.getRecentWords.path,
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeGetRecentWordsInterceptors() ?? []
    )
  }
}

@available(*, deprecated)
extension Vocab_VocabServiceClient: @unchecked Sendable {}

@available(*, deprecated, renamed: "Vocab_VocabServiceNIOClient")
public final class Vocab_VocabServiceClient: Vocab_VocabServiceClientProtocol {
  private let lock = Lock()
  private var _defaultCallOptions: CallOptions
  private var _interceptors: Vocab_VocabServiceClientInterceptorFactoryProtocol?
  public let channel: GRPCChannel
  public var defaultCallOptions: CallOptions {
    get { self.lock.withLock { return self._defaultCallOptions } }
    set { self.lock.withLockVoid { self._defaultCallOptions = newValue } }
  }
  public var interceptors: Vocab_VocabServiceClientInterceptorFactoryProtocol? {
    get { self.lock.withLock { return self._interceptors } }
    set { self.lock.withLockVoid { self._interceptors = newValue } }
  }

  /// Creates a client for the vocab.VocabService service.
  ///
  /// - Parameters:
  ///   - channel: `GRPCChannel` to the service host.
  ///   - defaultCallOptions: Options to use for each service call if the user doesn't provide them.
  ///   - interceptors: A factory providing interceptors for each RPC.
  public init(
    channel: GRPCChannel,
    defaultCallOptions: CallOptions = CallOptions(),
    interceptors: Vocab_VocabServiceClientInterceptorFactoryProtocol? = nil
  ) {
    self.channel = channel
    self._defaultCallOptions = defaultCallOptions
    self._interceptors = interceptors
  }
}

public struct Vocab_VocabServiceNIOClient: Vocab_VocabServiceClientProtocol {
  public var channel: GRPCChannel
  public var defaultCallOptions: CallOptions
  public var interceptors: Vocab_VocabServiceClientInterceptorFactoryProtocol?

  /// Creates a client for the vocab.VocabService service.
  ///
  /// - Parameters:
  ///   - channel: `GRPCChannel` to the service host.
  ///   - defaultCallOptions: Options to use for each service call if the user doesn't provide them.
  ///   - interceptors: A factory providing interceptors for each RPC.
  public init(
    channel: GRPCChannel,
    defaultCallOptions: CallOptions = CallOptions(),
    interceptors: Vocab_VocabServiceClientInterceptorFactoryProtocol? = nil
  ) {
    self.channel = channel
    self.defaultCallOptions = defaultCallOptions
    self.interceptors = interceptors
  }
}

@available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
public protocol Vocab_VocabServiceAsyncClientProtocol: GRPCClient {
  static var serviceDescriptor: GRPCServiceDescriptor { get }
  var interceptors: Vocab_VocabServiceClientInterceptorFactoryProtocol? { get }

  func makeGetRecentWordsCall(
    _ request: Vocab_GetRecentWordsRequest,
    callOptions: CallOptions?
  ) -> GRPCAsyncUnaryCall<Vocab_GetRecentWordsRequest, Vocab_GetRecentWordsResponse>
}

@available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
extension Vocab_VocabServiceAsyncClientProtocol {
  public static var serviceDescriptor: GRPCServiceDescriptor {
    return Vocab_VocabServiceClientMetadata.serviceDescriptor
  }

  public var interceptors: Vocab_VocabServiceClientInterceptorFactoryProtocol? {
    return nil
  }

  public func makeGetRecentWordsCall(
    _ request: Vocab_GetRecentWordsRequest,
    callOptions: CallOptions? = nil
  ) -> GRPCAsyncUnaryCall<Vocab_GetRecentWordsRequest, Vocab_GetRecentWordsResponse> {
    return self.makeAsyncUnaryCall(
      path: Vocab_VocabServiceClientMetadata.Methods.getRecentWords.path,
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeGetRecentWordsInterceptors() ?? []
    )
  }
}

@available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
extension Vocab_VocabServiceAsyncClientProtocol {
  public func getRecentWords(
    _ request: Vocab_GetRecentWordsRequest,
    callOptions: CallOptions? = nil
  ) async throws -> Vocab_GetRecentWordsResponse {
    return try await self.performAsyncUnaryCall(
      path: Vocab_VocabServiceClientMetadata.Methods.getRecentWords.path,
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeGetRecentWordsInterceptors() ?? []
    )
  }
}

@available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
public struct Vocab_VocabServiceAsyncClient: Vocab_VocabServiceAsyncClientProtocol {
  public var channel: GRPCChannel
  public var defaultCallOptions: CallOptions
  public var interceptors: Vocab_VocabServiceClientInterceptorFactoryProtocol?

  public init(
    channel: GRPCChannel,
    defaultCallOptions: CallOptions = CallOptions(),
    interceptors: Vocab_VocabServiceClientInterceptorFactoryProtocol? = nil
  ) {
    self.channel = channel
    self.defaultCallOptions = defaultCallOptions
    self.interceptors = interceptors
  }
}

public protocol Vocab_VocabServiceClientInterceptorFactoryProtocol: Sendable {

  /// - Returns: Interceptors to use when invoking 'getRecentWords'.
  func makeGetRecentWordsInterceptors() -> [ClientInterceptor<Vocab_GetRecentWordsRequest, Vocab_GetRecentWordsResponse>]
}

public enum Vocab_VocabServiceClientMetadata {
  public static let serviceDescriptor = GRPCServiceDescriptor(
    name: "VocabService",
    fullName: "vocab.VocabService",
    methods: [
      Vocab_VocabServiceClientMetadata.Methods.getRecentWords,
    ]
  )

  public enum Methods {
    public static let getRecentWords = GRPCMethodDescriptor(
      name: "GetRecentWords",
      path: "/vocab.VocabService/GetRecentWords",
      type: GRPCCallType.unary
    )
  }
}

/// To build a server, implement a class that conforms to this protocol.
public protocol Vocab_VocabServiceProvider: CallHandlerProvider {
  var interceptors: Vocab_VocabServiceServerInterceptorFactoryProtocol? { get }

  func getRecentWords(request: Vocab_GetRecentWordsRequest, context: StatusOnlyCallContext) -> EventLoopFuture<Vocab_GetRecentWordsResponse>
}

extension Vocab_VocabServiceProvider {
  public var serviceName: Substring {
    return Vocab_VocabServiceServerMetadata.serviceDescriptor.fullName[...]
  }

  /// Determines, calls and returns the appropriate request handler, depending on the request's method.
  /// Returns nil for methods not handled by this service.
  public func handle(
    method name: Substring,
    context: CallHandlerContext
  ) -> GRPCServerHandlerProtocol? {
    switch name {
    case "GetRecentWords":
      return UnaryServerHandler(
        context: context,
        requestDeserializer: ProtobufDeserializer<Vocab_GetRecentWordsRequest>(),
        responseSerializer: ProtobufSerializer<Vocab_GetRecentWordsResponse>(),
        interceptors: self.interceptors?.makeGetRecentWordsInterceptors() ?? [],
        userFunction: self.getRecentWords(request:context:)
      )

    default:
      return nil
    }
  }
}

/// To implement a server, implement an object which conforms to this protocol.
@available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
public protocol Vocab_VocabServiceAsyncProvider: CallHandlerProvider, Sendable {
  static var serviceDescriptor: GRPCServiceDescriptor { get }
  var interceptors: Vocab_VocabServiceServerInterceptorFactoryProtocol? { get }

  func getRecentWords(
    request: Vocab_GetRecentWordsRequest,
    context: GRPCAsyncServerCallContext
  ) async throws -> Vocab_GetRecentWordsResponse
}

@available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
extension Vocab_VocabServiceAsyncProvider {
  public static var serviceDescriptor: GRPCServiceDescriptor {
    return Vocab_VocabServiceServerMetadata.serviceDescriptor
  }

  public var serviceName: Substring {
    return Vocab_VocabServiceServerMetadata.serviceDescriptor.fullName[...]
  }

  public var interceptors: Vocab_VocabServiceServerInterceptorFactoryProtocol? {
    return nil
  }

  public func handle(
    method name: Substring,
    context: CallHandlerContext
  ) -> GRPCServerHandlerProtocol? {
    switch name {
    case "GetRecentWords":
      return GRPCAsyncServerHandler(
        context: context,
        requestDeserializer: ProtobufDeserializer<Vocab_GetRecentWordsRequest>(),
        responseSerializer: ProtobufSerializer<Vocab_GetRecentWordsResponse>(),
        interceptors: self.interceptors?.makeGetRecentWordsInterceptors() ?? [],
        wrapping: { try await self.getRecentWords(request: $0, context: $1) }
      )

    default:
      return nil
    }
  }
}

public protocol Vocab_VocabServiceServerInterceptorFactoryProtocol: Sendable {

  /// - Returns: Interceptors to use when handling 'getRecentWords'.
  ///   Defaults to calling `self.makeInterceptors()`.
  func makeGetRecentWordsInterceptors() -> [ServerInterceptor<Vocab_GetRecentWordsRequest, Vocab_GetRecentWordsResponse>]
}

public enum Vocab_VocabServiceServerMetadata {
  public static let serviceDescriptor = GRPCServiceDescriptor(
    name: "VocabService",
    fullName: "vocab.VocabService",
    methods: [
      Vocab_VocabServiceServerMetadata.Methods.getRecentWords,
    ]
  )

  public enum Methods {
    public static let getRecentWords = GRPCMethodDescriptor(
      name: "GetRecentWords",
      path: "/vocab.VocabService/GetRecentWords",
      type: GRPCCallType.unary
    )
  }
}
