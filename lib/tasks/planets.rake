namespace :planets do
  desc "Imports planet data from third party sources"
  task import: :environment do
    Planet.transaction do
      Importers::NasaPlanetaryFactSheetImporter.new.planets.each do |planet|
        planet.save unless Planet.exists?(name: planet.name)
      end
    end
  end
end
