module DocumentsHelper
  def document_thumbnail(document)
    if document.content_type.starts_with? "image"
      if document.content.version_exists?(:thumb)
        image = document.content_url(:thumb).to_s
      else
        image = document.content_url.to_s
      end
    else
      image = "pdf_placeholder.png"
    end
  end
end
