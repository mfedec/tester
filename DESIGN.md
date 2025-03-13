# Design Document

## Title

Integration Testing Setup for cli or scripts that interact with servers

## Overview

### Problem Statement

Currently automated testing for cli apps or scripts that interact with one or more servers is not easy to setup. The absense of a standardized approach leads to inconsistencies in test environments, increased debugging time and unreliable test results. We need an integration testing framework that provides a reproducible, isolated, and automated environment for testing CLI interactions with various server configurations. This solution should seamlessly integrate with existing development workflows and CI/CD pipelines to improve test reliability and developer efficiency.

### Goals & Non Goals

#### Goals

- Ability to easily create and destory linux servers for testing
- Ability to easily create setup and teardown scripts for ensuring clean testing environment

#### Non Goals

- 

## Proposed Solution

### Architecture

### Workflow

- Setup pre-req's on linux servers, any applications, files that need to exist before test suite runs
- Setup CLI gem or copy over the script to execute
- Run Tests
- Teardown scripts / commands to run before/after test suite or individual tests

## Key Decisions

- Decided to go with Docker since it is very popular and its use is very common amoung developers and sys admins. This approach wasn't meant to replace tools such as test-kitchen, it was more about getting something setup quick and dirty that you could easily run in a CI environment.

## Trade-offs & Alternatives

- https://test-kitchen.chef.io/ 
- Docker isn't neccessarily the best tool to replicate a full linux environment due to the way docker was designed and intended for. I wouldn't use this setup to test infrastructure as code or config management tools like SaltStack or Ansible. I would use test-kitchen in those cases.
- Could easily adapt this to use somethign like Orbstack or Virtual box that would have a more full linux environment

## Risks and Mitigations

## Next Steps

## Open Questions
