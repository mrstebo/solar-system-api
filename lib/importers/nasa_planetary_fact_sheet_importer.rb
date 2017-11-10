module Importers
  class NasaPlanetaryFactSheetImporter
    HEADER_PATTERN = /\<a href=".+fact\.html">(\w+)\<\/a\>/
    FACT_PATTERN = /\<a href="planetfact_notes\.html#\w+">(.+)\<\/a\>/
    DATA_ROW_PATTERN = /\<td align=center bgcolor=[0-9A-F]{6}\>(.+)\<\/td\>/

    def initialize
      @conn = Faraday.new('https://nssdc.gsfc.nasa.gov/planetary/factsheet/', ssl: { verify: false })
    end

    def planets
      planet_names.each_with_index.map do |name, i|
        Planet.new(
          name: name,
          mass: data_rows[0][i],
          diameter: data_rows[1][i],
          density: data_rows[2][i],
          gravity: data_rows[3][i],
          rotation_period: data_rows[5][i],
          length_of_day: data_rows[6][i],
          distance_from_sun: data_rows[7][i],
          orbital_period: data_rows[10][i],
          orbital_velocity: data_rows[11][i],
          mean_temperature: data_rows[15][i],
          number_of_moons: data_rows[17][i]
        )
      end
    end

    private

    def planet_names
      @planets ||= content.scan(HEADER_PATTERN).map {|m| m.first.capitalize}.uniq
    end

    def facts
      @facts ||= content.scan(FACT_PATTERN).map {|m| m.first}
    end

    def data_rows
      @data_rows ||= content.scan(DATA_ROW_PATTERN)
      .flatten
      .reject {|m| m.include?('<b>')}
      .each_slice(planet_names.size)
      .to_a
    end

    def content
      @content ||= @conn.get.body
    end
  end
end
