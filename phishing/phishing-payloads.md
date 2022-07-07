# Phishing Payloads

---

## HTML Application (HTA) Link

See [[hta|here]] for payload generation assistance.

1. User clicks link and downloads `payload.hta`
2. User executes `payload.hta`
3. Payload executes in the background and `payload.hta`'s HTML is rendered

**Note** that an HTA can't be attached to an email. It **must** be a link.

---

## Microsoft Office Macro Attachment

See [[office-macro-generation|here]] for payload generation assistance.

1. User opens attachment
2. Document is opened in relevant Office product
3. User clicks `Enable Content`
4. Payload executes in the background


