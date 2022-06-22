class Calendar < ApplicationRecord
  enum sleeping_time: { "1_29m": 0, "30m_59m": 1, "1h_1h59m": 2, "2h_over": 3 }

  belongs_to :user
end
