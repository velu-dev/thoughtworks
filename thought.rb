require 'rest-client'
require 'byebug'
require 'json'
challenge_url = "https://http-hunt.thoughtworks-labs.net/challenge"
challenge = RestClient.get(challenge_url, headers={userId: "VEqn4fU5N"})
input_url = "https://http-hunt.thoughtworks-labs.net/challenge/input"
input  = RestClient.get(input_url, headers={userId: "VEqn4fU5N"})
input_data = JSON.parse(input.body)
input_message = input_data['encryptedMessage']
input_key = input_data['key']
alpha = ('A'..'Z').to_a
letter_data = [];
word_data = [];
splitted_input = input_message.split(" ")
jj = 0 
splitted_input.map do |word|
    jj = jj +1
    splitted_word = word.split("")
    ii = 0
    splitted_word.map do |letter|
        ii = ii + 1
            if alpha.include?(letter)
                ind = alpha.index(letter)
                letter_data << alpha[ind.to_i - input_key.to_i]
                
            else
                letter_data << letter
            end
            if splitted_word.count == ii
                word_data << letter_data.join("")
                letter_data = []
            end
    end
    if splitted_input.count == jj
        data ={"message": word_data.join(" ")}.to_json
        puts data
        output_url = "https://http-hunt.thoughtworks-labs.net/challenge/output"
        output  = RestClient.post(output_url, data, headers={userId: "VEqn4fU5N",'content-type':'application/json'})
        byebug
        puts output
    end
end
