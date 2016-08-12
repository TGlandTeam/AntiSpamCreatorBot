do
local function run(msg, matches)

hashfun = 'bot:help:fun'
hashmods = 'bot:help:mods'
hashadmin = 'bot:help:admin'
hashver = 'bot:ver'
hash = 'bot:help'


if matches[1] == 'helpfun' then
if not is_sudo(msg) then return end
redis:set(hashfun,'waiting:'..msg.from.id)
return 'Send Your Text Now 📌'
else
if redis:get(hashfun) == 'waiting:'..msg.from.id then
redis:set(hashfun,msg.text)
return 'Done!'
end
end

if matches[1] == 'sethelpmods' then
if not is_sudo(msg) then return end

redis:set(hashmods,'waiting:'..msg.from.id)
return 'Send Your Text Now 📌'
else
if redis:get(hashmods) == 'waiting:'..msg.from.id then
redis:set(hashmods,msg.text)
return 'Done!'
end
end


if matches[1] == 'sethelpadmin' then
if not is_sudo(msg) then return end

redis:set(hashadmin,'waiting:'..msg.from.id)
return 'Send Your Text Now 📌'
else
if redis:get(hashadmin) == 'waiting:'..msg.from.id then
redis:set(hashadmin,msg.text)
return 'Done!'
end
end

if matches[1] == 'sethelp' then
if not is_sudo(msg) then return end
redis:set(hash,'waiting:'..msg.from.id)
return 'Send Your Text Now 📌'
else
if redis:get(hash) == 'waiting:'..msg.from.id then
redis:set(hash,msg.text)
return 'Done!'
end
end

if matches[1] == 'setver' then
if not is_sudo(msg) then return end
redis:set(hashver,'waiting:'..msg.from.id)
return 'Send Your Text Now 📌'
else
if redis:get(hashver) == 'waiting:'..msg.from.id then
redis:set(hashver,msg.text)
return 'انجام شد!'
end
end


if matches[1] == 'helpfun' then
if not is_momod(msg) then return end
return redis:get(hashfun)
end

if matches[1] == 'help' then
if not is_momod(msg) then return end
return redis:get(hash)
end

if matches[1] == 'helpmods' then
if not is_momod(msg) then return end
return redis:get(hashmods)
end


if matches[1] == 'helpadmin' then
if not is_admin(msg) then return end
return redis:get(hashadmin)
end

if matches[1] == 'version' then
return redis:get(hashver)
end

end

return {
    patterns = {
        '[/!#](setver)$',
        '[/!#](version)$',
        '(.*)',
    },
    run = run,
    pre_process = pre_process
}
end
