# frozen_string_literal: true

require_relative '../command'
require 'rarbg'
require 'active_support'
require 'active_support/core_ext/hash'
require 'byebug'

module Tsearch
  module Commands
    class Search < Tsearch::Command
      CATEGORY_MAP = {
        'movies': [14, 48, 17, 44, 45, 47, 50, 51, 52, 42, 46],
        'tv': [18, 41, 49],
        'music': [23, 25],
        'games': [27, 28, 40, 53, 32],
        'software': [33],
        'xxx': [4]
      }.freeze

      def initialize(options)
        @options = options
      end

      def execute(_input: $stdin, output: $stdout)
        results = search_torrent.map(&:deep_symbolize_keys)
        if results.empty?
          output.puts 'No results were found, please try again'
          return
        end

        display_results(results.reverse, output)
      end

      private

      def rarbg
        @rarbg ||= RARBG::API.new
      end

      def search_torrent
        query = {
          string: string,
          imdb: imdb,
          tvdb: tvdb,
          category: CATEGORY_MAP[category],
          limit: limit,
          format: :json_extended,
          min_seeders: min_seeders,
          min_leechers: min_leechers,
          ranked: ranked,
          sort: sort
        }.compact
        rarbg.search(query)
      end

      def format_link(url, name = 'Link')
        "\e]8;;#{url}\a#{name}\e]8;;\a (CTRL+Click)"
      end

      def filesize(size)
        units = ['B', 'KB', 'MB', 'GB', 'TB', 'Pb', 'EB']

        return '0.0 B' if size == 0

        exp = (Math.log(size) / Math.log(1024)).to_i
        exp += 1 if size.to_f / 1024**exp >= 1024 - 0.05
        exp = 6 if exp > 6

        '%.1f %s' % [size.to_f / 1024**exp, units[exp]]
      end

      def display_results(results, output)
        results.each do |result|
          output.puts "Name: #{result[:title]}"
          output.puts "Category: #{result[:category]}"
          output.puts "Magnet: #{format_link(result[:download])}"
          unless verbose
            output.puts
            next
          end

          output.puts "Seeders: #{result[:seeders]}"
          output.puts "Leechers: #{result[:leechers]}"
          output.puts "Filesize: #{filesize(result[:size])}"
          output.puts "Ranked: #{result[:ranked] == 1 ? 'Yes' : 'No'}"
          output.puts "Info page: #{format_link(result[:info_page])}"
          output.puts
        end
      end

      def method_missing(key, *args, &block)
        super unless %i[string
                        imdb
                        tvdb
                        themoviedb
                        category
                        limit
                        min_seeders
                        min_leechers
                        ranked
                        sort
                        verbose].include?(key)

        @options[key]
      end
    end
  end
end
