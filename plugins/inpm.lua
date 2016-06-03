local function pre_process(msg)
local to = msg.to.type
local service = msg.service
	if to == 'user' and msg.fwd_from then
		if not is_support(msg.from.id) and not is_admin1(msg) then
			return
		end
		local user = 'user#id'..msg.from.id
		local from_id = msg.fwd_from.peer_id
		if msg.fwd_from.first_name then
			from_first_name = msg.fwd_from.first_name:gsub("_", " ")
		else
			from_first_name = "None"
		end
		if msg.fwd_from.last_name then
			from_last_name = msg.fwd_from.last_name:gsub("_", " ")
		else
			from_last_name = "None"
		end
		if msg.fwd_from.username then
			from_username = "@"..msg.fwd_from.username
		else
			from_username = "@[none]"
		end
		text = "User From Info:\n\nID: "..from_id.."\nFirst: "..from_first_name.."\nLast: "..from_last_name.."\nUsername: "..from_username
		send_large_msg(user, text)
	end
	return msg
end

local function chat_list(msg)
	i = 1
	local data = load_data(_config.moderation.data)
    local groups = 'groups'
    if not data[tostring(groups)] then
        return 'No groups at the moment'
    end
    local message = 'List of Groups:\n\n'
    for k,v in pairsByKeys(data[tostring(groups)]) do
		local group_id = v
		if data[tostring(group_id)] then
			settings = data[tostring(group_id)]['settings']
		end
		if settings then
			if not settings.public then
				public = 'no'
			else
				public = settings.public
			end
		end
        for m,n in pairsByKeys(settings) do
			--if m == 'public' then
				--public = n
			--end
			if public == 'no' then 
				group_info = ""
			elseif m == 'set_name' and public == 'yes' then
				name = n:gsub("", "")
				chat_name = name:gsub("‮", "")
				group_name_id = name .. '\n(ID: ' ..group_id.. ')\n\n'
				if name:match("[\216-\219][\128-\191]") then
					group_info = i..' - \n'..group_name_id
				else
					group_info = i..' - '..group_name_id
				end
				i = i + 1
			end
        end
		message = message..group_info
    end
        local file = io.open("./groups/lists/listed_groups.txt", "w")
        file:write(message)
        file:flush()
        file:close()
	return message
end

function super_help()
  local help_text = tostring(_config.help_text_super)
  return help_text
end

local function run(msg, matches)
local to = msg.to.type
local service = msg.service
local name_log = user_print_name(msg.from)

	if msg.service and user_type == "support" and msg.action.type == "chat_add_user" and msg.from.id == 0 then
		local user_id = msg.action.user.id
		local user_name = msg.action.user.print_name
		local username = msg.action.user.username
		local group_name = string.gsub(msg.to.print_name, '_', ' ')
		savelog(msg.from.id, "Added Support member "..user_name.." to chat "..group_name.." (ID:"..msg.to.id..")")
		if username then
			send_large_msg("user#id"..user_id, "Added support member\n@"..username.."["..user_id.."] to chat:\n 👥 "..group_name.." (ID:"..msg.to.id..")" )
		else
			send_large_msg("user#id"..user_id, "Added support member\n["..user_id.."] to chat:\n 👥 "..group_name.." (ID:"..msg.to.id..")" )
		end
	end
	if msg.service and user_type == "admin" and msg.action.type == "chat_add_user" and msg.from.id == 0 then
		local user_id = msg.action.user.id
		local user_name = msg.action.user.print_name
		local username = msg.action.user.username
		savelog(msg.from.id, "Added Admin "..user_name.."  "..user_id.." to chat "..group_name.." (ID:"..msg.to.id..")")
		if username then
			send_large_msg("user#id"..user_id, "Added admin\n@"..username.."["..user_id.."] to chat:\n 👥 "..group_name.." (ID:"..msg.to.id..")" )
		else
			send_large_msg("user#id"..user_id, "Added admin:\n["..user_id.."] to chat:\n 👥 "..group_name.." (ID:"..msg.to.id..")" )
		end
	end

	if msg.service and user_type == "regular" and msg.action.type == "chat_add_user" and msg.from.id == 0 then
		local user_id = msg.action.user.id
		local user_name = msg.action.user.print_name
		print("Added "..user_id.." to chat "..msg.to.print_name.." (ID:"..msg.to.id..")")
		savelog(msg.from.id, "Added "..user_name.." to chat "..msg.to.print_name.." (ID:"..msg.to.id..")")
		send_large_msg("user#id"..user_id, "Added you to chat:\n\n"..group_name.." (ID:"..msg.to.id..")")
	end

	if matches[1] == 'help' and msg.to.type == 'user' or matches[1] == 'pmhelp' and is_admin1(msg) and msg.to.type ~= 'user' then
      	savelog(msg.to.id, name_log.." ["..msg.from.id.."] used pm help")
		text = "Welcome to XManager!\n\nThis is a bot run by @regalstreak for managing the official halogenOS (XOS) group @halogenOS on Telegram\n\nCheck out our channel @halogenOSNews\n\nAlso join our halogenOS off-topic Group @halogenOSOT\n\nYou may visit http://halogenos.org/ for knowing more!"
     	return text
    end

	if matches[1] == 'superhelp' and is_admin1(msg)then
      	savelog(msg.to.id, name_log.." ["..msg.from.id.."] Used /superhelp")
     	return super_help()
	elseif matches[1] == 'superhelp' and to == "user" then
		local name_log = user_print_name(msg.from)
      	savelog(msg.to.id, name_log.." ["..msg.from.id.."] Used /superhelp")
     	return super_help()
    end

    if matches[1] == 'chats' and is_admin1(msg)then
		return chat_list(msg)
	elseif matches[1] == 'chats' and to == 'user' then
		savelog(msg.to.id, name_log.." ["..msg.from.id.."] Used /chats")
		return chat_list(msg)
    end

	if matches[1] == 'chatlist' then
	savelog(msg.to.id, name_log.." ["..msg.from.id.."] Used /chatlist")
		if is_admin1(msg) and msg.to.type == 'chat' or msg.to.type == 'channel' then
			chat_list(msg)
			send_document("chat#id"..msg.to.id, "./groups/lists/listed_groups.txt", ok_cb, false)
			send_document("channel#id"..msg.to.id, "./groups/lists/listed_groups.txt", ok_cb, false)
		elseif msg.to.type == 'user' then
			chat_list(msg)
			send_document("user#id"..msg.from.id, "./groups/lists/listed_groups.txt", ok_cb, false)
		end
	end
end

return {
    patterns = {
	"^[#!/](help)$",
	"^[#!/](pmhelp)$",
	"^[#!/](superhelp)$",
    "^[#!/](chats)$",
    "^[#!/](chatlist)$",
    "^[#!/](join) (%d+)$",
	"^[#!/](join) (.*) (support)$",
    "^[#!/](kickme) (.*)$",
    "^!!tgservice (chat_add_user)$",
    },
    run = run,
	pre_process = pre_process
}