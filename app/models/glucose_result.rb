class GlucoseResult < ActiveRecord::Base
	validates :user_id, :date_time_stamp, :result, :device, presence: true
	validates :user_id, numericality: { only_integer: true }
	validates :date_time_stamp, timeliness: { type: :datetime }
	validates :result, numericality: { only_integer: true, greater_than: 0, less_than: 5000 }
	validates :device, inclusion: { in: ["VerioIQ (meter)", "Dexcom G4 (CGM)", "Unknown"] }
	validates :notes, length: { maximum: 255 }
end
