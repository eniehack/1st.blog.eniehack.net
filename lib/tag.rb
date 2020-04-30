#module BlogEniehackNet
#  module Tags
#    def tag_set(items = nil)
#      require "set"
#      items = @items if items.nil?
#      tags = Set.new
#      items.each do |item|
#        next if item[:tags].nil?
#        p "item: #{item.inspect}"
#        item[:tags].each do |tag|
#          tags << tag
#        end
#        return tags.to_a
#      end
#    end
#  end
#end
#
#include BlogEniehackNet::Tags
