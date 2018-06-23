# lita-apod

Responds back with today's Astronomy Picture of the Day!

## Installation

Add lita-apod to your Lita instance's Gemfile:

``` ruby
gem "lita-apod"
```

## Configuration

~~No configuration necessary! NASA gives their API away for free!!~~

Nasa limits their API calls using their free demo key. If you're going to use this for a pretty active bot, get a key from https://api.nasa.gov/api.html#authentication. Otherwise, 'DEMO_KEY' will work for the default key.

Put the below in your lita-config.rb file and have fun!

```config.handlers.apod.apod_api_key = 'DEMO_KEY'```

## Usage

Once installed, ```Lita: apod``` or ```Lita: apod?```