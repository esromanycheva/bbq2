require "rails_helper"

RSpec.describe EventPolicy, type: :policy do
  let(:user_is_an_owner) { User.new }
  let(:user_is_not_an_owner) { User.new }
  let(:event) { user_is_an_owner.events.build }

  subject { EventPolicy }

  context "when user authorized" do
    permissions :edit?, :destroy?, :update? do
      context "and is the owner of event" do
        it "gets permission" do
          is_expected.to permit(user_is_an_owner, event)
        end
      end

      context "and is not the owner of event" do
        it "does not get permission" do
          is_expected.not_to permit(user_is_not_an_owner, event)
        end
      end
    end

    permissions :show? do
      it "gets permission" do
        is_expected.to permit(nil, event)
      end
    end
  end

  context "when user authotized" do
    permissions :edit?, :destroy?, :update? do
      it "does not gets permission" do
        is_expected.not_to permit(nil, event)
      end
    end
  end
end