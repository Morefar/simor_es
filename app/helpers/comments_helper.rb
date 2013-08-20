module CommentsHelper
  def localize_time_ago_in_words(date)
    case I18n.locale
    when :en
      return "#{time_ago_in_words(date)} ago"
    when :es
      return "Hace #{time_ago_in_words(date)}"
    end
  end
end
