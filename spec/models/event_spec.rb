require 'rails_helper'

RSpec.describe Event, type: :model do
  describe 'validations' do
    it 'is valid with valid attributes' do
      event = Event.new(
        name: 'Evento de Teste',
        description: 'Descrição do evento',
        started_at: Time.current,
        finished_at: Time.current + 2.hours
      )
      expect(event).to be_valid
    end

    it 'is invalid without a name' do
      event = Event.new(description: 'Descrição', started_at: Time.current, finished_at: Time.current + 1.hour)
      expect(event).not_to be_valid
      expect(event.errors[:name]).to include("can't be blank")
    end

    it 'is invalid without a description' do
      event = Event.new(name: 'Evento', started_at: Time.current, finished_at: Time.current + 1.hour)
      expect(event).not_to be_valid
      expect(event.errors[:description]).to include("can't be blank")
    end

    it 'is invalid without a started_at' do
      event = Event.new(name: 'Evento', description: 'Descrição', finished_at: Time.current + 1.hour)
      expect(event).not_to be_valid
      expect(event.errors[:started_at]).to include("can't be blank")
    end

    it 'is invalid without a finished_at' do
      event = Event.new(name: 'Evento', description: 'Descrição', started_at: Time.current)
      expect(event).not_to be_valid
      expect(event.errors[:finished_at]).to include("can't be blank")
    end

    it 'is invalid if finished_at is before started_at' do
      event = Event.new(
        name: 'Evento Inválido',
        description: 'Erro de tempo',
        started_at: Time.current,
        finished_at: Time.current - 1.hour
      )
      expect(event).not_to be_valid
      expect(event.errors[:finished_at]).to include('deve ser depois da data de início')
    end

    # Verifica se started_at no passado é inválido, no futuro é válido e nulo é válido
    context 'when started_at is in the past' do
      it 'is not valid' do
        event = Event.new(started_at: 1.hour.ago)

        expect(event).not_to be_valid
        expect(event.errors[:started_at]).to include("deve ser no futuro")
      end
    end

    context 'when started_at is in the future' do
      it 'is valid' do
        event = Event.new(started_at: 1.hour.from_now)

        expect(event).to be_valid
      end
    end

    context 'when started_at is not present' do
      it 'is valid' do
        event = Event.new(started_at: nil)

        expect(event).to be_valid
      end
    end
  end
end
