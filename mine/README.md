# Auto Strip Miner

## How it works

1. enter `/mine/oreVeinMiner`
2. Enter `Depth` and `Length`.
3. Turtle will ask for fuel, when not enough. Amount of fuel is calculated like this `2 * Depth + 2 * Length + 400` _(400 is Buffer for Ore Vein Mining)_
4. Turtle digs x `Depth` down.
5. Turtle checks for ores around, beneath and over it.
6. Turtle start Strip Mining 1x2 in the direction it was placed for x `Length`.
7. If Turtle finds ore around, beneath or over it -> mines it -> moves there and checks again. If nothing around move back and return strip mining.
8. When `Length` is reached return to Starting point.

## Usage

Enter `Depth` (Blocks Turtle digs down)
Enter `Length` (Blocks the Turtle mines in one direction when it reaches the given `Depth`)

## Extend

create file `customOres.lua` under the folder `/mine` and return block names like this:

```lua
return {
	"buddycards:luminis_ore",
	"minecraft:gold_ore",
}
```

### Get Block Name

U can get the block name if u place the Turtle in front of the block and write in the shell:

```sh
lua
```

```lua
turtle.inspect()
```

### Already implemented Ore names

```lua
local ores = {
	"minecraft:iron_ore",
	"minecraft:gold_ore",
	"minecraft:coal_ore",
	"minecraft:diamond_ore",
	"minecraft:redstone_ore",
	"minecraft:emerald_ore",
	"minecraft:lapis_ore",
	"minecraft:nether_quartz_ore",
	"minecraft:deepslate_iron_ore",
}
```
