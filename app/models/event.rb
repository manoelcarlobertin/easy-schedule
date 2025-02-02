class Event < ApplicationRecord
  # o campo pode name allow_blank (vazio ou nil) sem que a validação seja aplicada aqui.
  validates :name, presence: true, length: { minimun: 2, maximum: 200, allow_blank: true }
  validates :description, presence: true
  validates :started_at, presence: true, allow_blank: true
  validates :finished_at, presence: true
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
end
