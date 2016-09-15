local function run(msg, matches)
--by @UB_CH
  if is_sudo(msg) then
  local text = matches[1]
  local b = 1
  while b ~= 0 do
    text = text:trim()
    text,b = text:gsub('^!+','')
  end
  local name = matches[2]
  local file = io.open("./plugins/"..name..".lua", "w")
  file:write(text)
  file:flush()
  file:close()
  return name.." Done ;-)"
end
end 
return {
  description = "a Usefull plugin for sudo !",  
  usage = "A plugins to add Another plugins to the server #addplug name vale",
  patterns = {
    "^[!/#]addplug +(.+) (.*)$",
 "^addplug +(.+) (.*)$"
  },
  run = run
}
