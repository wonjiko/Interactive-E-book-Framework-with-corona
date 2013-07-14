module(..., package.seeall)

local Util = {}
function Util:trim( str )
   return ( str:gsub("^%s*(.-)%s*$", "%1") )
end
return Util