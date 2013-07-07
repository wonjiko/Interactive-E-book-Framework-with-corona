-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here

local xml = require( "xml" ).newParser()

local contents = xml:loadFile( "sample.xml" )

local message = {}
-- for each "child" in the contents table...
for i=1,#contents.child do
	
	-- store the address in the message table
	message[i] = contents.child[i]
	print("name : " .. message[i].name);
	print("value : " .. message[i].value);
	--print("properties : " .. message[i].properties);
	--print("child : " .. message[i].child);
end
