# frozen_string_literal: true

require 'thor'

module Tsearch
  # Handle the application command line parsing
  # and the dispatch to various command objects
  #
  # @api public
  class CLI < Thor
    # Error raised by this runner
    Error = Class.new(StandardError)

    def self.exit_on_failure?
      true
    end

    desc 'version', 'tsearch version'
    def version
      require_relative 'version'
      puts "v#{Tsearch::VERSION}"
    end
    map %w[--version -V] => :version

    desc 'search', 'searches a torrent with the given options'
    long_desc <<-DESC
     You will need to provide at least one of the search options: string, imdb, tvdb, themoviedb
    DESC
    method_option :help, aliases: '-h', type: :boolean,
                         desc: 'Display usage information'
    method_option :string, type: :string, desc: 'Search by string', aliases: '-s'
    method_option :imdb, type: :string, desc: 'Search by IMDb id', aliases: '-i'
    method_option :tvdb, type: :string, desc: 'Search by TVDB id', aliases: '-t'
    method_option :themoviedb, type: :string, desc: 'Search by The Movie DB id', aliases: '-m'
    method_option :category, type: :string, desc: 'Filter results by category',
                             enum: %w[movies tv music games software xxx], aliases: '-c'
    method_option :limit, type: :numeric, desc: 'Limit results number', enum: [25, 50, 100], default: 25,
                          aliases: '-l'
    method_option :min_seeders, type: :numeric, desc: 'Filter results by minimum seeders'
    method_option :min_leechers, type: :numeric, desc: 'Filter results by minimum leechers'
    method_option :ranked, type: :boolean, desc: 'Include/exclude unranked torrents', default: true
    method_option :sort, type: :string, desc: 'Sort results', enum: %w[last seeders leechers],
                         default: 'seeders'
    method_option :verbose, type: :boolean, desc: 'Verbose output', aliases: '-v'
    def search
      if options[:help]
        invoke :help, ['search']
      else
        if options[:string].nil? && options[:imdb].nil? && options[:tvdb].nil? && options[:themoviedb].nil?
          raise RequiredArgumentMissingError,
                'At least one of the search options must be provided: string, imdb, tvdb, themoviedb'
        end

        require_relative 'commands/search'
        Tsearch::Commands::Search.new(options).execute
      end
    end
  end
end
