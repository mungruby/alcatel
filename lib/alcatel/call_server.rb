
 
module Alcatel

  #
  # Class to represent an alcatel call server with tables loaded using lazy initialization
  #
  class CallServer

    attr_reader :mss_name

    def initialize mss_name
      @mss_name = mss_name.upcase
    end

    def emsorigrouteprofilelist
      @emsorigrouteprofilelist = EMSORIGROUTEPROFILELIST_TABLE.new mss_name
    end

    def emsnationaltreeselector
      @emsnationaltreeselector = EMSNATIONALTREESELECTOR_TABLE.new mss_name
    end

    def emsdigitdescriptor
      @emsdigitdescriptor ||= Alcatel::EMSDIGITDESCRIPTOR_TABLE.new mss_name
    end

    def cpcallmoutpulsemap
      @cpcallmoutpulsemap ||= Alcatel::CPCALLMOUTPULSEMAP_TABLE.new mss_name
    end

    def mscroutelist
      @mscroutelist ||= Alcatel::MSCROUTELIST_TABLE.new mss_name
    end

    def cpcallmorigrouting
      @cpcallmorigrouting ||= Alcatel::CPCALLMORIGROUTING_TABLE.new mss_name
    end

    def emswirelessnormal
      @emswirelessnormal ||= Alcatel::EMSWIRELESSNORMAL_TABLE.new mss_name
    end

    def prefix
      @prefix ||= Alcatel::PREFIX_TABLE.new mss_name
    end

    def cpcallmdigittranslator
      @cpcallmdigittranslator ||= Alcatel::CPCALLMDIGITTRANSLATOR_TABLE.new mss_name
    end

    def spm_pcard_calltype
      @spm_pcard_calltype ||= Alcatel::SPM_PCARD_CALLTYPE_TABLE.new mss_name
    end

    def modifiers
      EDWPlayground.new.connect do |db|
        @cpcallmcountrycode = cpcallmcountrycode(db).flatten
        @cpcallmdigittranslator = cpcallmdigittranslator(db).flatten
        @cpcallmdigitfence = cpcallmdigitfence(db).flatten
      end
      (@cpcallmcountrycode + @cpcallmdigittranslator + @cpcallmdigitfence).uniq
    end

    def clear
      @emsorigrouteprofilelist = nil
      @emsdigitdescriptor = nil
      @cpcallmorigrouting = nil
      @mscroutelist = nil
    end
  end
end

   
