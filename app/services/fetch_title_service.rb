class FetchTitleService
  def initialize(url)
    @url = url
  end

  def call
    begin
      doc = Nokogiri::HTML(URI.open(@url))
      title = doc.at_css('title').text
    rescue
      title = ""
    end
    title = title.present? ? title[0,25] : "New review"
    title
  end
end