class Bibliographer::Book < Bibliographer::Base
  def to_s
    "#{names}, |#{title}| (#{pub_place}: #{publisher}, #{year})"
  end
end
