-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here
--[[
print( "hello" )
local onComplete = function(event)
   print( "video session ended" )
end
media.playVideo( "Movie.m4v", true, onComplete )
--]]

local webView = native.newWebView( 0, 0, 320, 480 )
webView:request( "index.html", system.ResourceDirectory )
