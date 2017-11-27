class HackneyWardFinder
  def initialize(postcode)
    @postcode = postcode
  end

  def lookup
    find_hackney_ward_from_postcode
  end

  private

  def find_hackney_ward_from_postcode
    # This validation is captured at the active_record level
    return if @postcode.blank? || GoingPostal.postcode?(@postcode, 'GB').blank?
    response = HTTParty.get("https://mapit.mysociety.org/postcode/#{@postcode.gsub(/\s+/, '')}", headers: { 'ContentType' => 'application/json' }).parsed_response
    borough_from(response) && ward_from(response)
  end

  def borough_from(response)
    response['areas'].select { |area| response['areas'][area]['type'] == 'LBO' && response['areas'][area]['id'] == 2508 } if response['areas']
  end

  def ward_from(response)
    response['areas'].select { |area| response['areas'][area]['type'] == 'LBW' }.keys[0]
  end
end
