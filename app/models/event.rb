class Event < ApplicationRecord
  # o campo pode name allow_blank (vazio ou nil) sem que a validação seja aplicada aqui.
  validates :name, presence: true, length: { minimun: 2, maximum: 200, allow_blank: true }
  validates :description, presence: true
  validates :started_at, presence: true
  validates :finished_at, presence: true
  # validate :validate_if_starts_in_future, on: :create
  validate :finished_after_started
  # repara que é no singular (validate) pra chamar o método;

  private

  # confere se os campos estão preenchidos e compara as datas
  def finished_after_started
    if finished_at.present? && started_at.present? && finished_at < started_at
    
    # debugger
    
      errors.add(:finished_at, "deve ser depois da data de início")
    end
  end

  # confere se a data de início está no futuro (validate) pra chamar o método;
  # def validate_if_starts_in_future
  #   if started_at.present? && started_at < Time.now
  #     errors.add(:started_at, "deve ser no futuro")
  #   end
  # end
end
