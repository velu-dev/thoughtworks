require 'rest-client'
require 'byebug'
require 'json'
challenge_url = "https://http-hunt.thoughtworks-labs.net/challenge"
challenge = RestClient.get(challenge_url, headers={userId: "VEqn4fU5N"})
input_url = "https://http-hunt.thoughtworks-labs.net/challenge/input"
input  = RestClient.get(input_url, headers={userId: "VEqn4fU5N"})
founded_tool = []
tool = []
input_data = JSON.parse(input.body)
    all_tools = input_data['hiddenTools']
    my_tools = input_data['tools']
    puts all_tools
    puts my_tools
    ind = ''
    splitted_tools = all_tools.split("")
    my_tools.map do |tt|
        jj = 0
        tt.split("").map do |ii|
            jj = jj + 1
            if splitted_tools.include?(ii)
                    tool << ii
                    puts splitted_tools.count
                    splitted_tools.slice!(splitted_tools.index(ii),1)
                    puts splitted_tools.count
            end
            if tt.length == jj
                ttt = tool.join("")
                if my_tools.include? ttt 
                    founded_tool << tt
                    tool = [] 
                end
            end
        end 
    end
data ={"toolsFound": founded_tool}.to_json
puts data
output_url = "https://http-hunt.thoughtworks-labs.net/challenge/output"
output  = RestClient.post(output_url, data, headers={userId: "VEqn4fU5N",'content-type':'application/json'})
byebug

puts output
