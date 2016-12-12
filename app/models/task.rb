class Task < ApplicationRecord
  belongs_to :user

  FORMAT = AutoHtml::Pipeline.new(
      AutoHtml::HtmlEscape.new,
      AutoHtml::YouTube.new(width: '100%', height: 200),
      AutoHtml::GoogleMaps.new(width: '100%', height: 200),
      AutoHtml::Instagram.new(width: '100%', height: 200),
      AutoHtml::Vimeo.new(width: '100%', height: 200),
      AutoHtml::Image.new,
      AutoHtml::Markdown.new,
      AutoHtml::Link.new(target: '_blank', rel: 'nofollow'),
      AutoHtml::SimpleFormat.new
  )

  def content=(t)
    super(t)
    self[:content_html] = FORMAT.call(t)
  end
end
