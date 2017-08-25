require 'json'

class Util
  @@json = JSON.load(File.open("./data/local-government-code-of-japan.json"))

  def self.data
    @@data ||= @@json.first["regions"]
  end

  def self.prefectures
    data.map {|d|
      d["prefectures"]
    }.flatten
  end
end
