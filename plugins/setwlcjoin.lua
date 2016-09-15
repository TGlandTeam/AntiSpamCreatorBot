do
local function run(msg, matches, callback, extra)
local data = load_data(_config.moderation.data)
local rules = data[tostring(msg.to.id)]['rules']
local about = data[tostring(msg.to.id)]['description']
local hash = 'group:'..msg.to.id
local group_welcome2 = redis:hget(hash,'welcome2')
if matches[1] == 'delwlcjoin' and not matches[2] and is_owner(msg) then 
    
   redis:hdel(hash,'welcome2')
        return 'متن خوش آمد گویی پاک شد 🗑'
end

local url , res = http.request('http://api.gpmod.ir/time/')
if res ~= 200 then return "No connection" end
local jdat = json:decode(url)

if matches[1] == 'setwlcjoin' and is_owner(msg) then
redis:hset(hash,'welcome2',matches[2])
        return 'متن خوش آمد گویی گروه تنظیم شد به : \n'..matches[2]
end

if matches[1] == 'chat_add_user' or 'channel_add_user' and msg.service then
group_welcome2 = string.gsub(group_welcome2, '{gpname}', msg.to.title)
group_welcome2 = string.gsub(group_welcome2, '{firstname}', ""..(msg.action.user.first_name or '---').."")
 group_welcome2 = string.gsub(group_welcome2, '{lastname}', ""..(msg.action.user.last_name or '---').."")
  group_welcome2 = string.gsub(group_welcome2, '{username}', "@"..(msg.action.user.username or '---').."")
  group_welcome2 = string.gsub(group_welcome2, '{fatime}', ""..(jdat.FAtime).."")
  group_welcome2 = string.gsub(group_welcome2, '{entime}', ""..(jdat.ENtime).."")
  group_welcome2 = string.gsub(group_welcome2, '{fadate}', ""..(jdat.FAdate).."")
  group_welcome2 = string.gsub(group_welcome2, '{endate}', ""..(jdat.ENdate).."")
  group_welcome2 = string.gsub(group_welcome2, '{rules}', ""..(rules or '').."")
  group_welcome2 = string.gsub(group_welcome2, '{about}', ""..(about or '').."")




group_welcome2 = string.gsub(group_welcome2, '{نام گروه}', msg.to.title)
group_welcome2 = string.gsub(group_welcome2, '{نام اول}', ""..(msg.action.user.first_name or '---').."")
 group_welcome2 = string.gsub(group_welcome2, '{نام آخر}', ""..(msg.action.user.last_name or '---').."")
  group_welcome2 = string.gsub(group_welcome2, '{نام کاربری}', "@"..(msg.action.user.username or '---').."")
  group_welcome2 = string.gsub(group_welcome2, '{ساعت فارسی}', ""..(jdat.FAtime).."")
  group_welcome2 = string.gsub(group_welcome2, '{ساعت انگلیسی}', ""..(jdat.ENtime).."")
  group_welcome2 = string.gsub(group_welcome2, '{تاریخ فارسی}', ""..(jdat.FAdate).."")
  group_welcome2 = string.gsub(group_welcome2, '{تاریخ انگلیسی}', ""..(jdat.ENdate).."")

 end
return group_welcome2
end
return {
  patterns = {
  "^[!#/](setwlcjoin) +(.*)$",
  "^[!#/](delwlcjoin)$",
  "^!!tgservice (chat_add_user)$",
  "^!!tgservice (channel_add_user)$",     
  },
  run = run
}
end