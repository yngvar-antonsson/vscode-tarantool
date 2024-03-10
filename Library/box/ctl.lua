---@meta
--luacheck: ignore

---@class boxCtl
box.ctl = {}


---Wait until box.info.ro is false.
---@async
---@param timeout? number
function box.ctl.wait_rw(timeout) end

---Wait until box.info.ro is true.
---@async
---@param timeout? number
function box.ctl.wait_ro(timeout) end

function box.ctl.on_shutdown() end
