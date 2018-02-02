module ClientSeederHelper
  def stub_rows(instance, number_of_rows = 1, overrides = {}) # rubocop:disable Metrics/MethodLength
    rows = []
    number_of_rows.times do
      rows << {
        'First Name' => FFaker::Name.first_name,
        'Surname' => FFaker::Name.last_name,
        'Advisor' => Fabricate(:advisor).id,
        'Contact Number' => '07912334567',
        'Email Address' => FFaker::Internet.email,
        'Address line 1' => FFaker::AddressUK.street_address,
        'Address line 2' => FFaker::AddressUK.neighborhood,
        'Postcode' => 'SW1A 1AA',
        'Current Status (RAGG)' => 'amber',
        'Gender' => 'f',
        'Receiving benefits?' => 'jsa',
        'Currently studying?' => 'no',
        'Currently employed?' => 'yes',
        'Any health conditions?' => 'no',
        'Affected by welfare reform?' => 'yes',
        'Date of Registration' => '2016-04-10',
        'Job Goal 1' => FFaker::HipsterIpsum.phrase,
        'Job Goal 2' => FFaker::HipsterIpsum.phrase,
        'Notes' => FFaker::HipsterIpsum.phrase
      }.merge(overrides)
    end
    instance.instance_variable_set(:@csv_data, rows)
    rows
  end
end
