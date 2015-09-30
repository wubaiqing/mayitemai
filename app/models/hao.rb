# coding: utf-8

# 商品
class Hao

  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::BaseModel

  # 必填
  validates :taobao_id, :taobao_url, :title, :original_price, :price, :picture_url, :sort, :brand_id, :cate_id, presence: true

  # 唯一
  validates :taobao_id, uniqueness: true

  # 淘宝ID
  field :taobao_id, type: Integer

  # 淘宝URL
  field :taobao_url

  # 标题
  field :title

  # 原价
  field :original_price

  # 现价
  field :price

  # 图片URL
  field :picture_url

  # 排序
  field :sort, type: Integer, default: 0

  # 专题ID
  field :brand_id, type: Integer

  # 分类ID
  field :cate_id, type: Integer, default: 0

  # 状态
  field :state, type: Integer, default: 1

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

  # 根据旺旺名称查询
  def self.find_by_wangwang(wangwang)
    ids = Brand.where(wangwang: /#{wangwang}/).pluck(:id)
    where(:brand_id.in => ids)
  end

  # 根据淘宝ID查询
  def self.find_by_taobao_id(taobao_id)
    where(taobao_id: taobao_id)
  end

  # 得到集合
  def self.good_collection(id, wangwang)
    Rails.cache.fetch("good:good_collection:#{id}:#{CacheVersion.good_node_updated_at}") do
      self.where(brand_id: id).where(state: 1).desc(:sort).desc(:id).all
    end
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
        "price" => "379",
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
        "price" => "658",
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
        "price" => "168",
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
        "price" => "148",
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
        "price" => "199",
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
        "price" => "259",
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
        "price" => "399",
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
        "price" => "179",
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
        "price" => "259",
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
        "price" => "99",
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
        "price" => "158",
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
        "price" => "99",
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
        "price" => "99",
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
        "price" => "89",
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
        "price" => "99",
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
        "price" => "439",
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
        "price" => "49",
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
        "price" => "126",
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
        "price" => "368.5",
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
        "price" => "129",
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
        "price" => "158",
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
        "price" => "439",
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
        "price" => "79.9",
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
        "price" => "278",
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
        "price" => "99",
        "cheap" => "",
        "site" => "牧童官方旗舰店",
        "site_url" => "https://herd.tmall.com",
        "tagid" => 3,
        "tag" => "童鞋",
        "post" => 0
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

