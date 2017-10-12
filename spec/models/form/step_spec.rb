# frozen_string_literal: true

require 'rails_helper'

describe Form::Step do
  let!(:direction) { create :direction }
  let!(:step) { create :step, direction_id: direction.id }

  describe '#submit' do
    context 'with valid attributes' do
      let!(:form) { ::Form::Step.new(direction.steps.build, step.attributes) }

      it 'create new step' do
        expect do
          form.submit
        end.to change(Step, :count).by(1)
      end
    end

    context 'with invalid attributes' do
      let!(:form) { ::Form::Step.new(direction.steps.build, {}) }

      it 'doesn\'t create a new direction' do
        expect do
          form.submit
        end.to change(Step, :count).by(0)
      end

      context 'errors' do
        before { form.submit }

        %w[title description].each do |attr|
          it "errors array contains #{attr}" do
            expect(form.errors.messages).to have_key(attr.to_sym)
          end
        end
      end
    end
  end
end
