class PhoneNumber < ActiveRecord::Base
  belongs_to :user

  def generate_pin
    generated_pin = rand(0000..9999).to_s.rjust(4, "0")
    self.pin = generated_pin
    update(pin: generated_pin)
  end

  def send_pin
    SMS.new(phone_number).send("Your pin is #{pin}")
  end

  def verify(entered_pin)
    update(verified: true) if self.pin == entered_pin
  end
end
