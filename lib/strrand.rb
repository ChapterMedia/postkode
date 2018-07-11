#
# = strrand.rb: Generates a random string from a pattern
#
# Author:: tama <repeatedly@gmail.com>
#
# (Stripped down to only relevant methods)
class StringRandom
  Upper  = Array('A'..'Z')
  Lower  = Array('a'..'z')
  Digit  = Array('0'..'9')
  Punct  = [33..47, 58..64, 91..96, 123..126].map { |r| r.map { |val| val.chr } }.flatten
  Any    = Upper | Lower | Digit | Punct
  Salt   = Upper | Lower | Digit | ['.', '/']
  Binary = (0..255).map { |val| val.chr }

  # These are the regex-based patterns.
  Pattern = {
    # These are the regex-equivalents.
    '.'  => Any,
    '\d' => Digit,
    '\D' => Upper | Lower | Punct,
    '\w' => Upper | Lower | Digit | ['_'],
    '\W' => Punct.reject { |val| val == '_' },
    '\s' => [' ', "\t"],
    '\S' => Upper | Lower | Digit | Punct,

    # These are translated to their double quoted equivalents.
    '\t' => ["\t"],
    '\n' => ["\n"],
    '\r' => ["\r"],
    '\f' => ["\f"],
    '\a' => ["\a"],
    '\e' => ["\e"]
  }
  # These are the old patterns for random_pattern.
  OldPattern = {
    'C' => Upper,
    'c' => Lower,
    'n' => Digit,
    '!' => Punct,
    '.' => Any,
    's' => Salt,
    'b' => Binary
  }

  #
  # Singleton method version of random_regex.
  #
  def self.random_regex(patterns)
    StringRandom.new.random_regex(patterns)
  end


  #
  # _max_ is default length for creating random string
  #
  def initialize(max = 10)
    @max   = max
    @map   = OldPattern.clone
    @regch = {
      '['  => method(:regch_bracket),
    }
  end

  private

  def _random_regex(pattern)
    string = []
    chars  = pattern.split(//)
    non_ch = /[\$\^\*\(\)\+\{\}\]\?]/  # not supported chars

    while ch = chars.shift
      if @regch.has_key?(ch)
        @regch[ch].call(ch, chars, string)
      else
        warn "'#{ch}' not implemented. treating literally." if ch =~ non_ch
        string << [ch]
      end
    end

    result = ''
    string.each do |ch|
      result << ch[rand(ch.size)]
    end
    result
  end

  def regch_bracket(ch, chars, string)
    tmp = []

    while ch = chars.shift and ch != ']'
      if ch == '-' and !chars.empty? and !tmp.empty?
        max  = chars.shift
        min  = tmp.last
        tmp << min = min.succ while min < max
      else
        warn "${ch}' will be treated literally inside []" if ch =~ /\W/
        tmp << ch
      end
    end
    raise 'unmatched []' if ch != ']'

    string << tmp
  end
end
