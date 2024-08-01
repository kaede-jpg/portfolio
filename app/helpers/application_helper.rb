module ApplicationHelper
  def default_meta_tags
    {
      site: t('helpers.title'),
      title: 'ダイエットを監視しましょう！',
      charset: 'utf-8',
      description: '「ぷに活監視システム」は、家族・友人のダイエットを監視することができるサービスです。',
      keywords: 'ぷに活,ダイエット,食事,SNS,監視,家族,恋人,友人,見張る',
      canonical: request.original_url,
      separator: '|',
      og: {
        site_name: :site,
        title: :title,
        description: :description,
        type: 'website',
        url: request.original_url,
        image: image_url('title_logo_row.png'),
        local: 'ja-JP'
      },
      twitter: {
        card: 'summary_large_image',
        image: image_url('title_logo_row.png')
      }
    }
  end
end
