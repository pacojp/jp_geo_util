module JpGeoCalc
  # 日本測地系 → 世界測地系
  # via http://d.hatena.ne.jp/samori/20080214/1203004859
  def tokyo2wgs84(lat,lng)
    hash = Hash.new
    hash["lat"] = lat - 0.000046038 * lng - 0.000083043 * lat + 0.010040
    hash["lng"] = lng - 0.00010695  * lng + 0.000017464 * lat + 0.0046017
    return hash
  end

  # 総秒数 → 時分秒
  # 総秒数:ちず丸等で使用している値です（言葉は適当です）
  def total_sec_to_hms(v)
    v = (v * 100).to_i
    ji = v / 3600_00
    amari = v % 3600_00
    hun   = (amari / 60_00).to_i.to_s.rjust(2,'0')
    byou   = amari % 60_00
    "#{ji}.#{hun}#{byou.to_i}".to_f
  end

  # h.ms -> h.num
  def hms_to_hnum(v)
    return v.to_f unless v.to_s.split('.')
    vals   = v.to_s.split('.')
    hour   = vals[0].to_f
    minsec = vals[1].ljust(8,'0')
    minsec = ("0.#{minsec}".to_f * 100_00_00_00).to_i
    minsec = minsec.to_s.rjust(8,'0')
    minsec = (minsec[0..1].to_f / 60.0) +
             (minsec[2..-1].to_f / 100_00.0 / 3600.0)
    hour + minsec
  end

  #
  # 総秒数(ex.ちず丸) → 世界測地系(ex.GoogleMaps)
  # 509489.2296 →141.52108583806316
  #
  def jp_sec_to_wgs_84(x,y)
    x = total_sec_to_hms(x)
    y = total_sec_to_hms(y)

    y = hms_to_hnum(y)
    x = hms_to_hnum(x)

    hash = tokyo2wgs84(x.to_f,y.to_f)
  end
end

extend JpGeoCalc

x = 509489.2296
y = 155205.9144

hash = jp_sec_to_wgs_84(x,y)
puts "       #{hash['lng']},#{hash['lat']}"

puts "ans:   43.115215,141.5210088"

# TODO 35.00123 とか 35 とか の値になるもののテスト
