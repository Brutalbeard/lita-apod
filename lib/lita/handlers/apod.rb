module Lita
  module Handlers
    class Apod < Handler

      config :apod_api_key

      route(%r{^apod\?$}i, command: true, help: {
        "apod?" => "Gives you a RANDOM pretty picture! Pulled random from the NASA Picture of the Day. https://apod.nasa.gov/"
      }) do |response|

        rando = Time.at(rand((Time.now - (60*60*24*365*5))..Time.now)).strftime('%Y-%m-%d')

        messageBody = ""

        res = http.get("https://api.nasa.gov/planetary/apod?api_key=#{config.apod_api_key}&date=#{rando}")

        object = MultiJson.load(res.body)

        messageBody << object['hdurl'] + "\n"
        messageBody << object['explanation']

        response.reply(messageBody)

      end

      route(%r{^apod$}i, command: true, help: {
        "apod" => "Gives you a pretty picture! Pulled from the NASA Picture of the Day. https://apod.nasa.gov/"
      }) do |response|

        messageBody = ""

        res = http.get("https://api.nasa.gov/planetary/apod?api_key=#{config.apod_api_key}")

        object = MultiJson.load(res.body)

        messageBody << object['hdurl'] + "\n"
        messageBody << object['explanation']

        response.reply(messageBody)

      end

      Lita.register_handler(self)
    end
  end
end