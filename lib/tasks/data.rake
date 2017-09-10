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
end
