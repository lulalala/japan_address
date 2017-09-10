namespace :data do
  desc "Generate random addresses into database"
  task :generate, :environment do |t, args|
    mc = Municipality.count

    ms = Municipality.all.to_a

    as= []

    20000.times do
      m = ms.sample

      a = Address.new()
      if m.gun_id.present?
        a.gun = m.gun.name
      end

      a.prefecture =  m.prefecture.name
      a.municipality = m.name


      if m.sub_municipalities.size > 0 #with_sub?
        a.other = m.sub_municipalities.all.sample
      end

      a.full_address = [a.prefecture, a.gun, a.municipality, a.other].compact.join

      a.save!
    end
  end

  task :train => :environment do
    attrs = %w{prefecture gun municipality other}

    data = []

    Address.where('id > 1000').find_each do |a|
      inner = []
      attrs.each do |attr|
        v = a.send(attr)
        next if v.blank?
        v.chars.each do |ch|
          inner << "#{ch} n #{attr}"
        end
      end
      data << inner
    end
    model = Wapiti.train(data, {pattern:'data/pattern.txt'})
    model.save("result.mod")
  end
end
