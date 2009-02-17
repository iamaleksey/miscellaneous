%w{uri net/http rexml/document}.each { |x| require x }

module RuTube
  class Video
    def initialize(hash)
      @hash = hash
    end

    def id
      @hash['id'].to_i
    end

    def status
      @hash['status'].to_i
    end

    def title
      @hash['title'].strip
    end

    def description
      @hash['description'].strip
    end

    def author
      @hash['author']
    end

    def size
      multipliers = {'Kb' => 1024, 'Mb' => 1048576, 'Gb' =>  1073741824}
      multiplier = @hash['size'].match(/Kb|Mb|Gb/)[0]
      (@hash['size'].to_f * multipliers[multiplier]).to_i
    end

    def duration
      dur = 0
      @hash['duration'].
        split(':').
        map { |s| s.to_i }.
        reverse.
        each_with_index { |s, i| dur += s * (60 ** i) }
      dur
    end

    def recorded_at
      Time.at(@hash['recordDateUnix'].to_i)
    end

    def hits_count
      @hash['hits'].to_i
    end

    def rating
      @hash['rating'].to_f
    end
    
    def votes_count
      @hash['votes'].to_i
    end
    
    def comments_count
      @hash['numberOfComments'].to_i
    end

    def category_name
      @hash['categoryName']
    end

    def category_link
      @hash['categoryLink']
    end

    def movie_link
      @hash['movieLink']
    end

    def player_link
      @hash['playerLink']
    end

    def player_code
      @hash['playerCodeToShare'].strip
    end

    def small_thumbnail_link
      @hash['thumbnailSmallLink']
    end

    def medium_thumbnail_link
      @hash['thumbnailMediumLink']
    end

    def large_thumbnail_link
      @hash['thumbnailLink']
    end

    def tags
      @hash['tags'].split(',')
    end

    def self.find(id)
      xml = xml_for(id)
      if xml.elements['//response'].attributes['status'] == 'error'
        case xml.elements['//error/code'].text
        when '2'
          raise VideoNotFound, 'Запрошенный Вами ролик не существует'
        when '3'
          raise VideoRemoved, 'Запрошенный Вами ролик был удален'
        end
      end
      from_xml(xml)
    end

    def self.from_xml(xml)
      id = xml.elements['//movie'].attributes['id']
      attrs = xml.elements['//movie'].elements.to_a.
        inject({}) { |h, el| h[el.name] = el.text; h }
      Video.new(attrs.merge('id' => id))
    end

    private

    def self.xml_for(id)
      url = URI.parse("http://rutube.ru/cgi-bin/xmlapi.cgi?rt_movie_id=#{id}&rt_mode=movie")
      response = Net::HTTP.get_response(url)
      REXML::Document.new(response.body)
    end
  end # Video

  class VideoNotFound < StandardError ;; end
  class VideoRemoved  < StandardError ;; end
end # RuTube