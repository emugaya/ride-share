# model_shared_example.rb

RSpec.shared_examples 'an invalid model' do |model, model_object|
  it "validation of #{model} model fails when input is invalid" do
    expect(FactoryBot.build(model_object)).to be_invalid
  end
end

RSpec.shared_examples 'a valid model' do |model, model_object|
  it "validation of #{model} model succeeds when input is valid" do
    expect(FactoryBot.build(model_object)).to be_valid
  end
end

RSpec.shared_examples 'retrieving all model items' do |model, number_of_items|
  it 'returns all model items' do
    expect(model.all.length).to be(number_of_items)
  end
end

RSpec.shared_examples 'items belonging to object' do |model, related_child_model|
  it "returns #{related_child_model} belonging to #{model}" do
    model_item = model.first

    if related_child_model == 'users'
      expect(model_item.user).to eq(FactoryBot.build(:user))
    elsif related_child_model == 'rides'
      expect(model_item.rides.length).to be(1)
    elsif related_child_model == 'ride_matches'
      expect(model_item.ride_matches.length).to be(1)
    end
  end
end
