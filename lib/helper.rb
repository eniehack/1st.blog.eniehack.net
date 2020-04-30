include Nanoc::Helpers::Blogging
include Nanoc::Helpers::HTMLEscape
include Nanoc::Helpers::LinkTo
include Nanoc::Helpers::Rendering
include Nanoc::Helpers::Breadcrumbs
include Nanoc::Helpers::Tagging

def tag_set(items = nil)
  require "set"
  items = @items if items.nil?
  tags = Set.new
  items.each do |item|
    next if item[:tags].nil?
    item[:tags].each do |tag|
      p "tag_set/item[:tags].each/tag tag:#{tag}"
      tags << tag
    end
  end
  p "tag_set/tags: #{tags}"
  return tags.to_a
end

def create_tag_pages
  tag_set(items).each do |tag|
    p "create_tag_pages/items: #{items}"
    @items.create(
      "= render('/tags.html.slim', :tag => '#{tag}')",
      { title: "Tags: #{tag}", tag: tag, is_hidden: true },
      "/tags/#{tag}",
    )
    p "create_tag_pages/tag: #{tag}, #{tag.inspect}"
  end
end
