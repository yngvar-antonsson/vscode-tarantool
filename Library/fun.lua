---@meta

--luacheck:ignore
---@class fun
local m = {}

m.op = {}

---Returns true when argument is not nil and not false
---@param arg any
---@return boolean
function m.op.truth(arg) end

---Returns a + b
---@param a number
---@param b number
---@return number
function m.op.add(a, b) end

---Chains given iterators to single iterator
---@param ... Iterator|table
---@return Iterator
function m.chain(...) end

---@class Iterator
local i = {}

---Returns number of elemenths
---@param tbl table
---@return number length of the items
function m.length(tbl) end

---@param arg Iterator|table
---@return any[]
function m.totable(arg) end

---Builds iterator from incoming type
---@overload fun(generator: (fun(state: any, param: any): ...), param: any, state: any?): Iterator
---@generic T
---@param tbl T[]
---@return Iterator
function m.iter(tbl) end

---Checks that all items accepts given condition
---@generic T
---@param items T[] list of items
---@param func fun(T):boolean acceptor
---@return boolean
function m.all(func, items) end

--- Returns iterator of range numbers
---@param a number
---@param b number
---@return Iterator
function m.range(a, b) end

--- Returns infinite iterator of 0's
---@return Iterator<number>
function m.zeros() end

--- Returns infinite iterator of 0's
---@generic T, E
---@param mapper fun(t: T): E remap function
---@param list T[] list of items
---@return Iterator
function m.map(mapper, list) end

---Filters given arguments against filter
---@param filter (fun(any): boolean) | string
---@param list any
---@return Iterator
function m.grep(filter, list) end

---Zips N iterators into one
---@param ... Iterator
---@return Iterator
function m.zip(...) end

---Returns infinite iterator of 1
---@return Iterator
function m.ones() end

---Returns infinite iterator of 1
---@param func fun(any)
---@param list any
function m.each(func, list) end

---Returns infinite iterator of 1
---@param func fun(any)
---@param list any
function m.foreach(func, list) end

---@generic T
---@param tbl T[]
---@return T
function m.min(tbl) end

---@generic T
---@param tbl T[]
---@return T
function m.max(tbl) end

---Remaps content of iterator
---Returns iterator
---@param mapper fun(...:any):...any
---@return Iterator
function i:map(mapper) end

---Returns iterator with numerated
---@return Iterator
function i:enumerate() end

---Filters original iterator with given predicate
---@generic T
---@param grepper fun(item: T): boolean
---@return Iterator
function i:grep(grepper) end

---Filters original iterator with given predicate
---@generic T
---@param grepper fun(item: T): boolean
---@return Iterator
function i:filter(grepper) end

---Counts length of iterator (reducer)
---@return number
function i:length() end

---Builds list of iterator (reducer)
---@generic T
---@return T[]
function i:totable() end

---Builds kv map of the iterator (reducer)
---@return table<any, any>
function i:tomap() end

---Indexes iterator with given index (reducer)
---@param idx number
---@return any
function i:nth(idx) end

---Summarizes iterator items
---@return number
function i:sum() end

---Zips 2 iterators into one
---@generic E
---@param iter Iterator<E>
---@return Iterator
function i:zip(iter) end

---@param cmp fun(any,any): boolean
---@return any
function i:max_by(cmp) end

---Chains given iterator to single iterator
---@param ... Iterator
---@return Iterator
function i:chain(...) end

---Ends iterator when filter returns falsy
---@param filter fun(any): boolean
---@return Iterator
function i:take_while(filter) end

---Skips items while filter is false
---@param filter fun(any): boolean
---@return Iterator
function i:drop_while(filter) end

---calls func for each value
---@param func fun(any)
function i:each(func) end

---@param reducer fun(acc: any, ...:any):any
---@param init_val any? initial value
---@return any
function i:reduce(reducer, init_val) end

return m
