require 'rails_helper'

RSpec.describe 'Magazine Articles' do
  feature 'visit /:mount_point' do
    scenario do
      visit magazine_path
      # Category list
      expect(page).to have_content('ドリップ')
      expect(page).to have_content('コーヒー豆')

      # Article list
      expect(page).to have_selector('img[src="/images/magazine/cover_photo.jpg"]')
      expect(page).to have_content('All Articles')
      expect(page).to have_content('ウォータードリップ')
      expect(page).to have_content('ペーパードリップ')
      expect(page).to have_content('ネルドリップ')
      expect(page).to have_content('ブルーマウンテン')
      expect(page).to have_content('コナ')
      expect(page).to have_content('キリマンジャロ')
    end
  end

  feature 'visit /:mount_point/:category_slug' do
    context 'exist category' do
      scenario do
        visit magazine.category_index_path('drip')
        # Category list
        expect(page).to have_content('ドリップ')
        expect(page).to have_content('コーヒー豆')

        # Article list
        expect(page).to have_selector('img[src="/images/magazine/drip/cover_photo.jpg"]')
        expect(page).to have_content('ドリップ Articles')
        expect(page).to have_content('ウォータードリップ')
        expect(page).to have_content('ペーパードリップ')
        expect(page).to have_content('ネルドリップ')
        expect(page).to_not have_content('ブルーマウンテン')
        expect(page).to_not have_content('コナ')
        expect(page).to_not have_content('キリマンジャロ')
      end
    end

    context 'not exist category' do
      scenario do
        expect {
          visit magazine.category_index_path('foo')
        }.to raise_error(ActionController::RoutingError)
      end
    end
  end

  feature 'visit /:mount_point/:category_slug/:article_slug' do
    context 'exist article' do
      context 'not in review' do
        scenario do
          visit magazine.article_path('drip', 'water')
          expect(page).to have_content('ウォータードリップ')
          expect(page).to have_content('専用の機材を用い水でコーヒーを抽出する方法。')
          expect(page).to have_selector('img[src="/images/magazine/drip/water/thumbnail.jpg"]')
          expect(page).to have_content('water drip content')
        end
      end

      context 'in review' do
        context 'success authorize' do
          scenario do
            expect {
              visit magazine.article_path('beans', 'kilimanjaro')
            }.to_not raise_error
          end
        end

        context 'fail authorize' do
          before do
            class ::ApplicationController < ActionController::Base
              private
                def current_admin
                  false
                end
            end
          end

          after do
            class ::ApplicationController < ActionController::Base
              private
                def current_admin
                  true
                end
            end
          end

          scenario do
            expect {
              visit magazine.article_path('beans', 'kilimanjaro')
            }.to raise_error(ActionController::RoutingError)
          end
        end
      end
    end

    context 'not exist article' do
      scenario do
        expect {
          visit magazine.article_path('foo', 'water')
        }.to raise_error(ActionController::RoutingError)
      end
    end
  end
end
