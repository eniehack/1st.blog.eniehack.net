require "erb"
require "time"
require "fileutils"

module BlogEniehackNet
  class Article
    def initialize(erb_file)
      @file = ERB.new(File.read(erb_file))
      @file.filename = erb_file
      @time = Time.now
      @pwd = FileUtils.pwd
    end

    def create(file_name)
      dir_path = "#{@pwd}/content/articles/#{@time.strftime '%Y/%m/%d'}"
      FileUtils.mkpath dir_path
      File.open("#{dir_path}/#{file_name}.adoc", "w", 0644) do |file|
        file.print @file.result
      end
    end
  end
end

article = BlogEniehackNet::Article.new "article.erb"
article.create(ARGF.argv[0])
