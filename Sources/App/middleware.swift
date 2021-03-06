import Vapor
import VaporSecurityHeaders

public func addMiddleware(_ services: inout Services) throws {
  // Register middleware
  var middlewares = MiddlewareConfig() // Create _empty_ middleware config
  middlewares.use(FileMiddleware.self) // Serves files from `Public/` directory
  middlewares.use(ErrorMiddleware.self) // Catches errors and converts to HTTP response


  // Security Middleware should always be added last
  middlewares.use(SecurityHeaders.self)

  services.register(middlewares)

  // Add security configuration
  let cspBuilder = ContentSecurityPolicy()
    .defaultSrc(sources: "'self'")
    .scriptSrc(sources: "'self' 'unsafe-eval'")
    .styleSrc(sources: "'self'")
    .fontSrc(sources: "'self' https://fonts.gstatic.com data:")

  let cspConfig = ContentSecurityPolicyConfiguration(value: cspBuilder)
  let strictTransportSecurityConfig = StrictTransportSecurityConfiguration(
    maxAge: 31536000,
    includeSubdomains: true,
    preload: true
  )

  let referrerPolicyConfig = ReferrerPolicyConfiguration(.noReferrer)

  // SecurityHeadersFactory
  let securityHeadersFactory = SecurityHeadersFactory()
    .with(contentSecurityPolicy: cspConfig)
    .with(strictTransportSecurity: strictTransportSecurityConfig)
    .with(referrerPolicy: referrerPolicyConfig)

  services.register(securityHeadersFactory.build())
}
