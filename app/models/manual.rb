class Manual < ApplicationRecord
  has_attached_file :photo, path: '/:class/:manual_file_name'
  validates_attachment_content_type :photo, :content_type => /\Aimage\/.*\Z/

  Paperclip.interpolates :manual_file_name do |attachment, style|
    attachment.instance.manual_file_name + File.extname(attachment.original_filename)
  end

  def manual_file_name
    "#{company.downcase}-#{make.downcase}-#{model.downcase}"
  end

end
