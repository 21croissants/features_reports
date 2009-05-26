
module FeaturesReport
  class Reader
    attr_reader :files

    def initialize(files)
      @files = files
    end

    def self.load_cucumber
      gem "cucumber", "=0.1.14"
      require "cucumber"
      require "cucumber/treetop_parser/feature_en"
      Cucumber.load_language("en")
  
      Cucumber::Tree::Feature.class_eval do
        attr_reader :scenarios
      end
    end
    
    def features
      return @features if @features
      @features = files.map do |file|
        parser.parse_feature(file)
      end
    end

    def parser
      @parser ||= Cucumber::TreetopParser::FeatureParser.new
    end
  end
end
