class Manual < ApplicationRecord
  has_permalink :slug

  has_attached_file :photo,
    path: '/:folder/:permalink',
    styles: { square: "500x500#" }

  validates_attachment_content_type :photo, content_type: /\Aimage\/.*\Z/

  Paperclip.interpolates :folder do |attachment, style|
    attachment.instance.folder
  end

  Paperclip.interpolates :permalink do |attachment, style|
    attachment.instance.permalink + "-#{style}" + File.extname(attachment.original_filename)
  end

  def slug
    "#{carrier}-#{make}-#{model}"
  end

  def folder
    Rails.env == "development" ? "testing" : "manuals"
  end
end
