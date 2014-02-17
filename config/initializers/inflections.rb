# Be sure to restart your server when you modify this file.

# Add new inflection rules using the following format. Inflections
# are locale specific, and you may define rules for as many different
# locales as you wish. All of these examples are active by default:
# ActiveSupport::Inflector.inflections(:en) do |inflect|
#   inflect.plural /^(ox)$/i, '\1en'
#   inflect.singular /^(ox)en/i, '\1'
#   inflect.irregular 'person', 'people'
#   inflect.uncountable %w( fish sheep )
# end

# These inflection rules are supported but not enabled by default:
# ActiveSupport::Inflector.inflections(:en) do |inflect|
#   inflect.acronym 'RESTful'
# end
ActiveSupport::Inflector.inflections(:es) do |inflect|

  # inflect.plural /([^djlnrs])([A-Z]|_|$)/, '\1s\2'
  # inflect.plural /([djlnrs])([A-Z]|_|$)/, '\1es\2'
  # inflect.plural /(.*)z([A-Z]|_|$)$/i, '\1ces\2'

  # inflect.singular /([^djlnrs])s([A-Z]|_|$)/, '\1\2'
  # inflect.singular /([djlnrs])es([A-Z]|_|$)/, '\1\2'
  # inflect.singular /(.*)ces([A-Z]|_|$)$/i, '\1z\2'

  inflect.plural(/$/, 's')
  inflect.plural(/([^aeioué])$/, '\1es')
  inflect.plural(/([aeiou]s)$/, '\1')
  inflect.plural(/z$/, 'ces')
  inflect.plural(/á([sn])$/, 'a\1es')
  inflect.plural(/í([sn])$/, 'i\1es')
  inflect.plural(/ó([sn])$/, 'o\1es')
  inflect.plural(/ú([sn])$/, 'u\1es')
  inflect.singular(/s$/, '')
  inflect.singular(/es$/, '')
  inflect.irregular('papá', 'papás')
  inflect.irregular('mamá', 'mamás')
  inflect.irregular('sofá', 'sofás')
  inflect.irregular('orden de inspección', 'ordenes de inspección')
  inflect.irregular('mes', 'meses')
end
