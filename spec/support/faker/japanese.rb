module Faker
  class Japanese < Base
    class << self
      def kanji
        # 一部の例としての漢字リスト
        %w[亜 哀 挨 愛 曖 悪 握 圧 扱 姉 役 約 薬 有 由 友 夜 野 唯 冬 雄 由].sample
      end

      def katakana
        %w[ア イ ウ エ オ カ キ ク ケ コ サ シ ス セ ソ タ チ ツ テ ト ナ ニ ヌ ネ ノ ハ ヒ フ ヘ ホ マ ミ ム メ モ ヤ ユ ヨ ラ リ ル レ ロ ワ ヲ ン].sample
      end

      def hiragana
        %w[あ い う え お か き く け こ さ し す せ そ た ち つ て と な に ぬ ね の は ひ ふ へ ほ ま み む め も や ゆ よ ら り る れ ろ わ を ん].sample
      end
    end
  end
end
