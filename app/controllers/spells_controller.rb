class SpellsController < ApplicationController
  def index
    spells = Spell.select(%i[id name level is_ritual casting_time range spell_lists])
    spells = spells_where(spells)

    spells = gareth_where(spells) if params[:garethSpells]

    render json: spells
  end

  def gareth_where(spells)
    spell_names = [
      'Fire Bolt',
      'Mending',
      'Minor Illusion',
      'Thaumaturgy',
      'Shape Water',
      'Burning Hands',
      'Detect Magic',
      'Expeditious Retreat',
      'Grease',
      'Unseen Servant',
      'Hellish Rebuke',
      "Aganazzar's Scorcher",
      'Darkness',
      'Enlarge/Reduce',
      'Hold Person',
      'Phantasmal Force',
      'Rope Trick',
      'Wristpocket',
      'Animate Dead',
      'Counterspell',
      'Dispel Magic',
      'Fireball',
      'Fly'
    ]

    spells.where(name: spell_names)
  end

  def show
    spell = Spell.find(params[:id])
    render json: spell
  end

  private

  def spells_where(spells)
    where = {}
    where[:level] = params[:levels] if params[:levels]

    unless params[:isRitual] && params[:isNotRitual]
      where[:is_ritual] = true  if params[:isRitual]
      where[:is_ritual] = false if params[:isNotRitual]
    end

    spells = spells.where(where)

    spells = where_cast_times(spells, params[:castTimes]) if params[:castTimes]

    spells = where_spell_lists(spells, params[:spellLists]) if params[:spellLists]

    spells
  end

  def where_cast_times(spells, cast_times)
    query =  'casting_time LIKE ?'
    query += ' OR casting_time LIKE ?' * (cast_times.length - 1)
    cast_time_params = cast_times.map { |x| "%#{x}%" }

    spells.where(query, *cast_time_params)
  end

  def where_spell_lists(spells, spell_lists)
    query =  'spell_lists LIKE ?'
    query += 'OR spell_lists LIKE ?' * (spell_lists.length - 1)
    spell_list_params = spell_lists.map { |x| "%#{x}%" }

    spells.where(query, *spell_list_params)
  end
end
