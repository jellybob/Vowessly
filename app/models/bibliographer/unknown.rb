class Bibliographer::Unknown < Bibliographer::Base
  def to_s
    "<span style='color: red'>ARGH - UNKNOWN TYPE #{first_fact("Type")} for #{page.name}</span>"
  end
end
