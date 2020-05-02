section_hashes1 = []

hash3 = {}
hash3[:section_id] = 'block-nw-home-featured-story'
hash3[:title_class] = 'block-title'
hash3[:article_tag] = 'article'
hash3[:article_header_tag] = 'h1 a'
hash3[:article_desc_class] = 'summary'
section_hashes1 << hash3

hash1 = {}
hash1[:section_id] = 'block-nw-home-featured-stories'
hash1[:title_class] = 'block-title'
hash1[:article_tag] = 'article'
hash1[:article_header_tag] = 'h3 a'
hash1[:article_desc_class] = 'summary'
section_hashes1 << hash1

hash2 = {}
hash2[:title] = 'special articles'
hash2[:article_class] = 'block-ibtmedia-special-item'
hash2[:article_header_tag] = 'h3 a'
hash2[:article_desc_class] = 'summary'
section_hashes1 << hash2

hash4 = {}
hash4[:section_id] = 'block-nw-home-featured-more'
hash4[:title_class] = 'block-title'
hash4[:article_tag] = 'article'
hash4[:article_header_tag] = 'h4 a'
hash4[:article_desc_class] = 'summary'
section_hashes1 << hash4

hash5 = {}
hash5[:section_id] = 'block-nw-editors-pick'
hash5[:title] = 'EDITOR\'S PICK'
hash5[:article_tag] = 'article'
hash5[:article_header_tag] = 'h3 a'
hash5[:article_desc_class] = 'summary'
section_hashes1 << hash5

$source_hash1 = {}
$source_hash1[:caption] = 'NewsWeek'
$source_hash1[:url] = 'https://www.newsweek.com'
$source_hash1[:section_hashes] = section_hashes1
