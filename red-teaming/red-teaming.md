# Red Teaming

---

## What is Red Teaming?

**From ZeroPoint Security's Certified Red Team Operator (CRTO) Course**:

"Red Teaming" is a term that's used a lot within the cyber security space. Its meaning and purpose has been malformed over time, or at least is not standardised due to several factors, including misuse of the name within vendor marketing; and a misunderstanding of compliance requirements. I shall attempt to provide an accurate definition here that will set the scene for the course content - we need to understand what red teams are, what they do and why they do it (and perhaps just as importantly, what they're **not** for).

A good dictionary definition is provided by Joe Vest and James Tubberville:

> Red Teaming is the process of using tactics, techniques and procedures (TTPs) to emulate a real-world threat, with the goal of measuring the effectiveness of the people, processes and technologies used to defend an environment.

Red teams provide an adversarial perspective by attacking assumptions made by an organisation and defenders. Assumptions such as _"we're secure because we patch"_; _"only X number of people can access that system"_; and _"technology Y would stop that"_ are dangerous and often don't stand up to scrutiny. By challenging these assumptions, a red team can identify areas for improvement in an organisations operational defence.

Even though there is some cross-over with penetration testing, there are some key differences that I'd like to highlight.

A typical penetration test will focus on a single technology stack - either because it's part of a project lifecycle or part of a compliance requirement, (e.g. monthly or annual assessments). The goals are to identify as many vulnerabilities as possible, demonstrate how those may be exploited, and provide some contextual risk ratings. The output is typically a report containing each vulnerability and remediation actions, such as install a patch or reconfigure some software. There is no explicit focus on detection or response, does not assess people or processes and there is no specific objective other than "exploit the system(s)".

In contrast, red teams have a clear objective defined by the organisation - whether that be to gain access to a particular system, email account, database or file share. Because after all, organisations are defending "something" and compromising the confidentiality, integrity and/or availability of that "something" represents a tangible risk, be it financial or reputational. A red team will also emulate a real-life threat to the organisation. For example, a finance company may be at risk from known FIN groups. In the case of a penetration test, a tester will simply use their personally preferred TTPs whereas a red team will study and re-use (where appropriate) the TTPs of the threat they're emulating. This allows the organisation to build detections and processes designed to combat the very threat(s) they expect to face. Red teams will also look holistically at the overall security posture of an organisation and not be laser-focused to one specific area - this of course includes people and processes as well as technology. Finally, red teams put a heavy emphasis on stealth and the "principal of least privilege". To challenge the detection and response capabilities, they need to reach the objective without getting caught - part of this is not going after high-privileged accounts (such as Domain Admin) unnecessarily. If "Bob from Accounting" can access the objective, then that's all they'll do.

---

## References

[What is Red Teaming? - ZeroPoint Security CRTO](https://training.zeropointsecurity.co.uk/courses/take/red-team-ops/texts/30311428-what-is-red-teaming)
