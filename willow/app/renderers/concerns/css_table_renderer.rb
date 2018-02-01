module Concerns
  module CssTableRenderer
    def row(&block)
      %Q(<div class="tr">#{yield}</div>)
    end

    def thead(&block)
      %Q(<div class="thead">#{yield}</div>)
    end

    def header(&block)
      %Q(<div class="th">#{yield}</div>)
    end

    def cell(&block)
      %Q(<div class="td">#{yield}</div>)
    end

    def table(&block)
      %Q(<div class="table">#{yield}</div>)
    end

    def tbody(&block)
      %Q(<div class="tbody">#{yield}</div>)
    end
  end
end
