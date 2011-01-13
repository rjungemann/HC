--[[
Copyright (c) 2011 Matthias Richter

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

Except as contained in this notice, the name(s) of the above copyright holders
shall not be used in advertising or otherwise to promote the sale, use or
other dealings in this Software without prior written authorization.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
]]--

local setmetatable = setmetatable
local tonumber = tonumber
local type = type
local sqrt = math.sqrt
local cos  = math.cos
local sin  = math.sin
module(...)

local Vector = {}
Vector.__index = Vector

function new(x,y)
	local v = {x = x or 0, y = y or 0}
	setmetatable(v, Vector)
	return v
end
local vector = new

function isvector(v)
	return getmetatable(v) == Vector
end

function Vector:clone()
	return vector(self.x, self.y)
end

function Vector:unpack()
	return self.x, self.y
end

function Vector:__tostring()
	return "("..tonumber(self.x)..","..tonumber(self.y)..")"
end

function Vector.__unm(a)
	return vector(-a.x, -a.y)
end

function Vector.__add(a,b)
	return vector(a.x+b.x, a.y+b.y)
end

function Vector.__sub(a,b)
	return vector(a.x-b.x, a.y-b.y)
end

function Vector.__mul(a,b)
	if type(a) == "number" then
		return vector(a*b.x, a*b.y)
	elseif type(b) == "number" then
		return vector(b*a.x, b*a.y)
	else
		return a.x*b.x + a.y*b.y
	end
end

function Vector.__div(a,b)
	return vector(a.x / b, a.y / b)
end

function Vector.__eq(a,b)
	return a.x == b.x and a.y == b.y
end

function Vector.__lt(a,b)
	return a.x < b.x or (a.x == b.x and a.y < b.y)
end

function Vector.__le(a,b)
	return a.x <= b.x and a.y <= b.y
end

function Vector.permul(a,b)
	return vector(a.x*b.x, a.y*b.y)
end

function Vector:len2()
	return self * self
end

function Vector:len()
	return sqrt(self*self)
end

function Vector.dist(a, b)
	return (b-a):len()
end

function Vector:normalize_inplace()
	local l = self:len()
	self.x, self.y = self.x / l, self.y / l
	return self
end

function Vector:normalized()
	return self / self:len()
end

function Vector:rotate_inplace(phi)
	local c, s = cos(phi), sin(phi)
	self.x, self.y = c * self.x - s * self.y, s * self.x + c * self.y
	return self
end

function Vector:rotated(phi)
	return self:clone():rotate_inplace(phi)
end

function Vector:perpendicular()
	return vector(-self.y, self.x)
end

function Vector:projectOn(v)
	return (self * v) * v / v:len2()
end

function Vector:cross(other)
	return self.x * other.y - self.y * other.x
end
