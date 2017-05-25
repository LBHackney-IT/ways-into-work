class HackneyPostcodeValidator

  def initialize(postcode)
    @postcode = postcode
  end

  def within_hackney?
    find_borough_from_postcode.present?
  end

  private

    def find_borough_from_postcode
      return if @postcode.blank?
      response = HTTParty.get("https://mapit.mysociety.org/postcode/#{@postcode.gsub(/\s+/, '')}", :headers => { 'ContentType' => 'application/json'}).parsed_response
      borough_from(response)
    end

    def borough_from(response)
      response["areas"].select{ |area| response["areas"][area]["type"] == 'LBO' && response["areas"][area]["id"] == 2508} if response["areas"]
    end

end


