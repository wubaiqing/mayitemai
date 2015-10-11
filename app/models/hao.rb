# coding: utf-8

# 商品
class Hao

  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::BaseModel

  # 必填
  validates :taobao_id, :taobao_url, :title, :price, :picture_url, :tagid, :site, :site_url, :tagid, :post, presence: true

  # 唯一
  validates :taobao_id, uniqueness: true

  # 淘宝ID
  field :taobao_id, type: Integer

  # 淘宝URL
  field :taobao_url

  # 标题
  field :title

  # 现价
  field :price

  # 图片URL
  field :picture_url

  # site
  field :site

  # site_url
  field :site_url

  # tagid
  field :tagid

  # 分类ID
  field :cate_id, type: Integer, default: 0

  # 状态
  field :state, type: Integer, default: 1

  # 包邮
  field :post , type: Integer, default: 1

  # 关联
  belongs_to :brand

  # 索引
  index state: 1
  index brand_id: 1
  index taobao_id: 1


  # 保存后更新缓存时间
  after_save :update_cache_version

  # 错误状态
  ERROR_STATE = {
    DATA_EXISTS: 10001
  }

  # 记录节点变更时间，用于清除缓存
  def update_cache_version
    CacheVersion.good_node_updated_at = Time.now
  end

  # 根据淘宝ID获取淘宝信息
  def self.fetch_taobao_repositories(taobao_id, uniqueness = true)

    if uniqueness.eql?(true)
      uniqueness = self.find_by_taobao_id(taobao_id)
      if !uniqueness.blank?
        return {'errorCode': ERROR_STATE[:DATA_EXISTS]}.to_json
      end
    end

    begin
      hash = OpenTaobao.get(
        :method => "taobao.tbk.items.detail.get",
        :fields => "num_iid,seller_id,nick,title,price,volume,pic_url,item_url,shop_url",
        :num_iids => taobao_id
      )
    rescue => e
      Rails.logger.error("Taobao Repositories fetch Error: #{e}")
      return false
    end
  end

  # 根据淘宝ID查询
  def self.find_by_taobao_id(taobao_id)
    where(taobao_id: taobao_id)
  end


  def self.findData(tagid, type)

    json = [
      {
        "long_title" => "红蜻蜓秋季新款商务正装皮鞋",
        "identify" => 520269578538,
        "url" => "https://detail.tmall.com/item.htm?spm=0.0.0.0.IcP2p0&id=520269578538",
        "img_url" => "http://7xioz9.com2.z0.glb.qiniucdn.com/20150929221526/ade9b496a7f0f3be85a8910f5b.png",
        "price" => 259,
        "site" => "红蜻蜓品牌旗舰店",
        "site_url" => "https://reddragonfly.tmall.com/",
        "tagid" => 1,
        "tag" => "男鞋",
        "post" => 1,
      },
      {
        "long_title" => "法兰琳卡洗面奶 芦荟清透洁面膏",
        "identify" => 140105335569,
        "url" => "https://detail.tmall.com/item.htm?spm=a230r.1.14.6.Xh658X&id=12605702713&cm_id=140105335569ed55e27b&abbucket=12&skuId=31926126602",
        "img_url" => "http://7xioz9.com2.z0.glb.qiniucdn.com/20150929221639/040af560ec9b2952d3acc678f5.png",
        "price" => 33,
        "site" => "法兰琳卡旗舰店",
        "site_url" => "https://franic.tmall.com",
        "tagid" => 9,
        "tag" => "护肤",
        "post" => 1,
      },
      {
        "long_title" => "拉芳清爽止痒控油去屑洗发水露洗护套装",
        "identify" => 140105335569,
        "url" => "https://detail.tmall.com/item.htm?spm=a230r.1.14.6.dhk5Ym&id=38215024596&cm_id=140105335569ed55e27b&abbucket=12&skuId=61346099628",
        "img_url" => "http://7xioz9.com2.z0.glb.qiniucdn.com/20150929221820/21f7fb3a4801b7b605eaee429a.png",
        "price" => 39.9,
        "site" => "拉芳旗舰店",
        "site_url" => "https://lafang.tmall.com",
        "tagid" => 16,
        "tag" => "个护",
        "post" => 1,
      },
      {
        "long_title" => "衣品天成 2015冬装女外套 ",
        "identify" => 522557649170,
        "url" => "https://detail.tmall.com/item.htm?spm=a1z10.4-b.w5003-10503124606.1.pIAUd7&id=522557649170&scene=taobao_shop",
        "img_url" => "http://7xioz9.com2.z0.glb.qiniucdn.com/20150929221935/b446f4820c2b028fcede76c53f.png",
        "price" => 239,
        "site" => "衣品天成女装旗舰店",
        "site_url" => "https://eptisonfs.tmall.com",
        "tagid" => 5,
        "tag" => "女装",
        "post" => 0,
      },
      {
        "long_title" => "轻柔棉 衣品天成 2015新款秋装",
        "identify" => 520181762022,
        "url" => "https://detail.tmall.com/item.htm?spm=a1z10.1-b.w5003-9620516777.2.8Tny9y&id=520181762022&scene=taobao_shop",
        "img_url" => "http://7xioz9.com2.z0.glb.qiniucdn.com/20150929222114/a877ce1a84c47bbd63cf8efa80.png",
        "price" => 89,
        "site" => "衣品天成旗舰店",
        "site_url" => "https://yipintiancheng.tmall.com",
        "tagid" => 4,
        "tag" => "男装",
        "post" => 0,
      },
      {
        "long_title" => "米莱达 女装新款长袖羊毛呢子外套",
        "identify" => 520401583868,
        "url" => "https://detail.tmall.com/item.htm?spm=a1z10.3-b.w4011-4934566786.99.Ea6x99&id=520401583868&rn=1ef86c0b761e8069b04fc1efe25c497b&abbucket=3",
        "wapurl" => "",
        "img_url" => "http://7xioz9.com2.z0.glb.qiniucdn.com/20150929222206/6792fb4031bf815b948ad60a75.png",
        "price" => 379,
        "cheap" => "",
        "site" => "米莱达旗舰店",
        "site_url" => "https://meetlady.tmall.com",
        "tagid" => 5,
        "tag" => "女装",
        "post" => 1
      },
      {
        "long_title" => "柯玛妮克/Komanic 冬款真皮内增高女靴子",
        "identify" => 520793269028,
        "url" => "https://detail.tmall.com/item.htm?spm=a1z10.4-b.w5003-12129742527.1.behlST&id=520793269028&rn=d0ab94770e79b8908d0742f3bc4584ab&abbucket=0&scene=taobao_shop",
        "wapurl" => "",
        "img_url" => "http://7xioz9.com2.z0.glb.qiniucdn.com/20150929222256/54608c16833c9c2e572af17541.png",
        "price" => 658,
        "cheap" => "",
        "site" => "柯玛妮克旗舰店",
        "site_url" => "https://komanic.tmall.com",
        "tagid" => 2,
        "tag" => "女鞋",
        "post" => 1
      },
      {
        "long_title" => "京润珍珠100g纳米级纯天然珍珠粉外用祛痘印面膜粉",
        "identify" => 16034770506,
        "url" => "https://detail.tmall.com/item.htm?spm=a1z10.1-b.w10580958-12294210508.1.1WprAk&id=16034770506&scene=taobao_shop&skuId=31647852195",
        "wapurl" => "",
        "img_url" => "http://7xioz9.com2.z0.glb.qiniucdn.com/20150929222340/2a916ea8309f7bd3d932b32864.png",
        "price" => 168,
        "cheap" => "",
        "site" => "京润珍珠旗舰店",
        "site_url" => "https://gnpearl.tmall.com",
        "tagid" => 9,
        "tag" => "护肤",
        "post" => 1
      },
      {
        "long_title" => "伊米妮女士欧美风牛皮手拿包",
        "identify" => 5720807463,
        "url" => "https://detail.tmall.com/item.htm?spm=a1z10.3-b.w4011-2915023283.94.3Zc9US&id=5720807463&rn=e63182378b9f0b5d8578388e3a134a57&abbucket=3",
        "wapurl" => "",
        "img_url" => "http://7xioz9.com2.z0.glb.qiniucdn.com/20150929222439/1714e6100b7d317093bc6c1347.png",
        "price" => 148,
        "cheap" => "",
        "site" => "伊米妮旗舰店",
        "site_url" => "https://gnpearl.tmall.com",
        "tagid" => 18,
        "tag" => "女包",
        "post" => 0
      },
      {
        "long_title" => "米缇贝蒂2015女士包包",
        "identify" => 26950944811,
        "url" => "https://detail.tmall.com/item.htm?spm=a1z10.1-b.w5003-12296212117.2.UerRj3&id=26950944811&rn=815d49317a4a259abebd1a8bd2a0bdfb&abbucket=8&scene=taobao_shop",
        "wapurl" => "",
        "img_url" => "http://7xioz9.com2.z0.glb.qiniucdn.com/20150929222528/26742601fd33f483c89b5bc794.png",
        "price" => 199,
        "cheap" => "",
        "site" => "米缇贝蒂箱包旗舰店 ",
        "site_url" => "https://mitibeidi.tmall.com",
        "tagid" => 18,
        "tag" => "女包",
        "post" => 1
      },
      {
        "long_title" => "皮尔卡丹男士钱包真皮新款",
        "identify" => 42506928522,
        "url" => "https://detail.tmall.com/item.htm?spm=a1z10.3-b.w4011-11563869491.94.YItXBc&id=42506928522&rn=97acd754f2ce7851188cf28303295bcc&abbucket=3",
        "wapurl" => "",
        "img_url" => "http://7xioz9.com2.z0.glb.qiniucdn.com/20150929222620/5c4adce49cc1f600f51ac3d7a4.png",
        "price" => 259,
        "cheap" => "",
        "site" => "皮尔卡丹箱包官方旗舰店",
        "site_url" => "https://pierrecardinxb.tmall.com",
        "tagid" => 17,
        "tag" => "男包",
        "post" => 1
      },
      {
        "long_title" => "意尔丹2015秋冬款编织真皮女包大包 ",
        "identify" => 521054537832,
        "url" => "https://detail.tmall.com/item.htm?spm=a1z10.4-b.w10536687-12233707190.4.ldjETh&id=521054537832&rn=b5884abc918a746883f11410ca2521d6&abbucket=4&scene=taobao_shop",
        "wapurl" => "",
        "img_url" => "http://7xioz9.com2.z0.glb.qiniucdn.com/20150929222710/80dc8ced1b151b5568b9308e17.png",
        "price" => 399,
        "cheap" => "",
        "site" => "意尔丹旗舰店",
        "site_url" => "https://yeardanfs.tmall.com",
        "tagid" => 18,
        "tag" => "女包",
        "post" => 0
      },
      {
        "long_title" => "2015秋季通勤性感时尚方头一字带浅口鞋",
        "identify" => 520712365116,
        "url" => "https://detail.tmall.com/item.htm?spm=a1z10.1-b.w9889567-11358759649.2.eGQiIp&id=520712365116&rn=7594069f9f579fe3501f9c44a671023f&abbucket=3",
        "wapurl" => "",
        "img_url" => "http://7xioz9.com2.z0.glb.qiniucdn.com/20150929222833/8a71fbddba2897bd70d6adb607.png",
        "price" => 179,
        "cheap" => "",
        "site" => "星奇意鞋类旗舰店",
        "site_url" => "https://xingqiyixl.tmall.com",
        "tagid" => 2,
        "tag" => "女鞋",
        "post" => 1
      },
      {
        "long_title" => "奥康低帮鞋男鞋新款商务正装皮鞋",
        "identify" => 40446053590,
        "url" => "https://detail.tmall.com/item.htm?spm=a1z10.4-b.w5003-12282267094.1.3vqLw1&id=40446053590&scene=taobao_shop",
        "wapurl" => "",
        "img_url" => "http://7xioz9.com2.z0.glb.qiniucdn.com/20150929222937/6f5f494f757748ddade42beb97.png",
        "price" => 259,
        "cheap" => "",
        "site" => "奥康鞋业旗舰店",
        "site_url" => "https://aokang.tmall.com",
        "tagid" => 1,
        "tag" => "男鞋",
        "post" => 1
      },
      {
        "long_title" => "amii2015秋装新款长袖",
        "identify" => 520365500661,
        "url" => "https://detail.tmall.com/item.htm?spm=a230r.1.14.22.oEfAfH&id=520365500661&ns=1&abbucket=12",
        "wapurl" => "",
        "img_url" => "http://7xioz9.com2.z0.glb.qiniucdn.com/20150929223025/0480fe64630d75ee0fa8f848ed.png",
        "price" => 99,
        "cheap" => "",
        "site" => "amii旗舰店",
        "site_url" => "https://amii.tmall.com",
        "tagid" => 5,
        "tag" => "女装",
        "post" => 1
      },
      {
        "long_title" => "爱丽缇2015秋冬季新款短款轻薄羽绒服",
        "identify" => 522193857055,
        "url" => "https://detail.tmall.com/item.htm?spm=a1z10.4-b.w7518956-5333335800.2.p3zHru&id=522193857055",
        "wapurl" => "",
        "img_url" => "http://7xioz9.com2.z0.glb.qiniucdn.com/20150929223124/4e119f9e79e889a4f9450b7a5f.png",
        "price" => 158,
        "cheap" => "",
        "site" => "爱丽缇旗舰店 ",
        "site_url" => "https://ailiti.tmall.com",
        "tagid" => 5,
        "tag" => "女装",
        "post" => 0
      },
      {
        "long_title" => "童装男童毛衣套头圆领儿童针织衫",
        "identify" => 40900152758,
        "url" => "https://detail.tmall.com/item.htm?spm=a1z10.5-b.w4011-9364736558.90.1E7Bxj&id=40900152758&rn=593de24f92c3b7c2ec9dfa17d8c6be2e&abbucket=3",
        "wapurl" => "",
        "img_url" => "http://7xioz9.com2.z0.glb.qiniucdn.com/20150929223216/48af1844c925a5fef7814bc96e.png",
        "price" => 99,
        "cheap" => "",
        "site" => "爱乐贝兜儿旗舰店",
        "site_url" => "https://aiyuebeidouer.tmall.com",
        "tagid" => 6,
        "tag" => "童装",
        "post" => 0
      },
      {
        "long_title" => "坚果特产臻选大礼包1700g",
        "identify" => 44339675898,
        "url" => "https://detail.tmall.com/item.htm?spm=a1z10.1-b.w5003-12032824391.1.lyVVFI&id=44339675898&scene=taobao_shop",
        "wapurl" => "",
        "img_url" => "http://7xioz9.com2.z0.glb.qiniucdn.com/20150929223314/43af89ee480fa7e39b034758c9.png",
        "price" => 99,
        "cheap" => "",
        "site" => "果仓旗舰店",
        "site_url" => "https://guocang.tmall.com",
        "tagid" => 10,
        "tag" => "食品",
        "post" => 1
      },
      {
        "long_title" => "好想你若羌红枣 新疆特产若羌枣灰枣",
        "identify" => 521488375733,
        "url" => "https://detail.tmall.com/item.htm?spm=a1z10.1-b.w10580866-12178625685.2.cLF5M5&id=521488375733&tracelog=jubuybigpic&scene=taobao_shop",
        "wapurl" => "",
        "img_url" => "http://7xioz9.com2.z0.glb.qiniucdn.com/20150929223357/fcf65d728be6877668455d22bf.png",
        "price" => 89,
        "cheap" => "",
        "site" => "好想你官方旗舰店",
        "site_url" => "https://haoxiangni.tmall.com",
        "tagid" => 10,
        "tag" => "食品",
        "post" => 0
      },
      {
        "long_title" => "衣品天成 童装 2015秋装新款",
        "identify" => 521101350951,
        "url" => "https://detail.tmall.com/item.htm?spm=a1z10.1-b.w10616125-12195115863.5.561HmY&id=521101350951&abbucket=_AB-M32_B4&rn=eef172fe47cf98ab1d684736cf124e60&acm=03054.1003.1.397554&aldid=y6u9WWHk&abtest=_AB-LR32-PV32_1951&scm=1003.1.03054.13_521101350951_397554&pos=3",
        "wapurl" => "",
        "img_url" => "http://7xioz9.com2.z0.glb.qiniucdn.com/20150929223522/ccb186315462f1930b6525789b.png",
        "price" => 99,
        "cheap" => "",
        "site" => "衣品天成童装旗舰店",
        "site_url" => "https://eptisontz.tmall.com",
        "tagid" => 6,
        "tag" => "童装",
        "post" => 1
      },
      {
        "long_title" => "水星家纺 全棉小提花印花四件套",
        "identify" => 43854529603,
        "url" => "https://detail.tmall.com/item.htm?spm=a1z10.1-b.w5003-12032798394.8.Wcb3lr&id=43854529603&scene=taobao_shop",
        "wapurl" => "",
        "img_url" => "http://7xioz9.com2.z0.glb.qiniucdn.com/20150929223611/25f1b2ccea73020b89f2e7811c.png",
        "price" => 439,
        "cheap" => "",
        "site" => "水星家纺旗舰店",
        "site_url" => "https://shuixing.tmall.com/",
        "tagid" => 14,
        "tag" => "家居",
        "post" => 0
      },
      {
        "long_title" => "木木屋童鞋男童2015秋冬新款女童",
        "identify" => 520762951874,
        "url" => "https://detail.tmall.com/item.htm?spm=a1z10.1-b.w5003-11972520244.1.0grP4M&id=520762951874&scene=taobao_shop",
        "wapurl" => "",
        "img_url" => "http://7xioz9.com2.z0.glb.qiniucdn.com/20150929223710/48babf5f6cfb6f7a77e26ff216.png",
        "price" => 49,
        "cheap" => "",
        "site" => "木木屋旗舰店",
        "site_url" => "https://mumuwu.tmall.com",
        "tagid" => 3,
        "tag" => "童鞋",
        "post" => 1
      },
      {
        "long_title" => "韩都衣舍韩版2015秋装新款女装宽松印花加绒休闲卫衣",
        "identify" => 520412185507,
        "url" => "https://detail.tmall.com/item.htm?spm=a1z10.3-b.w4011-1136113151.135.4YUT1V&id=520412185507&rn=a94b89093ecdc0600c6a4136009ef217&abbucket=9&sku_properties=-1:-1",
        "wapurl" => "",
        "img_url" => "http://7xioz9.com2.z0.glb.qiniucdn.com/20150929223828/62c1636e8cb396cd02f44fc08f.png",
        "price" => 126,
        "cheap" => "",
        "site" => "韩都衣舍旗舰店",
        "site_url" => "https://handuyishe.tmall.com/",
        "tagid" => 5,
        "tag" => "女装",
        "post" => 0
      },
      {
        "long_title" => "Camel骆驼男鞋 2015秋季新款牛皮头层皮耐磨男士板鞋",
        "identify" => 520710011324,
        "url" => "https://detail.tmall.com/item.htm?spm=a220m.1000858.1000725.1.rYNcll&id=520710011324&skuId=3103368264465&areaId=131000&cat_id=2&rn=2612d6212cb9d504cd1470f899a39c78&user_id=379092709&is_b=1",
        "wapurl" => "",
        "img_url" => "http://7xioz9.com2.z0.glb.qiniucdn.com/20150929223922/4a14112ab10f3a4aedb86fac6c.png",
        "price" => 368.5,
        "cheap" => "",
        "site" => "骆驼服饰旗舰店",
        "site_url" => "https://luotuo.tmall.com",
        "tagid" => 1,
        "tag" => "男鞋",
        "post" => 1
      },
      {
        "long_title" => "AFU阿芙神采美目复方油 哆啦A梦限定版 淡化黑眼圈细纹 紧致补水",
        "identify" => 45306463682,
        "url" => "https://detail.tmall.com/item.htm?spm=a1z10.1-b.w5003-12252794269.45.XNuJd0&id=45306463682&rn=0262e48d38ca75b81f8f30d7d3aeeefc&abbucket=9&skuId=90849723848&scene=taobao_shop",
        "wapurl" => "",
        "img_url" => "http://7xioz9.com2.z0.glb.qiniucdn.com/20150929224054/105fbf9fdacb8128bcc73a3687.png",
        "price" => 129,
        "cheap" => "",
        "site" => "阿芙官方旗舰店",
        "site_url" => "https://afusjt.tmall.com/",
        "tagid" => 9,
        "tag" => "护肤",
        "post" => 0
      },
      {
        "long_title" => "AMH男装韩版2015秋装新款修身圆领时尚男士条纹长袖T恤",
        "identify" => 21556011396,
        "url" => "https://detail.tmall.com/item.htm?spm=a1z10.3-b.w4011-12323982430.96.b3Mo7N&id=21556011396&rn=ade04dda5526e87132c509fb5c194833&abbucket=9",
        "wapurl" => "",
        "img_url" => "http://7xioz9.com2.z0.glb.qiniucdn.com/20150929224155/50add670ea960cd5e599dcbf87.png",
        "price" => 158,
        "cheap" => "",
        "site" => "AMH官方旗舰店",
        "site_url" => "https://amh.tmall.com/",
        "tagid" => 4,
        "tag" => "男装",
        "post" => 0
      },
      {
        "long_title" => "莱尔斯丹秋鞋女2015新款尖头高跟鞋",
        "identify" => 520063576598,
        "url" => "https://detail.tmall.com/item.htm?spm=a1z10.1-b.w5003-12023765937.13.kWqcxs&id=520063576598&scene=taobao_shop",
        "wapurl" => "",
        "img_url" => "http://7xioz9.com2.z0.glb.qiniucdn.com/20150929224235/46f19dee35a7f1e0f85831e4ed.png",
        "price" => 439,
        "cheap" => "",
        "site" => "莱尔斯丹官方旗舰店",
        "site_url" => "https://lxdxb.tmall.com",
        "tagid" => 2,
        "tag" => "女鞋",
        "post" => 0
      },
      {
        "long_title" => "ABC卫生巾 棉柔纤薄防侧漏日用+夜用套装纯棉组合",
        "identify" => 16027198488,
        "url" => "https://detail.tmall.com/item.htm?spm=a220m.1000858.1000725.16.DCdERW&id=16027198488&areaId=131000&cat_id=2&rn=8a6124d6d85bd08e844d17cb175c4019&user_id=765922982&is_b=1",
        "wapurl" => "",
        "img_url" => "http://7xioz9.com2.z0.glb.qiniucdn.com/20150929224336/0978a8a21d9e7b66e60f87dc25.png",
        "price" => 79.9,
        "cheap" => "",
        "site" => "abc官方旗舰店",
        "site_url" => "https://abc.tmall.com",
        "tagid" => 16,
        "tag" => "个护",
        "post" => 1
      },
      {
        "long_title" => "合生元金装幼儿3段配方奶粉 欧洲原罐 宝宝3阶段奶粉 ",
        "identify" => 39127180597,
        "url" => "https://detail.tmall.com/item.htm?spm=a1z10.3-b.w4011-6934758015.84.L5x19f&id=39127180597&rn=3e0d359c6cb59ac9d0e437c1ba7d78ba&abbucket=9",
        "wapurl" => "",
        "img_url" => "http://7xioz9.com2.z0.glb.qiniucdn.com/20150929224910/4eb6a7306407881ee7a40f02d7.png",
        "price" => 278,
        "cheap" => "",
        "site" => "合生元官方旗舰店",
        "site_url" => "https://biostime.tmall.com/",
        "tagid" => 13,
        "tag" => "宝宝",
        "post" => 1
      },
      {
        "long_title" => "牧童童鞋秋款运动鞋软超纤鞋面中2015新中小童撞色运动鞋",
        "identify" => 521083588989,
        "url" => "https://detail.tmall.com/item.htm?spm=a1z10.1-b.w5003-12021672608.1.Cbp5yY&id=521083588989&scene=taobao_shop",
        "wapurl" => "",
        "img_url" => "http://7xioz9.com2.z0.glb.qiniucdn.com/20150929225005/35f0d201ef16e2cb7582375e69.png",
        "price" => 99,
        "cheap" => "",
        "site" => "牧童官方旗舰店",
        "site_url" => "https://herd.tmall.com",
        "tagid" => 3,
        "tag" => "童鞋",
        "post" => 0
      },
      {
        "long_title" => "裂帛2015冬装新款刺绣连帽两面穿白鸭绒超长羽绒服",
        "identify" => 521059534349,
        "url" => "https://detail.tmall.com/item.htm?spm=a1z10.4-b.w5003-12391142065.3.rvdfNE&id=521059534349&scene=taobao_shop",
        "wapurl" => "",
        "img_url" => "http://7xioz9.com2.z0.glb.qiniucdn.com/20151010173248/83b43432128f87aa074bfb4efc.jpg",
        "price" => 599.8,
        "cheap" => "",
        "site" => "裂帛服饰旗舰店",
        "site_url" => "https://ripfs.tmall.com/",
        "tagid" => 5,
        "tag" => "女装",
        "post" => 1 
      },
      {
        "long_title" => "裂帛2015冬新款刺绣前短后长仿毛连帽白鸭绒羽绒服女",
        "identify" => 521061524251,
        "url" => "https://detail.tmall.com/item.htm?spm=a1z10.4-b.w5003-12391142065.4.rvdfNE&id=521061524251&rn=32b1304ec26f9db01a91f05be915d87f&abbucket=15&scene=taobao_shop",
        "wapurl" => "",
        "img_url" => "http://7xioz9.com2.z0.glb.qiniucdn.com/20151010173355/287e58474c350db9464bb586f6.jpg",
        "price" => 529.8,
        "cheap" => "",
        "site" => "裂帛服饰旗舰店",
        "site_url" => "https://ripfs.tmall.com/",
        "tagid" => 5,
        "tag" => "女装",
        "post" => 1 
      },
      {
        "long_title" => "裂帛2015冬新款异域几何提花针织衫宽松一字领长袖毛衣",
        "identify" => 521061208005,
        "url" => "https://detail.tmall.com/item.htm?spm=a1z10.4-b.w5003-12391142065.5.rvdfNE&id=521061208005&scene=taobao_shop",
        "wapurl" => "",
        "img_url" => "http://7xioz9.com2.z0.glb.qiniucdn.com/20151010173449/cd17dc050af43396783dd887e7.jpg",
        "price" => 179.8, 
        "cheap" => "",
        "site" => "裂帛服饰旗舰店",
        "site_url" => "https://ripfs.tmall.com/",
        "tagid" => 5,
        "tag" => "女装",
        "post" => 1 
      },
      {
        "long_title" => "裂帛2015秋冬新款银线刺绣呢大衣手工钉珠中长毛呢外套",
        "identify" => 521057825957,
        "url" => "https://detail.tmall.com/item.htm?spm=a1z10.4-b.w5003-12391142065.6.rvdfNE&id=521057825957&scene=taobao_shop",
        "wapurl" => "",
        "img_url" => "http://7xioz9.com2.z0.glb.qiniucdn.com/20151010173552/0ec3f33b813db996903cd0934b.jpg",
        "price" => 459.8, 
        "cheap" => "",
        "site" => "裂帛服饰旗舰店",
        "site_url" => "https://ripfs.tmall.com/",
        "tagid" => 5,
        "tag" => "女装",
        "post" => 1 
      },
      {
        "long_title" => "裂帛2015秋冬新款麻花扭绳间色毛衣撞料拼接长袖针织衫",
        "identify" => 521056361779,
        "url" => "https://detail.tmall.com/item.htm?spm=a1z10.4-b.w5003-12391142065.7.rvdfNE&id=521056361779&scene=taobao_shop",
        "wapurl" => "",
        "img_url" => "http://7xioz9.com2.z0.glb.qiniucdn.com/20151010173639/fdab24da285a537eef65463263.jpg",
        "price" => 159.8, 
        "cheap" => "",
        "site" => "裂帛服饰旗舰店",
        "site_url" => "https://ripfs.tmall.com/",
        "tagid" => 5,
        "tag" => "女装",
        "post" => 1 
      },
      {
        "long_title" => "慈元阁开光2015羊年杨仙太岁锦囊化符包",
        "identify" => 13445093873,
        "url" => "https://detail.tmall.com/item.htm?spm=a1z10.3-b.w4011-10634699133.115.BjluaW&id=13445093873&rn=d3e70b7e24e73b61893bb9f9d4cde104&abbucket=2",
        "wapurl" => "",
        "img_url" => "http://7xioz9.com2.z0.glb.qiniucdn.com/20151010174754/32e8064589b99527a2059c1fd2.jpg",
        "price" => 168, 
        "cheap" => "",
        "site" => "慈元阁旗舰店",
        "site_url" => "https://ciyuange.tmall.com/",
        "tagid" => 7,
        "tag" => "饰品",
        "post" => 1 
      },
      {
        "long_title" => "慈元阁开光2015十二生肖属羊本命年吉祥物",
        "identify" => 42009118800,
        "url" => "https://detail.tmall.com/item.htm?spm=a1z10.3-b.w4011-10634699133.120.BjluaW&id=42009118800&rn=d3e70b7e24e73b61893bb9f9d4cde104&abbucket=2&skuId=82796727922",
        "wapurl" => "",
        "img_url" => "http://7xioz9.com2.z0.glb.qiniucdn.com/20151010174845/90b7b07dbe840e1440226c2623.jpg",
        "price" => 198, 
        "cheap" => "",
        "site" => "慈元阁旗舰店",
        "site_url" => "https://ciyuange.tmall.com/",
        "tagid" => 7,
        "tag" => "饰品",
        "post" => 1 
      },
      {
        "long_title" => "慈元阁开光2015年属羊五法六尊如来南无尊手链",
        "identify" => 41993707829,
        "url" => "https://detail.tmall.com/item.htm?spm=a1z10.3-b.w4011-10634699133.125.BjluaW&id=41993707829&rn=d3e70b7e24e73b61893bb9f9d4cde104&abbucket=2",
        "wapurl" => "",
        "img_url" => "http://7xioz9.com2.z0.glb.qiniucdn.com/20151010174932/4ca26bf85836dd3f66f6be149a.jpg",
        "price" => 168, 
        "cheap" => "",
        "site" => "慈元阁旗舰店",
        "site_url" => "https://ciyuange.tmall.com/",
        "tagid" => 7,
        "tag" => "饰品",
        "post" => 1 
      },
      {
        "long_title" => "慈元阁开光车饰 如意保驾琉璃车挂 ",
        "identify" => 35791547598,
        "url" => "https://detail.tmall.com/item.htm?spm=a1z10.3-b.w4011-10634699133.165.BjluaW&id=35791547598&rn=d3e70b7e24e73b61893bb9f9d4cde104&abbucket=2",
        "img_url" => "http://7xioz9.com2.z0.glb.qiniucdn.com/20151010175016/31833bb2e6eedff8a2f6a86ede.jpg",
        "price" => 188,
        "site" => "慈元阁旗舰店",
        "site_url" => "https://ciyuange.tmall.com/",
        "tagid" => 7,
        "tag" => "饰品",
        "post" => 1,
        "cheap" => 0,
        "wapurl" => ""
      },
      {
        "long_title" => "慈元阁开光正品2015年十二生肖属狗吉祥物",
        "identify" => 42014078076,
        "url" => "https://detail.tmall.com/item.htm?spm=a1z10.3-b.w4011-10634699133.135.BjluaW&id=42014078076&rn=d3e70b7e24e73b61893bb9f9d4cde104&abbucket=2&skuId=82797239923",
        "img_url" => "http://7xioz9.com2.z0.glb.qiniucdn.com/20151010175055/32bd4300c20bbdce30ab52db81.jpg",
        "price" => 198,
        "site" => "慈元阁旗舰店",
        "site_url" => "https://ciyuange.tmall.com/",
        "tagid" => 7,
        "tag" => "饰品",
        "post" => 1,
        "cheap" => 0,
        "wapurl" => ""
      },
      {
        "long_title" => "良品铺子】芒果干108g*3袋包邮 菲律宾水果",
        "identify" => 36893779457,
        "url" => "https://detail.tmall.com/item.htm?spm=a1z10.3-b.w4011-2633044076.115.y4Rks1&id=36893779457&rn=fef16ec0e95d09dd57e598afa4f1aa37&abbucket=2",
        "img_url" => "http://7xioz9.com2.z0.glb.qiniucdn.com/20151010175151/fdd24852caf826f038b1989cd0.jpg",
        "price" => 25.9,
        "site" => "良品铺子旗舰店",
        "site_url" => "https://liangpinpuzi.tmall.com/",
        "tagid" => 10,
        "tag" => "食品",
        "post" => 1,
        "cheap" => 0,
        "wapurl" => ""
      },
      {
        "long_title" => "良品铺子】灯影牛肉丝250g",
        "identify" => 10122453980,
        "url" => "https://detail.tmall.com/item.htm?spm=a1z10.3-b.w4011-2633044076.118.y4Rks1&id=10122453980&rn=fef16ec0e95d09dd57e598afa4f1aa37&abbucket=2",
        "img_url" => "http://7xioz9.com2.z0.glb.qiniucdn.com/20151010175234/4afbe9bda1394677a35117b714.jpg",
        "price" => 29.9,
        "site" => "良品铺子旗舰店",
        "site_url" => "https://liangpinpuzi.tmall.com/",
        "tagid" => 10,
        "tag" => "食品",
        "post" => 1,
        "cheap" => 0,
        "wapurl" => ""
      },
      {
        "long_title" => "良品铺子手造麻薯组合礼盒装",
        "identify" => 40402384307,
        "url" => "https://detail.tmall.com/item.htm?spm=a1z10.3-b.w4011-2633044076.121.y4Rks1&id=40402384307&rn=fef16ec0e95d09dd57e598afa4f1aa37&abbucket=2",
        "img_url" => "http://7xioz9.com2.z0.glb.qiniucdn.com/20151010175321/7e7ac9f148f1904d48198646ac.jpg",
        "price" => 37.9,
        "site" => "良品铺子旗舰店",
        "site_url" => "https://liangpinpuzi.tmall.com/",
        "tagid" => 10,
        "tag" => "食品",
        "post" => 1,
        "cheap" => 0,
        "wapurl" => ""
      },
      {
        "long_title" => "良品铺子】夏威夷果280g*2奶油/盐_味",
        "identify" => 35109052504,
        "url" => "https://detail.tmall.com/item.htm?spm=a1z10.3-b.w4011-2633044076.124.y4Rks1&id=35109052504&rn=fef16ec0e95d09dd57e598afa4f1aa37&abbucket=2",
        "img_url" => "http://7xioz9.com2.z0.glb.qiniucdn.com/20151010175432/8ec04fc3a56d996560b644f4bd.jpg",
        "price" => 39.9,
        "site" => "良品铺子旗舰店",
        "site_url" => "https://liangpinpuzi.tmall.com/",
        "tagid" => 10,
        "tag" => "食品",
        "post" => 1,
        "cheap" => 0,
        "wapurl" => ""
      },
      {
        "long_title" => "【良品铺子】越南炭烧腰果仁238g*2袋",
        "identify" => 35278615226,
        "url" => "https://detail.tmall.com/item.htm?spm=a1z10.3-b.w4011-2633044076.127.y4Rks1&id=35278615226&rn=fef16ec0e95d09dd57e598afa4f1aa37&abbucket=2&skuId=33506978234",
        "img_url" => "http://7xioz9.com2.z0.glb.qiniucdn.com/20151010175513/f85627fada6310465101b333a8.jpg",
        "price" => 39.9,
        "site" => "良品铺子旗舰店",
        "site_url" => "https://liangpinpuzi.tmall.com/",
        "tagid" => 10,
        "tag" => "食品",
        "post" => 1,
        "cheap" => 0,
        "wapurl" => ""
      },
      {
        "long_title" => "奥康皮鞋男士商务正装漆皮鞋新款流行男鞋",
        "identify" => 12899042223,
        "url" => "https://detail.tmall.com/item.htm?spm=a1z10.3-b.w4011-10114996301.94.XFMxzd&id=12899042223&rn=8f179a3f863bf6459a5d3ebb95d9bd02&abbucket=2",
        "img_url" => "http://7xioz9.com2.z0.glb.qiniucdn.com/20151010175606/f5099294f326262d25fd25b91c.jpg",
        "price" => 239,
        "site" => "奥康鞋业旗舰店",
        "site_url" => "https://aokang.tmall.com/",
        "tagid" => 1,
        "tag" => "男鞋",
        "post" => 1,
        "cheap" => 0,
        "wapurl" => ""
      },
      {
        "long_title" => "奥康2015秋季新款男鞋 真皮日常休闲鞋潮鞋",
        "identify" => 521498278245,
        "url" => "https://detail.tmall.com/item.htm?spm=a1z10.4-b.w5003-12265951757.1.Lxwpsl&id=521498278245&scene=taobao_shop",
        "img_url" => "http://7xioz9.com2.z0.glb.qiniucdn.com/20151010175646/56b20a17f3281a462405212f63.jpg",
        "price" => 369,
        "site" => "奥康鞋业旗舰店",
        "site_url" => "https://aokang.tmall.com/",
        "tagid" => 1,
        "tag" => "男鞋",
        "post" => 1,
        "cheap" => 0,
        "wapurl" => ""
      },
      {
        "long_title" => "奥康男鞋2015秋季新款男士商务休闲皮鞋",
        "identify" => 520530297717,
        "url" => "https://detail.tmall.com/item.htm?spm=a1z10.4-b.w5003-12265951757.5.Lxwpsl&id=520530297717&scene=taobao_shop",
        "img_url" => "http://7xioz9.com2.z0.glb.qiniucdn.com/20151010175729/d3759ecdf8e9a0d2611ff183b0.jpg",
        "price" => 459,
        "site" => "奥康鞋业旗舰店",
        "site_url" => "https://aokang.tmall.com/",
        "tagid" => 1,
        "tag" => "男鞋",
        "post" => 1,
        "cheap" => 0,
        "wapurl" => ""
      },
      {
        "long_title" => "奥康男鞋2015秋季新款运动户外休闲真皮徒步鞋",
        "identify" => 521461787666,
        "url" => "https://detail.tmall.com/item.htm?spm=a1z10.4-b.w5003-12265951757.11.Lxwpsl&id=521461787666&scene=taobao_shop",
        "img_url" => "http://7xioz9.com2.z0.glb.qiniucdn.com/20151010175824/75319252d9bebdf2895be71a13.jpg",
        "price" => 339,
        "site" => "奥康鞋业旗舰店",
        "site_url" => "https://aokang.tmall.com/",
        "tagid" => 1,
        "tag" => "男鞋",
        "post" => 1,
        "cheap" => 0,
        "wapurl" => ""
      },
      {
        "long_title" => "奥康男鞋 2015秋季新款户外徒步越野",
        "identify" => 521469897653,
        "url" => "https://detail.tmall.com/item.htm?spm=a1z10.4-b.w5003-12265951757.13.Lxwpsl&id=521469897653&scene=taobao_shop",
        "img_url" => "http://7xioz9.com2.z0.glb.qiniucdn.com/20151010175903/f6785bcdc0ac6bda4f96b0b97a.jpg",
        "price" => 369,
        "site" => "奥康鞋业旗舰店",
        "site_url" => "https://aokang.tmall.com/",
        "tagid" => 1,
        "tag" => "男鞋",
        "post" => 1,
        "cheap" => 0,
        "wapurl" => ""
      },
      {
        "long_title" => "龙狮戴尔男士轻薄款羽绒服青年短款立领修身韩版",
        "identify" => 520716701268,
        "url" => "https://detail.tmall.com/item.htm?spm=a1z10.1-b.w8378040-12295436372.7.YDw3mX&id=520716701268&rn=3fc1c839641b5ab9b6222c7163ec2a4a&abbucket=18&sku_properties=-1:-1",
        "img_url" => "http://7xioz9.com2.z0.glb.qiniucdn.com/20151010175947/dbb8a1f7894e25a43252c707f2.jpg",
        "price" => 169,
        "site" => "lonsdale旗舰店",
        "site_url" => "https://lonsdale.tmall.com/",
        "tagid" => 4,
        "tag" => "男装",
        "post" => 1,
        "cheap" => 0,
        "wapurl" => ""
      },
      {
        "long_title" => "龙狮戴尔男士轻薄便携连帽羽绒服男男式短款修身外套",
        "identify" => 520858028539,
        "url" => "https://detail.tmall.com/item.htm?spm=a1z10.1-b.w8378040-12296204597.7.YDw3mX&id=520858028539&abbucket=_AB-M32_B18&acm=03054.1003.1.291757&aldid=OzYoPWIp&abtest=_AB-LR32-PR32&scm=1003.1.03054.13_520858028539_291757&pos=3&sku_properties=-1:-1",
        "img_url" => "http://7xioz9.com2.z0.glb.qiniucdn.com/20151010180027/3d95be986b690fa2b7c6cca7bd.jpg",
        "price" => 199,
        "site" => "lonsdale旗舰店",
        "site_url" => "https://lonsdale.tmall.com/",
        "tagid" => 4,
        "tag" => "男装",
        "post" => 1,
        "cheap" => 0,
        "wapurl" => ""
      },
      {
        "long_title" => "lonsdale龙狮戴尔男士羽绒服反季冬装新款加厚羽绒",
        "identify" => 521109147139,
        "url" => "https://detail.tmall.com/item.htm?spm=a1z10.1-b.w8378040-12296234538.8.mkWrCb&id=521109147139&rn=5635783dda63d6a3771d6158bc975451&abbucket=18",
        "img_url" => "http://7xioz9.com2.z0.glb.qiniucdn.com/20151010180108/35e6d2130ee64f5050ce6843bc.jpg",
        "price" => 299,
        "site" => "lonsdale旗舰店",
        "site_url" => "https://lonsdale.tmall.com/",
        "tagid" => 4,
        "tag" => "男装",
        "post" => 1,
        "cheap" => 0,
        "wapurl" => ""
      },
      {
        "long_title" => "龙狮戴尔反季轻薄羽绒服女短款韩版",
        "identify" => 520720412818,
        "url" => "https://detail.tmall.com/item.htm?spm=a1z10.1-b.w8378040-12295421952.7.mkWrCb&id=520720412818&abbucket=_AB-M32_B13&acm=03054.1003.1.291757&aldid=nnKAJZvy&abtest=_AB-LR32-PR32&scm=1003.1.03054.13_520720412818_291757&pos=1&sku_properties=-1:-1",
        "img_url" => "http://7xioz9.com2.z0.glb.qiniucdn.com/20151010180146/e4aaa5b14c0ca1bdb4e39c5b83.jpg",
        "price" => 159,
        "site" => "lonsdale旗舰店",
        "site_url" => "https://lonsdale.tmall.com/",
        "tagid" => 5,
        "tag" => "女装",
        "post" => 1,
        "cheap" => 0,
        "wapurl" => ""
      },
      {
        "long_title" => "龙狮戴尔短款轻薄羽绒服女装大码",
        "identify" => 520848106859,
        "url" => "https://detail.tmall.com/item.htm?spm=a1z10.1-b.w8378040-12296108220.9.mkWrCb&id=520848106859&rn=3fc1c839641b5ab9b6222c7163ec2a4a&abbucket=18&sku_properties=-1:-1",
        "img_url" => "http://7xioz9.com2.z0.glb.qiniucdn.com/20151010180221/c202b98dadba7ccbceeb240203.jpg",
        "price" => 199,
        "site" => "lonsdale旗舰店",
        "site_url" => "https://lonsdale.tmall.com/",
        "tagid" => 5,
        "tag" => "女装",
        "post" => 1,
        "cheap" => 0,
        "wapurl" => ""
      },
      {
        "long_title" => "水星家纺 单双人立体羽绒被",
        "identify" => 39246290623,
        "url" => "https://detail.tmall.com/item.htm?spm=a1z10.4-b.w5003-8286239609.27.k0iO6f&id=39246290623&rn=d2fcf56a4e8d80420275fe1de1ef2bc0&abbucket=0&skuId=68882696881&scene=taobao_shop",
        "img_url" => "http://7xioz9.com2.z0.glb.qiniucdn.com/20151010180339/dab77f0772fb2128c80cfb1193.jpg",
        "price" => 699,
        "site" => "水星家纺旗舰店",
        "site_url" => "https://shuixing.tmall.com",
        "tagid" => 14,
        "tag" => "家居",
        "post" => 1,
        "cheap" => 0,
        "wapurl" => ""
      },
      {
        "long_title" => "水星家纺 纯棉四件套",
        "identify" => 18065707931,
        "url" => "https://detail.tmall.com/item.htm?spm=a1z10.5-b.w4011-3014592695.107.xb1w5b&id=18065707931&rn=b68aac9ce15990cc2b205aaae868b558&abbucket=3",
        "img_url" => "http://7xioz9.com2.z0.glb.qiniucdn.com/20151010180418/0e03c1a08f7e25620057ef8025.jpg",
        "price" => 428,
        "site" => "水星家纺旗舰店",
        "site_url" => "https://shuixing.tmall.com",
        "tagid" => 14,
        "tag" => "家居",
        "post" => 1,
        "cheap" => 0,
        "wapurl" => ""
      },
      {
        "long_title" => "水星家纺 全棉磨毛印花四件套",
        "identify" => 521893814648,
        "url" => "https://detail.tmall.com/item.htm?spm=a1z10.4-b.w5003-12275390843.5.3RoJZj&id=521893814648&scene=taobao_shop&sku_properties=1627207:3232483",
        "img_url" => "http://7xioz9.com2.z0.glb.qiniucdn.com/20151010180453/c8582aa33b452bab2271e024a0.jpg",
        "price" => 659,
        "site" => "水星家纺旗舰店",
        "site_url" => "https://shuixing.tmall.com",
        "tagid" => 14,
        "tag" => "家居",
        "post" => 1,
        "cheap" => 0,
        "wapurl" => ""
      },
      {
        "long_title" => "水星家纺正品婚庆大红四件套",
        "identify" => 18976475122,
        "url" => "https://detail.tmall.com/item.htm?spm=a1z10.4-b.w5003-11633088356.5.0lheOH&id=18976475122&rn=886c1c0fd25d3985fc977e7bb320bcdc&abbucket=0&sku_properties=1627207:28326&scene=taobao_shop",
        "img_url" => "http://7xioz9.com2.z0.glb.qiniucdn.com/20151010180528/3bd40845cd6d261b03b148a70e.jpg",
        "price" => 698,
        "site" => "水星家纺旗舰店",
        "site_url" => "https://shuixing.tmall.com",
        "tagid" => 14,
        "tag" => "家居",
        "post" => 1,
        "cheap" => 0,
        "wapurl" => ""
      },
      {
        "long_title" => "水星家纺 枕头 超柔软枕心 压不扁枕头",
        "identify" => 2223557169,
        "url" => "https://detail.tmall.com/item.htm?spm=a1z10.5-b.w4011-3014592695.119.CYh9tf&id=2223557169&rn=34564cc295f81e65f05cfd2cc3068a65&abbucket=3",
        "img_url" => "http://7xioz9.com2.z0.glb.qiniucdn.com/20151010180610/ae2d28e50b9c2fd80b57dbf700.jpg",
        "price" => 108,
        "site" => "水星家纺旗舰店",
        "site_url" => "https://shuixing.tmall.com",
        "tagid" => 14,
        "tag" => "家居",
        "post" => 0,
        "cheap" => 0,
        "wapurl" => ""
      },
      {
        "long_title" => "2015冬季新款绵羊皮真皮皮衣",
        "identify" => 522768166507,
        "url" => "https://detail.tmall.com/item.htm?spm=a1z10.4-b.w9924446-12305355293.33.KmFxq7&id=522768166507&scene=taobao_shop&sku_properties=-1:-1",
        "img_url" => "http://7xioz9.com2.z0.glb.qiniucdn.com/20151010180655/a10ca5963b9a36441df3de4c8f.jpg",
        "price" => 1699,
        "site" => "咔琦娜服饰旗舰店",
        "site_url" => "https://kaqina.tmall.com",
        "tagid" => 5,
        "tag" => "女装",
        "post" => 1,
        "cheap" => 0,
        "wapurl" => ""
      },
      {
        "long_title" => "新款2015海宁皮草女士 整皮兔毛皮草外套",
        "identify" => 45917196038,
        "url" => "https://detail.tmall.com/item.htm?spm=a1z10.3-b.w4011-10553449629.96.5VULiu&id=45917196038&rn=ad7e7307806e0153dd7928b7c2399a50&abbucket=3&sku_properties=-1:-1",
        "img_url" => "http://7xioz9.com2.z0.glb.qiniucdn.com/20151010180734/cbe9487bf458036b4b984e8708.jpg",
        "price" => 398,
        "site" => "咔琦娜服饰旗舰店",
        "site_url" => "https://kaqina.tmall.com",
        "tagid" => 5,
        "tag" => "女装",
        "post" => 1,
        "cheap" => 0,
        "wapurl" => ""
      },
      {
        "long_title" => "2015新款冬季海宁 獭兔毛皮草外套女 ",
        "identify" => 40674054981,
        "url" => "https://detail.tmall.com/item.htm?spm=a1z10.3-b.w4011-10553449629.116.5VULiu&id=40674054981&rn=ad7e7307806e0153dd7928b7c2399a50&abbucket=3",
        "img_url" => "http://7xioz9.com2.z0.glb.qiniucdn.com/20151010180815/15b2f3fddaf3ef3965134334af.jpg",
        "price" => 599,
        "site" => "咔琦娜服饰旗舰店",
        "site_url" => "https://kaqina.tmall.com",
        "tagid" => 5,
        "tag" => "女装",
        "post" => 1,
        "cheap" => 0,
        "wapurl" => ""
      },
      {
        "long_title" => "2015冬海宁修身狐狸毛领大衣 ",
        "identify" => 40991292600,
        "url" => "https://detail.tmall.com/item.htm?spm=a1z10.3-b.w4011-10553449629.141.5VULiu&id=40991292600&rn=ad7e7307806e0153dd7928b7c2399a50&abbucket=3",
        "img_url" => "http://7xioz9.com2.z0.glb.qiniucdn.com/20151010180852/6076ef6a8baced1011a3e34eff.jpg",
        "price" => 1499,
        "site" => "咔琦娜服饰旗舰店",
        "site_url" => "https://kaqina.tmall.com",
        "tagid" => 5,
        "tag" => "女装",
        "post" => 1,
        "cheap" => 0,
        "wapurl" => ""
      },
      {
        "long_title" => "2015新款女士真皮羽绒服中长款",
        "identify" => 522773320094,
        "url" => "https://detail.tmall.com/item.htm?spm=a1z10.4-b.w9924446-12305355293.36.3qcNMK&id=522773320094&scene=taobao_shop&sku_properties=-1:-1",
        "img_url" => "http://7xioz9.com2.z0.glb.qiniucdn.com/20151010180927/9670aacc9e7cad962629e9a323.jpg",
        "price" => 1688,
        "site" => "咔琦娜服饰旗舰店",
        "site_url" => "https://kaqina.tmall.com",
        "tagid" => 5,
        "tag" => "女装",
        "post" => 1,
        "cheap" => 0,
        "wapurl" => ""
      },
      {
        "long_title" => "米缇贝蒂2015秋冬新款贝壳包",
        "identify" => 520056124252,
        "url" => "https://detail.tmall.com/item.htm?spm=a1z10.4-b.w5003-11294888168.1.8Fvk9s&id=520056124252&scene=taobao_shop",
        "img_url" => "http://7xioz9.com2.z0.glb.qiniucdn.com/20151010181056/b14c4dde4a2accea7ffe907c6e.jpg",
        "price" => 249,
        "site" => "米缇贝蒂箱包旗舰店",
        "site_url" => "https://mitibeidi.tmall.com",
        "tagid" => 18,
        "tag" => "女包",
        "post" => 1,
        "cheap" => 0,
        "wapurl" => ""
      },
      {
        "long_title" => "米缇贝蒂2015潮新款女士长款钱夹",
        "identify" => 36874358290,
        "url" => "https://detail.tmall.com/item.htm?spm=a1z10.3-b.w4011-2649391037.81.rYm4eg&id=36874358290&rn=4e13583a50714de71d3cadd8c281fb09&abbucket=3",
        "img_url" => "http://7xioz9.com2.z0.glb.qiniucdn.com/20151010181129/d7ae0f1307ed64eb9511051d35.jpg",
        "price" => 139,
        "site" => "米缇贝蒂箱包旗舰店",
        "site_url" => "https://mitibeidi.tmall.com",
        "tagid" => 18,
        "tag" => "女包",
        "post" => 1,
        "cheap" => 0,
        "wapurl" => ""
      },
      {
        "long_title" => "米缇贝蒂三件套子母包 欧美潮女士包包",
        "identify" => 21297799474,
        "url" => "https://detail.tmall.com/item.htm?spm=a1z10.1-b.w5003-11424715848.9.LW9pof&id=21297799474&rn=e1e266c9c696f7fc7ceee3335b96c265&abbucket=3&scene=taobao_shop",
        "img_url" => "http://7xioz9.com2.z0.glb.qiniucdn.com/20151010181215/8d025af3c59f36b820ead129dd.jpg",
        "price" => 209,
        "site" => "米缇贝蒂箱包旗舰店",
        "site_url" => "https://mitibeidi.tmall.com",
        "tagid" => 18,
        "tag" => "女包",
        "post" => 1,
        "cheap" => 0,
        "wapurl" => ""
      },
      {
        "long_title" => "米缇贝蒂2015女士包包",
        "identify" => 26950944811,
        "url" => "https://detail.tmall.com/item.htm?spm=a1z10.3-b.w4011-2649391037.81.gyQ1H6&id=26950944811&rn=961474f2b221507d614a0410dad3c83e&abbucket=3",
        "img_url" => "http://7xioz9.com2.z0.glb.qiniucdn.com/20151010181249/a3597c0cafd87e2ec354b704b0.jpg",
        "price" => 199,
        "site" => "米缇贝蒂箱包旗舰店",
        "site_url" => "https://mitibeidi.tmall.com",
        "tagid" => 18,
        "tag" => "女包",
        "post" => 1,
        "cheap" => 0,
        "wapurl" => ""
      },
      {
        "long_title" => "米缇贝蒂2015双肩包女背包",
        "identify" => 39451910569,
        "url" => "https://detail.tmall.com/item.htm?spm=a1z10.3-b.w4011-2649391037.101.gyQ1H6&id=39451910569&rn=961474f2b221507d614a0410dad3c83e&abbucket=3",
        "img_url" => "http://7xioz9.com2.z0.glb.qiniucdn.com/20151010181326/fc069a94990b480544949d47f4.jpg",
        "price" => 199,
        "site" => "米缇贝蒂箱包旗舰店",
        "site_url" => "https://mitibeidi.tmall.com",
        "tagid" => 18,
        "tag" => "女包",
        "post" => 1,
        "cheap" => 0,
        "wapurl" => ""
      },
      {
        "long_title" => "米莱达 2015秋冬新品 女装新款长袖羊毛呢子外套",
        "identify" => 520401583868,
        "url" => "https://detail.tmall.com/item.htm?spm=a1z10.1-b.w5003-12325726380.2.jVWqFf&id=520401583868&scene=taobao_shop",
        "img_url" => "http://7xioz9.com2.z0.glb.qiniucdn.com/20151010181413/d3d2327d2081acc18f92c4a2bc.jpg",
        "price" => 379,
        "site" => "米莱达旗舰店",
        "site_url" => "https://meetlady.tmall.com",
        "tagid" => 5,
        "tag" => "女装",
        "post" => 1,
        "cheap" => 0,
        "wapurl" => ""
      },
      {
        "long_title" => "米莱达 2015秋冬新款 欧美简约抽象提花中长款圆领毛衣",
        "identify" => 522041321833,
        "url" => "https://detail.tmall.com/item.htm?spm=a1z10.4-b.w5003-11183327948.4.4cJ9px&id=522041321833&rn=42c5f56756a150d8a5dbf82af9040efc&abbucket=4&scene=taobao_shop",
        "img_url" => "http://7xioz9.com2.z0.glb.qiniucdn.com/20151010181501/0792bbefa6079bf02c2b1c20f5.jpg",
        "price" => 189,
        "site" => "米莱达旗舰店",
        "site_url" => "https://meetlady.tmall.com",
        "tagid" => 5,
        "tag" => "女装",
        "post" => 1,
        "cheap" => 0,
        "wapurl" => ""
      },
      {
        "long_title" => "米莱达 2015秋装新品 系带九分袖长款外套 纯色长袖风衣",
        "identify" => 520266357586,
        "url" => "https://detail.tmall.com/item.htm?id=520266357586&spm=a1z10.4-b.w5003-11183327948.10.4cJ9px&scene=taobao_shop",
        "img_url" => "http://7xioz9.com2.z0.glb.qiniucdn.com/20151010181539/19f2916fd67362b5c438ca0a77.jpg",
        "price" => 239,
        "site" => "米莱达旗舰店",
        "site_url" => "https://meetlady.tmall.com",
        "tagid" => 5,
        "tag" => "女装",
        "post" => 1,
        "cheap" => 0,
        "wapurl" => ""
      },
      {
        "long_title" => "米莱达 2015秋冬新款女装 斑马纹印花外套 欧美范棉衣",
        "identify" => 521077373708,
        "url" => "https://detail.tmall.com/item.htm?id=521077373708&spm=a1z10.4-b.w5003-11183327948.13.4cJ9px&scene=taobao_shop",
        "img_url" => "http://7xioz9.com2.z0.glb.qiniucdn.com/20151010181614/bd371f30ea892493329d581b28.jpg",
        "price" => 279,
        "site" => "米莱达旗舰店",
        "site_url" => "https://meetlady.tmall.com",
        "tagid" => 5,
        "tag" => "女装",
        "post" => 1,
        "cheap" => 0,
        "wapurl" => ""
      },
      {
        "long_title" => "米莱达 2015秋冬新品欧美时尚纯色大翻领双排扣毛呢外套",
        "identify" => 522836372222,
        "url" => "https://detail.tmall.com/item.htm?spm=a1z10.4-b.w5003-10989924540.9.ra087L&id=522836372222&scene=taobao_shop",
        "img_url" => "http://7xioz9.com2.z0.glb.qiniucdn.com/20151010181651/c86844738ae84e6464056a7d05.jpg",
        "price" => 319,
        "site" => "米莱达旗舰店",
        "site_url" => "https://meetlady.tmall.com",
        "tagid" => 5,
        "tag" => "女装",
        "post" => 1,
        "cheap" => 0,
        "wapurl" => ""
      },
      {
        "long_title" => "POLO男士手提包横款商务男包真皮公文包",
        "identify" => 44734243604,
        "url" => "https://detail.tmall.com/item.htm?spm=a1z10.1-b.w9942667-8520848910.2.XGY1rr&id=44734243604&scene=taobao_shop",
        "img_url" => "http://7xioz9.com2.z0.glb.qiniucdn.com/20151010181739/b03742495e3218f082bf066ee0.jpg",
        "price" => 489,
        "site" => "polo箱包旗舰店",
        "site_url" => "https://poloxb.tmall.com",
        "tagid" => 17,
        "tag" => "男包",
        "post" => 1,
        "cheap" => 0,
        "wapurl" => ""
      },
      {
        "long_title" => "Polo男士手包软皮商务大容量手拿包男包长款钱包",
        "identify" => 20806715442,
        "url" => "https://detail.tmall.com/item.htm?spm=a1z10.1-b.w9942667-8520848910.1.XGY1rr&id=20806715442&scene=taobao_shop",
        "img_url" => "http://7xioz9.com2.z0.glb.qiniucdn.com/20151010181814/2a294ef5c68628a8d9f5b92bc0.jpg",
        "price" => 239,
        "site" => "polo箱包旗舰店",
        "site_url" => "https://poloxb.tmall.com",
        "tagid" => 17,
        "tag" => "男包",
        "post" => 1,
        "cheap" => 0,
        "wapurl" => ""
      },
      {
        "long_title" => "POLO真皮男包手提包横款 商务男包公文包",
        "identify" => 43986623025,
        "url" => "https://detail.tmall.com/item.htm?spm=a1z10.1-b.w9942667-9851762891.30.XGY1rr&id=43986623025&scene=taobao_shop",
        "img_url" => "http://7xioz9.com2.z0.glb.qiniucdn.com/20151010181857/32b1c2aa3de5e0750177c49be3.jpg",
        "price" => 1399,
        "site" => "polo箱包旗舰店",
        "site_url" => "https://poloxb.tmall.com",
        "tagid" => 17,
        "tag" => "男包",
        "post" => 1,
        "cheap" => 0,
        "wapurl" => ""
      },
      {
        "long_title" => "POLO商务男包单肩包竖款真皮斜挎包",
        "identify" => 521099808317,
        "url" => "https://detail.tmall.com/item.htm?spm=a1z10.1-b.w9942667-9851762891.39.XGY1rr&id=521099808317&scene=taobao_shop",
        "img_url" => "http://7xioz9.com2.z0.glb.qiniucdn.com/20151010181927/0e2d2d0fe7be7d73f5526e3b55.jpg",
        "price" => 269,
        "site" => "polo箱包旗舰店",
        "site_url" => "https://poloxb.tmall.com",
        "tagid" => 17,
        "tag" => "男包",
        "post" => 1,
        "cheap" => 0,
        "wapurl" => ""
      },
      {
        "long_title" => "POLO男士手包2015新款长款多卡位休闲时尚手拿包",
        "identify" => 40362656500,
        "url" => "https://detail.tmall.com/item.htm?spm=a1z10.1-b.w9942667-9851762891.64.XGY1rr&id=40362656500&scene=taobao_shop",
        "img_url" => "http://7xioz9.com2.z0.glb.qiniucdn.com/20151010181956/fca23aeaaebb8eec46f30f47ca.jpg",
        "price" => 139,
        "site" => "polo箱包旗舰店",
        "site_url" => "https://poloxb.tmall.com",
        "tagid" => 17,
        "tag" => "男包",
        "post" => 1,
        "cheap" => 0,
        "wapurl" => ""
      }

    ]

    if type === 'all' && tagid.to_i === 0
      return json
    end


    tagJson = []

    if tagid.to_i > 0
      json.each do |j|
        if j["tagid"] == tagid.to_i
          tagJson.push j
        end
      end
      return tagJson
    else
      map = {
        "xiexue" => [1, 2, 3],
        "fuzhuang" => [4, 5, 6, 7],
        "meizhuang" => [8, 9],
        "shipin" => [10 ,11],
        "muying" => [12, 13],
        "jiaju" => [14, 15, 16],
        "xiangbao" => [17 ,18, 19]
      }

      if !map[type].equal?(nil)
        json.each do |j|
          if map[type].include?(j["tagid"])
            tagJson.push j
          end
        end
        return tagJson
      end
    end




  end



end



