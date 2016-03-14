# Circum

A Minimalist Game Design Project

### Standard Procedures
- There will never (ever) be any pushing to master.
  - There will only be pull requests from branches.
- PRs will be subject to peer review before merging with master.

### Suggested GML Code Conventions
that we should ALL adhere to for the sake of consistency.
- Hungarian notation will be used when naming objects, sprites, and other resource tree elements.
  - Object: o_some_object
  - Sprite: s_some_sprite
- Use semi-colons, even though they are not required.
- Always use brackets even for statements and loops that contain only 1 line.
  - Preferred bracket style:
```
while(true) {
	\\...
}
```
- Do not capitalize global variables as they are always preceded with 'global'--a suitable-enough identifier.
- All global variables will be defined in a single object (i.e. o_globals).
- All global constants will be defined under 'User-Defined Macros'.
- Fully capitalize enums.
- Optional: Explicit identification of calling instance (i.e. ```self.x```).
- camel_case.
NOTE: Code from third-party sources (GM Marketplace, GMScripts, etc.) need not be reformatted.

Why aren't we using GM Studio's built-in source control?
Because it is shit in its purest form. 
