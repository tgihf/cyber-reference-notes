# Planning an Offensive Engagement

---

## Considerations

### 1. Objective

Ensure you have a crystal clear understanding of the enagement's objective.

### 2. Scoping

What's the scope of the engagement? Which assets are in play and which are out? Which personnel are in play and which are out?

For a red team engagement, this conversation is more geared towards building a scenario for the engagement from which the in-play and out-of-play assets and personnel naturally emerge.

### 3. Threat Model

The role of a red team is to emulate a particular threat to an organization. During the planning process, work with the organization to determine which threat the red team will be emulating during the engagement.

Once a particular threat has been identified, the red team must build a corresponding **threat model**. This profile defines how the team will emulate the threat by identifying its intent, motivations, capabilities, habits, TTPs, and so on.

For a known threat, much of this information can be found from various threat intelligence sources (i.e., [MITRE ATT&CK](https://attack.mitre.org/matrices/enterprise/)).

For a generic threat, the red team may construct a profile that reflects the typical capabilities of that type of threat.

### 4. Breach Model

The engagement's breach model outlines the means by which the red team will gain access to the target environment.

This is usually by attempting to gain access in accordance with the determined [[planning-an-engagement#3 Threat Model|threat model]], but may instead be an [[assume-breach|assume breach]] model. Some engagements use the former as the primary breach model, but if the red team hasn't gained access within the first quarter or so of the engagement, they are granted access via the latter. This maximizes the effectiveness of the engagement.

### 5. Notification & Announcements

Red team engagements are generally arranged by an organization's upper management in security or compliance roles and they face a choice: do they inform all, some, or no one else in the organization about the upcoming engagement?

### 6. Rules of Engagement

The rules of engagement (RoE) document defines the rules and methodologies by which the engagement will be conducted. It should be agreed on and signed by all parties involved. The RoE should:

- Define the engagement objective(s)
- Define the target(s) of the engagement, including domains, IP ranges, assets, etc.
- Identify any legal and/or regulatory requirements and/or restrictions
- Contain emergency contact lists for key persons in all parties

If the engagement contains a physical component, a "get out of jail letter" should be drafted and given to members of the engagement in the event they are apprehended by law enforcement.

### 7. Record Keeping & Deconfliction

Red team members should maintain records of their activity during the engagement. In the event an incident occurs, the organization and any digital forensics and incident response personnel will need to be able to identify whether activity observed is the result of the engagement or not.

Keep track of your actions taken and when you took each one.

---

## References

[Certified Red Team Operator Course - ZeroPoint Security](https://training.zeropointsecurity.co.uk/courses/take/red-team-ops)
