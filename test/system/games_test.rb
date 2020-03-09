require 'application_system_test_case'

class GamesTest < ApplicationSystemTestCase
  test 'Going to /new gives us a new random grid to play with' do
    visit new_url
    assert test: 'New game'
    assert_selector 'li', count: 10
  end

  test 'Filling the form with a random word returns a word-not-in-grid message' do
    visit new_url
    fill_in 'word', with: 'abc'
    click_on 'Play'

    assert_text "can't be built out of"
  end

  test 'Filling the form with a one-letter consonant returns not-a-valid-word message' do
    visit new_url
    fill_in 'word', with: 'k'
    click_on 'Play'

    assert_text 'does not seem to be a valid English word'
  end
end
