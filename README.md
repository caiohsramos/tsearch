# Tsearch

## Installation

Install it yourself as:

    $ gem install tsearch

## Usage

```
Usage:
  tsearch search

Options:
  -h, [--help], [--no-help]        # Display usage information
  -s, [--string=STRING]            # Search by string
  -i, [--imdb=IMDB]                # Search by IMDb id
  -t, [--tvdb=TVDB]                # Search by TVDB id
  -m, [--themoviedb=THEMOVIEDB]    # Search by The Movie DB id
  -c, [--category=CATEGORY]        # Filter results by category
                                   # Possible values: movies, tv, music, games, software, xxx
  -l, [--limit=N]                  # Limit results number
                                   # Default: 25
                                   # Possible values: 25, 50, 100
      [--min-seeders=N]            # Filter results by minimum seeders
      [--min-leechers=N]           # Filter results by minimum leechers
      [--ranked], [--no-ranked]    # Include/exclude unranked torrents
                                   # Default: true
      [--sort=SORT]                # Sort results
                                   # Default: seeders
                                   # Possible values: last, seeders, leechers
  -v, [--verbose], [--no-verbose]  # Verbose output

Description:
  You will need to provide at least one of the search options: string, imdb, tvdb, themoviedb
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/caiohsramos/tsearch. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/caiohsramos/tsearch/blob/master/CODE_OF_CONDUCT.md).


## Code of Conduct

Everyone interacting in the Tsearch project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/tsearch/blob/master/CODE_OF_CONDUCT.md).

## Copyright

Copyright (c) 2021 Caio Ramos. See [MIT License](LICENSE.txt) for further details.