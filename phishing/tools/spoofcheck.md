# spoofcheck

> Determines if a domain can be spoofed via email by checking the domain's [[spf|SPF]] and [[dkim|DKIM]] (altogether [[dmarc|DMARC]]) records for weak configurations.

---

## Determine if `$DOMAIN` Can Be Spoofed

```bash
python3 spoofcheck.py $DOMAIN
```

---

## References

[spoofcheck GitHub Repository](https://github.com/BishopFox/spoofcheck)
