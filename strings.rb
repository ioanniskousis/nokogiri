class String
  def uni_flat
    str = self.gsub('&#x2019;', '\'')
    str
  end
end