module RecordsHelper
  def score(records)
    sum = 0
    count = 0
    records.each do |record|
      if record.each_score.positive?
        sum += record.each_score
        count += 1
      end
    end
    count.zero? ? 0 : sum / count
  end

  def score_comment(score)
    if score.zero?
      'まだみんなにスタンプをもらっていないようです。'
    elsif score > 70
      '１日頑張れたみたい！'
    elsif score > 40
      'まあまあな１日を過ごせたみたい。'
    else
      'あんまり頑張れなかったみたい…'
    end
  end
end
