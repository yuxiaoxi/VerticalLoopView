Pod::Spec.new do |s|

  s.name         = "VerticalLoopView"
  s.version      = "0.0.1"
  s.summary      = "垂直方向跑马灯 循环滚动 多处高亮显示"
  s.description  = <<-DESC
  垂直方向跑马灯 循环滚动 多处高亮显示
                   DESC
  
  s.homepage     = "https://github.com/yuxiaoxi/VerticalLoopView"
  s.author             = { "yuzhuo" => "yuzhuo@meituan.com" }
  s.source       = { :git => "https://github.com/yuxiaoxi/VerticalLoopView.git", :tag => s.version.to_s }

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files  = "Pod/Classes/**/*.{h,m}"
  s.resources = "Pod/Resources/**/*.{xib,png,ped,jpg,plist}"

end
