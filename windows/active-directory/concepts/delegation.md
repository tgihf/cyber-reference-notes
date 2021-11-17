# Active Directory Delegation

Active Directory Delegation allows one account to forward the service ticket of another account to a service on that other account's behalf.

The most common example of delegation is that of a user account accessing a web application that interacts with a SQL server, like so (courtesy of [this article](https://posts.specterops.io/kerberosity-killed-the-domain-an-offensive-kerberos-overview-eb04b1402c61) from [SpecterOps](https://specterops.io/)):

![[0_FzXvsaZL2Z9yo9-l.png]]

Without delegation, the web application's service account would need full access to the SQL server to perform the queries it needs to. However, if the web application's service account doesn't need full access to the SQL server, giving it that much privilege could be dangerous.

By leveraging delegation, the web application service account can use the user account's service ticket to interact with the SQL server. As a result, the web application service account doesn't have to have full access to the SQL server *and* the SQL server can restrict access on a user account-level, which is much more fine-grained and helpful.

---

## Three Types of Delegation

1. [[unconstrained-delegation|Unconstrained Delegation]]
2. [[constrained-delegation|Constrained Delegation]]
3. [[resource-based-constrained-delegation|Resource-Based Constrained Delegation]]
