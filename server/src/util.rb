# frozen_string_literal: true

class Util
  def self.now_iso_8601
    Time.now.strftime('%Y-%m-%dT%H:%M:%S.%L%z')
  end
end
