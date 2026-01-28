# Agent-to-Agent Authentication & Authorization Architecture

> **A comprehensive guide to building scalable, zero-trust security for modern distributed AI agent systems**

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

## Overview

This repository provides production-ready design patterns, architectural decisions, and practical examples for implementing secure agent-to-agent communication in distributed systems. It combines **SPIFFE/SPIRE** for cryptographic workload identity, **OAuth/OIDC** for user authentication at boundaries, and **OPA** for fine-grained runtime authorization.

**Target Audience**: Senior, Staff, and Principal Engineers, Security Architects, Platform Engineers

## Why This Matters

As AI agents proliferate in production systems, traditional authentication models (API keys, shared secrets, OAuth scopes) break down:

- **Scope explosion**: OAuth scopes become unmanageable at scale
- **Static permissions**: Tokens issued at login time cannot adapt to runtime context
- **Secret sprawl**: Shared credentials pose security and operational risks
- **Zero-trust requirements**: Modern architectures demand continuous verification

This guide shows how to architect authentication and authorization that scales from dozens to thousands of agents while maintaining security, observability, and operational simplicity.

## Core Principles

1. **Separate Identity from Authorization** - SPIFFE provides identity, OPA evaluates policies
2. **Cryptographic Workload Identity** - No shared secrets, automatic rotation, mTLS by default
3. **Runtime Authorization** - Policy decisions use full request context, not static scopes
4. **OAuth at Edges, SPIFFE Internally** - Right tool for the right boundary
5. **Zero Trust** - Continuous verification, explicit policy, least privilege

## What's Included

### 📄 Design Documentation
- **[Main Article](agent_to_agent_auth_notes_spiffe_oauth_opa.md)** - Comprehensive Q&A-style design guide covering SPIFFE, OAuth, OPA, and Service Mesh integration
- **Common Anti-Patterns** - What NOT to do and why
- **Staff/Principal-Level Talking Points** - How to explain these concepts in architecture reviews

### 📊 Diagrams
- **[Core Flow Diagram](diagrams/core_flow.mmd)** - End-to-end authentication and authorization flow (Mermaid)
- Sequence diagrams for user→agent→agent communication

### 💻 Practical Examples
- **[OPA Rego Policy](examples/rego/inventory_policy.rego)** - Real-world authorization policy
- **[Envoy External Authorization](examples/k8s/envoy-ext_authz.yaml)** - Service mesh integration
- **[STS Token Exchange](examples/stsexchange/README.md)** - Cross-domain identity federation

## Quick Start

### Understand the Architecture

Start with the [main design document](agent_to_agent_auth_notes_spiffe_oauth_opa.md) which covers:
- When to use SPIFFE vs OAuth
- How OPA fits into the authorization flow
- Service mesh integration patterns
- Deployment models and scaling considerations

### Review the Flow

```
User → IdP (OAuth) → Agent A (SPIFFE) → Agent B (mTLS) → OPA (AuthZ) → Allow/Deny
```

See [diagrams/core_flow.mmd](diagrams/core_flow.mmd) for the complete sequence.

### Explore Examples

1. Check the [OPA policy examples](examples/rego/inventory_policy.rego) for authorization logic
2. Review [Kubernetes/Envoy configuration](examples/k8s/envoy-ext_authz.yaml) for deployment
3. Study [token exchange patterns](examples/stsexchange/README.md) for cross-domain scenarios

## Key Technologies

| Technology | Purpose | Role |
|------------|---------|------|
| **SPIFFE/SPIRE** | Workload Identity | Issues cryptographic identities (SVIDs) to services |
| **OAuth/OIDC** | User Identity | Authenticates users and external partners at edges |
| **OPA** | Authorization | Evaluates fine-grained policies at runtime |
| **Service Mesh** | Transport Security | Enforces mTLS, propagates identity |

## When to Use This Architecture

✅ **Good fit for:**
- Microservices with 10+ services
- AI agent systems requiring dynamic authorization
- Zero-trust architecture requirements
- Multi-tenant platforms
- Systems requiring auditability and policy governance

❌ **Overkill for:**
- Simple monolithic applications
- Static, low-complexity permission models
- Systems with < 5 services

## Common Questions

**Q: Why not just use OAuth everywhere?**  
A: OAuth is designed for user identity and delegation. It doesn't provide automatic rotation, cryptographic workload identity, or runtime authorization context needed for modern service-to-service communication.

**Q: Can I use this with Kubernetes?**  
A: Yes! SPIRE integrates natively with Kubernetes workload attestation, and OPA has extensive K8s support.

**Q: What about AWS IAM / Azure AD?**  
A: These can serve as IdPs in this architecture. SPIFFE handles the internal workload identity layer.

## Contributing

This is a living document based on real-world production experience. Contributions, corrections, and additional examples are welcome!

## License

MIT License - see LICENSE file for details

## Further Reading

- [SPIFFE Specification](https://spiffe.io/)
- [SPIRE Documentation](https://spiffe.io/docs/latest/spire-about/)
- [OPA Documentation](https://www.openpolicyagent.org/docs/latest/)
- [OAuth 2.0 RFC](https://tools.ietf.org/html/rfc6749)

---

**Created for the production engineering community** | Built from real-world architecture experience | Updated January 2026
