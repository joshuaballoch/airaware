class DeferredGarbageCollection

  DEFERRED_GC_THRESHOLD = (ENV['DEFERRED_GC'] || 3.0).to_f

  @@gc_run_timestamp = Time.now

  class << self
    def start
      GC.disable if DEFERRED_GC_THRESHOLD > 0
    end

    def reconsider
      if DEFERRED_GC_THRESHOLD > 0 && (Time.now - @@gc_run_timestamp >= DEFERRED_GC_THRESHOLD)
        GC.enable
        GC.start
        GC.disable

        @@gc_run_timestamp = Time.now
      end
    end
  end
end
