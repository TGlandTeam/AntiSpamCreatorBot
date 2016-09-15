local function run(msg, matches)
local url , res = http.request('http://api.gpmod.ir/time/')
local jdat = json:decode(url)
local date = jdat.FAdate
return date
end
return {
  patterns = {"^[#/!]([Tt][Ii][Mm][Ee])$"}, 
run = run 
}
