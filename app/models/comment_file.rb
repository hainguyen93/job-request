class CommentFile < ActiveRecord::Base
  belongs_to :comment
  
  has_attached_file :upload, styles: { thumbnail: "60x60#" }                              
  validates_attachment :upload, content_type: { content_type: ["application/pdf", "application/zip", "image/jpeg", "image/png", "application/msword",
                                                                 "application/vnd.openxmlformats-officedocument.wordprocessingml.document",
                                                                 "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
                                                                 "application/vnd.openxmlformats-officedocument.presentationml.presentation",
                                                                 "application/postscript","application/x-compress","application/x-compressed",
                                                                 "application/x-gzip","application/x-gtar","text/plain" ] } 
  before_post_process :skip_for_zip
 
  private 

    def skip_for_zip
      !%w(application/zip application/x-zip application/vnd.openxmlformats-officedocument.wordprocessingml.document).include?(upload_content_type)
    end
end
