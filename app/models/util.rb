require 'json'

class Util
  @@json = JSON.load(File.open("./data/local-government-code-of-japan.json"))

  def self.data
    @@data ||= @@json.first["regions"]
  end

  def self.seed
    data.each {|d|
      d["prefectures"].each {|phash|
        p = Prefecture.find_or_create_by(name: phash["name"])

        if phash["districts"].present?
          phash["districts"].each do |dhash|
            g = Gun.find_or_create_by(prefecture_id: p.id, name: dhash["name"])
          end
        end
      }
    }
  end
end
