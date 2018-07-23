module Lita
  module Handlers
    class Apod < Handler
      config :apod_api_key

      route(/^apod\?$/i, command: true, help: {
              'apod?' => 'Gives you a RANDOM pretty picture! Pulled random from the NASA Picture of the Day. https://apod.nasa.gov/'
            }) do |response|

        rando = Time.at(rand((Time.now - (60 * 60 * 24 * 365 * 5))..Time.now)).strftime('%Y-%m-%d')

        res = http.get("https://api.nasa.gov/planetary/apod?api_key=#{config.apod_api_key}&date=#{rando}")

        object = MultiJson.load(res.body)

        # uses the discordrb library to send an embedded image. very pretty
        robot.chat_service.channel(response.room.id).send_embed do |embed|
          embed.title = object['title']
          embed.description = object['explanation']
          embed.timestamp = Time.new(object['date']) # or whatever Time
          embed.image = { url: object['hdurl'] }
          embed.footer = object['copyright'] ? { text: 'Credit: ' << object['copyright'] } : nil
          embed.color = '00CC00'
        end
      end

      route(/^apod$/i, command: true, help: {
              'apod' => 'Gives you a pretty picture! Pulled from the NASA Picture of the Day. https://apod.nasa.gov/'
            }) do |response|

        res = http.get("https://api.nasa.gov/planetary/apod?api_key=#{config.apod_api_key}")

        object = MultiJson.load(res.body)

        # uses the discordrb library to send an embedded image. very pretty
        robot.chat_service.channel(response.room.id).send_embed do |embed|
          embed.title = object['title']
          embed.description = object['explanation']
          embed.timestamp = Time.new(object['date']) # or whatever Time
          embed.image = { url: object['hdurl'] }
          embed.footer = object['copyright'] ? { text: 'Credit: ' << object['copyright'] } : nil
          embed.color = '00CC00'
        end
      end

      Lita.register_handler(self)
    end
  end
end
