# encoding: utf-8

# Handles validation of UK-style postcodes
class Postkode
  # Validating UK Postcodes
  # Correct as at 2014-09-15
  # References below
  # https://www.gov.uk/government/uploads/system/uploads/attachment_data/file/283357/ILRSpecification2013_14Appendix_C_Dec2012_v1.pdf
  # http://en.wikipedia.org/wiki/Postcodes_in_the_United_Kingdom#Validation
  # Areas with only single-digit districts: BR, FY, HA, HD, HG, HR, HS, HX, JE,
  #       LD, SM, SR, WC, WN, ZE (although WC is always subdivided by a
  #       further letter, e.g. WC1A).
  # Areas with only double-digit districts: AB, LL, SO.
  # Areas with a district '0' (zero): BL, BS, CM, CR, FY, HA, PR, SL, SS (BS is
  #       the only area to have both a district 0 and a district 10).
  # The following central London single-digit districts have been further
  #       divided by inserting a letter after the digit and before the space:
  #       EC1-EC4 (but not EC50), SW1, W1, WC1, WC2, and part of E1 (E1W),
  #       N1 (N1C and N1P), NW1 (NW1W) and SE1 (SE1P).
  # The letters QVX are not used in the first position.
  # The letters IJZ are not used in the second position.
  # The only letters to appear in the third position are ABCDEFGHJKPSTUW when
  #       the structure starts with A9A.
  # The only letters to appear in the fourth position are ABEHMNPRVWXY when
  #       the structure starts with AA9A.
  # The final two letters do not use the letters CIKMOV, so as not to resemble
  #       digits or each other when hand-written.
  # Post code sectors are one of ten digits: 0 to 9 with 0 only used once 9
  #       has been used in a post town, save for Croydon and Newport (above).

  A1    = '[A-PR-UWYZ]'
  A2    = '[A-HK-Y]'
  A3    = '[A-HJKPS-UW]'
  A4    = '[ABEHMNPRV-XY]'
  A5    = '[ABD-HJLN-UW-Z]'
  N     = '[0-9]'
  AANN  = A1 + A2 + N + N     # the six possible first-part combos
  AANA  = A1 + A2 + N + A4
  ANA   = A1 + N + A3
  ANN   = A1 + N + N
  AAN   = A1 + A2 + N
  AN    = A1 + N
  PART_ONE = [AANN, AANA, ANA, ANN, AAN, AN].join('|')
  PART_TWO = N + A5 + A5

  NORMAL_POSTCODE_VALID         = "^(#{PART_ONE})[ ]*(#{PART_TWO})$"
  NORMAL_POSTCODE_PATTERN       = /(#{PART_ONE})[ ]*(#{PART_TWO})/
  NORMAL_PART_POSTCODE_PATTERN  = /[ ]*(#{PART_ONE})[ ]*/
  NORMAL_POSTCODE_RE = Regexp.new(NORMAL_POSTCODE_VALID, Regexp::IGNORECASE)

  def self.validate(string, return_parts = false)
    return false if string.nil? || string == '' || string == false
    result = string.match(NORMAL_POSTCODE_RE)
    return false if result.nil?

    return_parts ? result[1..2] : true
  end

  def self.get_first_section(string)
    get_outcode(string)
  end

  def self.get_outcode(string)
    found = Postkode.validate(string, true)
    found ? found[0] : nil
  end

  def self.get_inward(string)
    found = Postkode.validate(string, true)
    found ? found[1] : nil
  end

  def self.find_in_string(string)
    res = string.scan(NORMAL_POSTCODE_PATTERN)
    res.length > 0 ? res : nil
  end

  def self.find_partial_in_string(string)
    res = string.scan(NORMAL_PART_POSTCODE_PATTERN)
    res.length > 0 ? res : nil
  end
  
  def self.validate_and_normalize(string)
    return nil unless validate(string)
    validate(string, true).
      map(&:to_s).
      map(&:upcase).
      join(" ")
  end
end
