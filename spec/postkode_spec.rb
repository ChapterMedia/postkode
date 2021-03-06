require 'spec_helper'

describe Postkode do
  describe '.validate' do
    it 'validates valid postcodes' do
      expect(Postkode.validate('WC2E 7PX')).to be true     # AANA
      expect(Postkode.validate('SW1Y 4BN')).to be true     # AANA
      expect(Postkode.validate('NE9 6AA')).to be true      # AAN
      expect(Postkode.validate('N1C 4AX')).to be true      # ANA
      expect(Postkode.validate('BS40 5BL')).to be true     # AANN
      expect(Postkode.validate('E17 0DX')).to be true      # ANN
      expect(Postkode.validate('W4 1AP')).to be true       # AN

      # These have caused problems in the past
      expect(Postkode.validate('WC2N 4AA')).to be true     # AANA
      expect(Postkode.validate('EC1V 9LA')).to be true     # AANA
    end

    it 'rejects invalid postcodes' do
      expect(Postkode.validate('POSTIE CODE')).to be false
      expect(Postkode.validate('@ddg5GH')).to be false
    end

    it 'rejects a nil postcode' do
      expect(Postkode.validate(nil)).to be false
    end

    it 'rejects a blank postcode' do
      expect(Postkode.validate('')).to be false
    end
  end

  describe '.get_first_section' do
    it 'gets the first section of a valid postcode' do
      expect(Postkode.get_first_section('WC2E 7PX')).to eq('WC2E')
    end
  end

  describe '.validate_and_normalize' do
    it 'splits spaceless postcodes' do
      expect(Postkode.validate_and_normalize('WC2E7PX')).to eq('WC2E 7PX')
    end
    it 'uppercases lower or mixed case postcodes' do
       expect(Postkode.validate_and_normalize('wC2e7Px')).to eq('WC2E 7PX')
    end
    it 'returns nil if the postcode is invalid' do
      expect(Postkode.validate_and_normalize('@partyHaus!')).to eq(nil)
    end
  end

  describe '.get_outcode' do
    it 'gets the outcode of a valid postcode' do
      expect(Postkode.get_outcode('WC2E 7PX')).to eq('WC2E')
    end
  end

  describe '.get_inward' do
    it 'gets the second section of a valid postcode' do
      expect(Postkode.get_inward('WC2E 7PX')).to eq('7PX')
    end
  end

  describe '.find_in_string' do
    it 'gets a postcode from somewhere in a string' do
      haystack = 'The postcode is in here WC2E 7PX - somewhere'
      expect(Postkode.find_in_string(haystack)).to eq([['WC2E', '7PX']])
    end

    it 'gets a lower-case postcode from somewhere in a string' do
      haystack = 'The postcode is in here wc2e 7px - somewhere'
      expect(Postkode.find_in_string(haystack)).to eq([['WC2E', '7PX']])
    end
  end

  describe '.find_partial_in_string' do
    it 'gets a partial postcode from somewhere in a string' do
      haystack = 'The postcode is in here WC2E - somewhere'
      expect(Postkode.find_partial_in_string(haystack)).to eq([['WC2E']])
    end

    it 'gets a lower-case partial postcode from somewhere in a string' do
      haystack = 'The postcode is in here wc2e - somewhere'
      expect(Postkode.find_partial_in_string(haystack)).to eq([['WC2E']])
    end
  end

  describe '.random' do
    it 'generates 100 random postcodes that validate' do
      (0...100).each do
        random_postcode = Postkode.random
        expect(Postkode.validate(random_postcode)).to be true
      end
    end
  end
end
