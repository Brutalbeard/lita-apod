module Lita
  module Handlers
    class Apod < Handler
      route(%r{^apod$}i, command: true, help: {
        "apod" => "Gives you a pretty picture!."
      }) do |response|

        messageBody = ""

        res = http.get('https://api.nasa.gov/planetary/apod?api_key=DEMO_KEY')

        object = MultiJson.load(res.body)

        messageBody << object['hdurl'] + "\n"
        messageBody << object['explanation']

        response.reply(messageBody)

      end

      Lita.register_handler(self)
    end
  end
end