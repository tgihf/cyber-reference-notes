# Tokens

Tokens are temporary keys that allow you access to a system/network without having to provide credentials. Think cookies for computers.

## Two Types of Tokens

1. Delegate: created for logging into a machine or using Remote Desktop
2. Impersonate: non-interactive such as attaching a network drive or a domain logon script

## Token Impersonation

As a user on a machine, you can enumerate the currently available tokens and utilize one of the tokens to impersonate the token's user account. From then on, any actions you take you take **as that user account**.
