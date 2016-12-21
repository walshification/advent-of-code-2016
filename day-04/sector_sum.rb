class SectorSum
  attr_reader :codes

  def initialize(codes)
    @codes = codes
  end

  def sum_codes
    total = 0
    @codes.each do |code|
      if code.real?
        total += code.sector_id
      end
    end
    total
  end
end
