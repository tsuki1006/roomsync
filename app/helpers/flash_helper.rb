module FlashHelper
  def flash_icon(key)
    case key
    when 'notice' then 'i'
    when 'alert' then '!'
    when 'error' then '✕'
    end
  end
end
