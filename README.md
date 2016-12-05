General Purpose 2D Collision Detection System.

Forked from https://github.com/vrld/HC in order to remove the need for luarocks.

See also http://hc.readthedocs.io/en/latest/

```lua
-- Add the directory containing HC to the path.
package.path = 'src/lib/HC/?.lua;' .. package.path

-- Require it.
local HC = require('HC')

-- Make sure it works.
local rect = HC.rectangle(200, 400, 400, 20)
```
