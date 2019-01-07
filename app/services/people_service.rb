class PeopleService
  def save_or_update(id, phone)
    if Person.where(id: id).empty?
      person = Person.new(user_id: id, phone: phone)
      return true if person.save
    end
    return true if Person.where(id: id).first.update(phone: phone)
  end
end
