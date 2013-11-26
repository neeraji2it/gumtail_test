class Trend
  STREAM_KEY = "trend"
  HALF_LIFE = 1.day.to_i

  # 2.5 \* half_life (in days) years from now
  EPOCH = Date.new(2015, 3, 16).to_time.to_i

  # Cast a vote when any of the tags is used in a product
  def self.onVote(tag)
    $redis.zincrby(STREAM_KEY, tag.id, 2 ** ((Time.now.to_i - EPOCH) / HALF_LIFE))
    trim(STREAM_KEY, 10000)
  end

  def self.get(limit=6)
    $redis.zrevrange(STREAM_KEY, 0, limit).map(&:to_i)
  end

  def self.trim(key, n)
    $redis.zremrangebyrank(key, 0, -n) if rand < (2.to_f/n)
  end

  # to be run evry five years
  def self.migrate(new_key, new_epoch)
    $redis.zunionstore(new_key, [STREAM_KEY], :weights => [2 ** ((new_epoch - EPOCH) / half_life)])
  end
end