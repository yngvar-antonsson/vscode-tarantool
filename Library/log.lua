---@meta
--luacheck: ignore
---@module 'log'

---@class log: table
local log = {}

---
---@param s any
---@param ... any
function log.warn(s, ...) end

---
---@param s any
---@param ... any
function log.info(s, ...) end

---
---@param s any
---@param ... any
function log.error(s, ...) end

---
---@param s any
---@param ... any
function log.verbose(s, ...) end

---
---@param s any
---@param ... any
function log.debug(s, ...) end

---sets log level
---@param lvl number
function log.level(lvl) end

return log