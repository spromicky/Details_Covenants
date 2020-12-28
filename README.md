# Details!|Skada Covenants

Plugin for **Details!** and **Skada**, that show covenant icon near player name.

### How it works:

Blizzard don't allow to inspect in which covenant is other players. Only yours own covenant is available in API. So addon track spells casted by your teammates and detect covenant by this spells (both main covenant ability and minor). Thats why covenant icons appears after only few fights.

This is a first version and not tested for all combination of covenant/class/spec, so if you have problem with covenant detection please report an issue.

**Important for Details!**: Its based on nickname feature of Details. You shouldn't disable nicknames, for correct work.

### Icon size:

You change icon size with commands: `/dc 18`, `/dcovenants 24`. Default value is `16`.
