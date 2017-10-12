# frozen_string_literal: true

require 'rails_helper'

describe Form::Direction do
  let!(:direction) { create :direction }

  describe 'submit' do
    context 'with valid attributes' do
      let!(:form) { ::Form::Direction.new(Direction.new, direction.attributes) }

      it 'create new direction' do
        expect do
          form.submit
        end.to change(Direction, :count).by(1)
      end
    end

    context 'with invalid attributes' do
      let!(:form) { ::Form::Direction.new(Direction.new, {}) }

      it 'doesn\'t create a new direction' do
        expect do
          form.submit
        end.to change(Direction, :count).by(0)
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
