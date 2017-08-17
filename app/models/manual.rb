class Manual < ApplicationRecord
  MODES = ["Plane", "Train", "Helicopter"]

  strip_attributes :only => [:carrier, :make, :model, :revision]

  has_permalink :slug

  has_attached_file :photo,
    path: '/:folder/:permalink',
    styles: { large: "1600x", medium: "800x", small: "400x" }

  Paperclip.interpolates :folder do |attachment, style|
    attachment.instance.folder
  end

  Paperclip.interpolates :permalink do |attachment, style|
    attachment.instance.permalink + "-#{style}" + File.extname(attachment.original_filename).downcase
  end

  validates_attachment_content_type :photo, content_type: /\Aimage\/.*\Z/

  validates :mode, :carrier, :make, :model, presence: true

  scope :by_mode, lambda { |mode| where("mode =  ?", mode) }
  scope :by_make, lambda { |make| where("make = ?", make) }
  scope :by_carrier, lambda { |carrier| where("carrier = ?", carrier) }

  def title
    "#{carrier} #{make} #{model}"
  end

  def slug
    "#{carrier}-#{make}-#{model}-#{revision}"
  end

  def folder
    Rails.env == "development" ? "testing" : "manuals"
  end
end
