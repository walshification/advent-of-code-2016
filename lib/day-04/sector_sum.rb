class SectorSum
  attr_reader :codes

  def initialize(codes)
    @codes = codes
    @total = nil
  end

  def sum_codes
    @total ||= real_codes.inject(0) { |total, code| total += code.sector_id }
  end

  private

  def real_codes
    @codes.select { |code| code.real? }
  end
end
