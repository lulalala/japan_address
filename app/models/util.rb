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

        handle_districts(p, phash)
        handle_cities(p, phash)

        if phash['branches'].present?
          phash['branches'].each do |bhash|
            handle_districts(p, bhash)
            handle_cities(p, bhash)
          end
        end
      }
    }
  end

  def self.handle_cities(p, hash)
    return if hash["cities"].blank?

    hash['cities'].each do |chash|
      if chash['code'] == 13100 # 東京都特別区
        chash['wards'].each do |whash|
          m = Municipality.find_or_create_by(prefecture_id: p.id, gun_id: nil, name: whash['name'])
        end
      else
        m = Municipality.find_or_create_by(prefecture_id: p.id, gun_id: nil, name: chash['name'])
      end
    end
  end

  def self.handle_districts(p, hash)
    return if hash["districts"].blank?

    hash["districts"].each do |dhash|
      g = Gun.find_or_create_by(prefecture_id: p.id, name: dhash["name"])

      dhash['cities'].each do |chash|
        m = Municipality.find_or_create_by(prefecture_id: p.id, gun_id: g.id, name: chash['name'])
      end
    end
  end
end
