class Manual < ApplicationRecord
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
  validates :carrier, :make, :model, presence: true

  def title
    "#{carrier} #{make} #{model}"
  end

  def slug
    "#{carrier}-#{make}-#{model}"
  end

  def folder
    Rails.env == "development" ? "testing" : "manuals"
  end
end
