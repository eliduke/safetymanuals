class Manual < ApplicationRecord
  has_permalink :slug

  has_attached_file :photo,
    path: '/:class/:permalink',
    styles: { square: "500x500#" }

  validates_attachment_content_type :photo, content_type: /\Aimage\/.*\Z/

  Paperclip.interpolates :permalink do |attachment, style|
    attachment.instance.permalink + "-#{style}" + File.extname(attachment.original_filename)
  end

  def slug
    "#{carrier}-#{make}-#{model}"
  end
end
