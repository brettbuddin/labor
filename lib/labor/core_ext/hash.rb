class Hash
  def symbolize_keys!
    keys.each do |key|
      self[(key.to_sym rescue key) || key] = delete(key)
    end
    values.each{|h| h.symbolize_keys! if h.is_a?(Hash) }
    self
  end
end

