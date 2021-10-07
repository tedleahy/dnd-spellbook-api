require 'json'

file = File.read(File.join(Rails.root, 'db', 'spells.json'))
spells = JSON.parse(file)

spells.each { |spell| Spell.create(spell) }
