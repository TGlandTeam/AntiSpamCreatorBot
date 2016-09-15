local function run(msg, matches)
local url = "https://source.unsplash.com/random"
local file = download_to_file(url,'img.png')
send_photo(get_receiver(msg),file,ok_cb,true)
end
return {
patterns = {
"^[#!/]([Ii]mg)$",
"^عکس$"
},
run = run,
} 