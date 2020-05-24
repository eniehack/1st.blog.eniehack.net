# SPDX-License-Identifier: MPL-2.0
require "rugged"
require "time"

module BlogEniehackNet
  module Helpers
    module Git
      def find_file_updated(repo_dir, file)
        repo = Rugged::Repository.new repo_dir
        revisions = Array.new
        array = Array.new
        dates = {}

        Rugged::Walker.walk(repo,
          show: repo.head.target_id,
          sort: Rugged::SORT_DATE) do |e|

          begin
            path = e.tree.path file
          rescue Rugged::TreeError then
            next
          end

          revisions.push({oid: e.tree.path(file)[:oid], date: e.time})
        end

        previous_oid = ""
        revisions.reverse_each do |revision|
         next if previous_oid == revision[:oid]
         previous_oid = revision[:oid]
         array.push revision[:date]
        end

        if array.length == 1 then
          dates[:created_at] = array[0]
          dates[:updated_at] = array[0]
        else
          dates[:created_at] = array[0]
          dates[:updated_at] = array[1]
        end

        return dates
      end
    end
  end
end
