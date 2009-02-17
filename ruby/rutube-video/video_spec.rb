require 'video'

describe RuTube::Video do
  describe 'Existing video' do

    before :all do
      Net::HTTP.stub!(:get_response).and_return(mock('response', :body => File.open('xml/2.xml')))
      @video = RuTube::Video.find(2)
    end
    
    it 'has correct id' do
      @video.id.should == 2
    end

    it 'has correct status' do
      @video.status.should == 0
    end

    it 'has correct title' do
      @video.title.should == 'Бумер2 - Трейлер к фильму'
    end

    it 'has correct description' do
      @video.description.should == 'Фильм не смотрела. Ничего сказать не могу. Надеюсь, что те, кто посмотрели, оставят здесь комментарии.'
    end

    it 'has correct author' do
      @video.author.should == 'GalinaK'
    end

    it 'has correct size' do
      @video.size.should == 3974103
    end

    it 'has correct duration' do
      @video.duration.should == 113
    end

    it 'has correct recoreded_at time' do
      @video.recorded_at.should == Time.at(1160912888)
    end

    it 'has correct hits count' do
      @video.hits_count.should == 1827
    end

    it 'has correct rating' do
      @video.rating.should == 0.899178065801713
    end

    it 'has correct votes count' do
      @video.votes_count.should == 5
    end

    it 'has correct comments count' do
      @video.comments_count.should == 1
    end

    it 'has correct category link' do
      @video.category_link.should == '?rt_category=5'
    end

    it 'has correct movie link' do
      @video.movie_link.should == '?rt_movie_id=2'
    end

    it 'has correct player_link' do
      @video.player_link.should == 'http://video.rutube.ru/37ebbd4d748997f5876055a868810e14'
    end

    it 'has correct player code' do
      @video.player_code.should == '<OBJECT width="470" height="353"><PARAM name="movie" value="http://video.rutube.ru/37ebbd4d748997f5876055a868810e14"></PARAM><PARAM name="wmode" value="window"></PARAM><PARAM name="allowFullScreen" value="true"></PARAM><EMBED src="http://video.rutube.ru/37ebbd4d748997f5876055a868810e14" type="application/x-shockwave-flash" wmode="window" width="470" height="353" allowFullScreen="true" ></EMBED></OBJECT>'
    end

    it 'has correct category name' do
      @video.category_name.should == 'Кино, ТВ, телешоу'
    end

    it 'has correct small thumbnail link' do
      @video.small_thumbnail_link.should == 'http://img.rutube.ru/thumbs/37/eb/37ebbd4d748997f5876055a868810e14-3.jpg'
    end

    it 'has correct medium thumbnail link' do
      @video.medium_thumbnail_link.should == 'http://img.rutube.ru/thumbs/37/eb/37ebbd4d748997f5876055a868810e14-2.jpg'
    end

    it 'has correct large thumbnail link' do
      @video.large_thumbnail_link.should == 'http://img.rutube.ru/thumbs/37/eb/37ebbd4d748997f5876055a868810e14-1.jpg'
    end

    it 'has correct tags' do
      @video.tags.should == ['трейлер к фильму', 'бумер2']
    end
    
  end

  describe '#find removed video' do
    it 'raises VideoNotFound' do
      Net::HTTP.stub!(:get_response).and_return(mock('response', :body => File.open('xml/1.xml')))
      lambda { RuTube::Video.find(1) }.should raise_error(RuTube::VideoRemoved)
    end
  end

  describe '#find non-existent video' do
    it 'raises VideoNotFound' do
      Net::HTTP.stub!(:get_response).and_return(mock('response', :body => File.open('xml/4815162342.xml')))
      lambda { RuTube::Video.find(4815162342) }.should raise_error(RuTube::VideoNotFound)
    end
  end

end