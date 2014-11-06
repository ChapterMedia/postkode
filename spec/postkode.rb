# encoding: utf-8
require 'spec_helper'

describe Postkode do
  describe '.validate' do
    it 'validates a valid postcode' do
      expect(Postkode.validate('WC2E 7PX')).to be true
    end

    it 'rejects an invalid postcode' do
      expect(Postkode.validate('POSTIE CODE')).to be false
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
      expect(Postkode.find_in_string('The postcode is in here WC2E 7PX - somewhere')).to eq([['WC2E','7PX']])
    end
  end

  describe '.find_partial_in_string' do
    it 'gets a partial postcode from somewhere in a string' do
      expect(Postkode.find_partial_in_string('The postcode is in here WC2E - somewhere')).to eq([['WC2E']])
    end
  end

end
