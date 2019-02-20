require 'rest-client'
require 'byebug'
require 'json'
require 'time'
challenge_url = "https://http-hunt.thoughtworks-labs.net/challenge"
challenge = RestClient.get(challenge_url, headers={userId: "VEqn4fU5N"})
input_url = "https://http-hunt.thoughtworks-labs.net/challenge/input"
input  = RestClient.get(input_url, headers={userId: "VEqn4fU5N"})
input_data = JSON.parse(input.body)
tools = input_data['tools']
toolsToTakeSorted = []
maxweight = input_data['maximumWeight']
tools = tools.sort_by { |hsh| hsh['value']}.reverse
puts tools
weight= 0 
    tools.map do |kk|
        if weight < maxweight
            toolsToTakeSorted << kk['name']
        end
            weight = weight + kk['weight']
    end
data ={ "toolsToTakeSorted": toolsToTakeSorted }.to_json
puts data
output_url = "https://http-hunt.thoughtworks-labs.net/challenge/output"
output  = RestClient.post(output_url, data, headers={userId: "VEqn4fU5N",'content-type':'application/json'})
byebug
puts output
