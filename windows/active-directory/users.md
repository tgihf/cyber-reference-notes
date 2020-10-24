# Users

## Four General Types of Users

1. **Domain Admins**
    * Control the domain and have sole access to the domain controller
2. **Service Accounts**
    * Can be **Domain Admins**
    * Required by Windows for services such as SQL
3. **Local Administrators**
    * Can make changes to local computers and may even be able to make changes to other users
    * No access to the domain controller
4. **Domain Users**
    * Everyday users
    * Can log in to the machines they have access to
    * *May have local administrator rights on particular machines*, depending on the organization
