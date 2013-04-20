module JpGeoUtil
  module Core
    # 日本測地系 → 世界測地系
    # via http://d.hatena.ne.jp/samori/20080214/1203004859
    def tokyo2wgs84(opt)
      lat, lng = parse_location_argument(opt)
      {
        :lat => lat - 0.000046038 * lng - 0.000083043 * lat + 0.010040,
        :lng => lng - 0.00010695  * lng + 0.000017464 * lat + 0.0046017
      }
    end

    # 総秒数 →h.ms(時分秒)
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
    def jp_total_sec_to_wgs84(opt)
      x,y = parse_location_argument(opt)

      x = total_sec_to_hms(x)
      y = total_sec_to_hms(y)

      x = hms_to_hnum(x)
      y = hms_to_hnum(y)

      hash = tokyo2wgs84({:lat=>x.to_f,:lng=>y.to_f})
    end

    def parse_location_argument(opt)
      if opt[:x] && opt[:y]
        lat = opt.fetch :x
        lng = opt.fetch :y
      elsif opt[:lat] && opt[:lng]
        lat = opt.fetch :lat
        lng = opt.fetch :lng
      else
        raise ArgumentError 'argument must contain :x,:y or :lat,:lng'
      end

      if (String === lat && lat.empty?) || (String === lng && lng.empty?)
        raise ArgumentError "argument can not be empty string"
      end

      lat = lat.to_f if String === lat
      lng = lng.to_f if String === lng
      [lat, lng]
    end
  end
end
