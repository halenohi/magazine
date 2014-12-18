require 'rails_helper'

RSpec.describe Magazine::Rack do
  let!(:magazine_rack) do
    Magazine::Rack.new
  end

  describe '#initialize' do
    subject do
      magazine_rack.data.map(&:to_hash)
    end

    it 'should load config yml' do
      expect(subject).to eq(
        [{"category_slug"=>"drip",
          "category_name"=>"ドリップ",
          "extra"=>{"label_color"=>"orange"},
          "articles"=>
           [{"review"=>false,
             "slug"=>"water",
             "title"=>"ウォータードリップ",
             "extra"=>{"excerpt"=>"専用の機材を用い水でコーヒーを抽出する方法。"}},
            {"review"=>false,
             "slug"=>"paper",
             "title"=>"ペーパードリップ",
             "extra"=>{"excerpt"=>"日本で最も普及していると思われる淹れ方。"}},
            {"review"=>false,
             "slug"=>"nel",
             "title"=>"ネルドリップ",
             "extra"=>{"excerpt"=>"フィルタとして布（綿フランネル）を使用する抽出法。"}}]},
         {"category_slug"=>"beans",
          "category_name"=>"コーヒー豆",
          "extra"=>{"label_color"=>"green"},
          "articles"=>
           [{"review"=>true,
             "slug"=>"blue-mountain",
             "title"=>"ブルーマウンテン",
             "extra"=>{"excerpt"=>"卓越した香気を持ち、調和の取れた味わい、軽い口当りと滑らかな咽越しが特徴。"}},
            {"review"=>true,
             "slug"=>"kona",
             "title"=>"コナ",
             "extra"=>{"excerpt"=>"非常に強い酸味とコク・風味を持つ。"}},
            {"review"=>true,
             "slug"=>"kilimanjaro",
             "title"=>"キリマンジャロ",
             "extra"=>{"excerpt"=>"タンザニア産のコーヒーの日本での呼称。"}}]}]
      )
    end
  end

  describe '#find_category' do
    subject do
      magazine_rack.find_category(category_slug).try(:to_hash)
    end

    context 'when exist category' do
      let(:category_slug) do
        'drip'
      end

      it 'should return category' do
        expect(subject).to eq(
          {"category_slug"=>"drip",
           "category_name"=>"ドリップ",
           "extra"=>{"label_color"=>"orange"},
           "articles"=>
            [{"review"=>false,
              "slug"=>"water",
              "title"=>"ウォータードリップ",
              "extra"=>{"excerpt"=>"専用の機材を用い水でコーヒーを抽出する方法。"}},
             {"review"=>false,
              "slug"=>"paper",
              "title"=>"ペーパードリップ",
              "extra"=>{"excerpt"=>"日本で最も普及していると思われる淹れ方。"}},
             {"review"=>false,
              "slug"=>"nel",
              "title"=>"ネルドリップ",
              "extra"=>{"excerpt"=>"フィルタとして布（綿フランネル）を使用する抽出法。"}}]}
        )
      end
    end

    context 'when not exist category' do
      let(:category_slug) do
        'cup'
      end

      it 'should return nil' do
        expect(subject).to eq(nil)
      end
    end
  end

  describe '#find_article' do
    subject do
      magazine_rack.find_article('drip', article_slug).try(:to_hash)
    end

    context 'when exist article' do
      let(:article_slug) do
        'water'
      end

      it 'should return article' do
        expect(subject).to eq(
          {"review"=>false,
           "slug"=>"water",
           "title"=>"ウォータードリップ",
           "extra"=>{"excerpt"=>"専用の機材を用い水でコーヒーを抽出する方法。"}}
        )
      end
    end

    context 'when not exist article' do
      let(:article_slug) do
        'foo'
      end

      it 'should return nil' do
        expect(subject).to eq(nil)
      end
    end
  end

  describe '#all_articles_with_category' do
    it 'return assigned (article => category) hash' do
      expect(magazine_rack.all_articles_with_category.to_hash).to eq(
        {{"review"=>false,
          "slug"=>"water",
          "title"=>"ウォータードリップ",
          "extra"=>{"excerpt"=>"専用の機材を用い水でコーヒーを抽出する方法。"}}=>
          {"category_slug"=>"drip",
           "category_name"=>"ドリップ",
           "extra"=>{"label_color"=>"orange"}},
         {"review"=>false,
          "slug"=>"paper",
          "title"=>"ペーパードリップ",
          "extra"=>{"excerpt"=>"日本で最も普及していると思われる淹れ方。"}}=>
          {"category_slug"=>"drip",
           "category_name"=>"ドリップ",
           "extra"=>{"label_color"=>"orange"}},
         {"review"=>false,
          "slug"=>"nel",
          "title"=>"ネルドリップ",
          "extra"=>{"excerpt"=>"フィルタとして布（綿フランネル）を使用する抽出法。"}}=>
          {"category_slug"=>"drip",
           "category_name"=>"ドリップ",
           "extra"=>{"label_color"=>"orange"}},
         {"review"=>true,
          "slug"=>"blue-mountain",
          "title"=>"ブルーマウンテン",
          "extra"=>{"excerpt"=>"卓越した香気を持ち、調和の取れた味わい、軽い口当りと滑らかな咽越しが特徴。"}}=>
          {"category_slug"=>"beans",
           "category_name"=>"コーヒー豆",
           "extra"=>{"label_color"=>"green"}},
         {"review"=>true,
          "slug"=>"kona",
          "title"=>"コナ",
          "extra"=>{"excerpt"=>"非常に強い酸味とコク・風味を持つ。"}}=>
          {"category_slug"=>"beans",
           "category_name"=>"コーヒー豆",
           "extra"=>{"label_color"=>"green"}},
         {"review"=>true,
          "slug"=>"kilimanjaro",
          "title"=>"キリマンジャロ",
          "extra"=>{"excerpt"=>"タンザニア産のコーヒーの日本での呼称。"}}=>
          {"category_slug"=>"beans",
           "category_name"=>"コーヒー豆",
           "extra"=>{"label_color"=>"green"}}}
      )
    end
  end
end
