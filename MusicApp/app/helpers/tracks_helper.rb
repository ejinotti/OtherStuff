module TracksHelper

  def ugly_lyrics(lyrics)
    h(lyrics.split("\n").map { |l| "♫" + l }.join).html_safe
  end

end
