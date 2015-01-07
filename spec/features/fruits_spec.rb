require 'rails_helper'

feature 'Fruit pages' do

  let!(:apple) { create :fruit, name: 'Apple' }
  given!(:banana) { create :fruit, name: 'Banana' }
  given!(:orange) { create :fruit, name: 'Orange' }

  before { visit root_path }

  scenario 'Sort by drag-and-drop', js: true do
    expect(page).to have_content 'Fruits'
    expect(page).to have_content 'Apple'
    expect(page).to have_content 'Banana'
    expect(page).to have_content 'Orange'
#     p page.html

    source = page.find("#fruit-#{apple.id}")
    target = page.find("#fruit-#{orange.id}")

    expect{
      source.drag_to(target)
      sleep 0.3
    }.to change{
      Fruit.rank(:row_order).to_a
    }.from([apple, banana, orange]).to([banana, orange, apple])

  end
end
