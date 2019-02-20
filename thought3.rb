require 'rest-client'
require 'byebug'
require 'json'
require 'time'
challenge_url = "https://http-hunt.thoughtworks-labs.net/challenge"
challenge = RestClient.get(challenge_url, headers={userId: "VEqn4fU5N"})
input_url = "https://http-hunt.thoughtworks-labs.net/challenge/input"
input  = RestClient.get(input_url, headers={userId: "VEqn4fU5N"})
founded_tool = []
tools = []
timings = []
input_data = JSON.parse(input.body)
    used_tools = input_data['toolUsage']
    used_tools.map do |tool|
         start_time = Time.parse(tool['useStartTime'])
        end_time = Time.parse(tool['useEndTime'])
        timeUsedInMinutes = (end_time - start_time )/  60
        if tools.include? tool['name']
            timings.map do |kk|
                if kk[:name] == tool['name']
                    kk[:timeUsedInMinutes] = kk[:timeUsedInMinutes] + timeUsedInMinutes
                end
            end
        else
            timings << {'name': tool['name'], timeUsedInMinutes: timeUsedInMinutes}    
        end
        tools << tool['name']
    end
data ={"toolsSortedOnUsage": timings.sort_by { |hsh| hsh[:timeUsedInMinutes] }.reverse}.to_json
puts data
output_url = "https://http-hunt.thoughtworks-labs.net/challenge/output"
output  = RestClient.post(output_url, data, headers={userId: "VEqn4fU5N",'content-type':'application/json'})
byebug
puts output
