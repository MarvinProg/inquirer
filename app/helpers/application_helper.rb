module ApplicationHelper
  def user_avatar(user)
    if user.avatar_url.present? && (user.avatar_url.include?("https://") || user.avatar_url.include?("http://"))
      user.avatar_url
    else
      asset_path 'avatar.jpg'
    end
  end

  def fa_icon(icon_class)
    content_tag 'span', '', class: "fa fa-#{icon_class}"
  end

  def sklonenie(count, word1, word2, word3)
    if (count % 10).between?(5,9) || count % 10 == 0 || (count % 100).between?(11,14)
      word1
    elsif (count % 10).between?(2,4)
      word2
    else
      word3
    end
  end

  def url_hashtag(text)
    text.gsub(Hashtag::REGEXP_HASHTAG) { |hashtag| link_to( hashtag, hashtag_path(hashtag.delete('#')), class:'hashtag')}.html_safe
  end
end
