require_relative 'strings'

class Article
  attr_reader :header, :description

  def initialize(hash, mark_up_article)
    mark_up_header = mark_up_article.css(hash[:article_header_tag])
    @header = mark_up_header.inner_html.strip.uni_flat
    if hash[:article_desc_class]
      mark_up_description = mark_up_article.css('.' + hash[:article_desc_class])
    elsif hash[:article_desc_tag]
      mark_up_description = mark_up_article.css(hash[:article_desc_tag])
    end
    @description = mark_up_description.inner_html.strip.uni_flat
  end
end
