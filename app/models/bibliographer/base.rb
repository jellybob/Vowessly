class Bibliographer::Base
  attr_reader :page

  def initialize(page)
    @page = page
  end

  def names(label = "Author")
    name_facts = page.facts.where(:label => label)
    first_name = name_facts.shift
    return "<span style='color: red'>NO NAMES!!!</span>" if first_name.nil?

    name_parts = first_name.value.split(" ")
    surname = name_parts.pop
    forenames = name_parts.join(" ")

    names = [ "#{surname}, #{forenames}" ]
    name_facts.each do |name_fact|
      names << name_fact.value
    end

    unless names.size == 1
      names[names.size - 1] = "and #{names.last}"
    end
    names.join(", ")
  end

  def editor_names
    name_facts = page.facts.where(:label => "Editor").all
    return "<span style='color: red'>NO EDITORS!!!</span>" if name_facts.size == 0

    names = name_facts.collect(&:value)

    unless names.size == 1
      names[names.size - 1] = "and #{names.last}"
    end
    names.join(", ")
  end

  def title
    capitalize_title(first_fact("Title"))
  end

  def pub_place
    first_fact("Publication place")
  end

  def publisher
    first_fact("Publisher")
  end

  def year
    first_fact("Year")
  end

  def first_fact(name, missing_allowed = false)
    fact = page.facts.where(:label => name).first
    if fact
      fact.value
    else
      missing_allowed ? nil : "<span style='color: red'>NO #{name.upcase.pluralize}!!!</span>"
    end
  end

  def capitalize_title(title)
    title
  end
end
