-- Add the directory containing HC to the path.
package.path = './?.lua;' .. package.path

-- Require it.
local HC = require('HC')

-- Make sure it works.
local rect = HC.rectangle(200, 400, 400, 20)
