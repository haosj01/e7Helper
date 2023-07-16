sui = {}
-- ui事件
suie = {}
parentUid = 'E7Helper'
grindUid = '刷图设置'
bagUid = '背包清理设置'
-- bin: bid、bname
addButton = function (bin, partid)
  partid = partid or parentUid
  ui.addButton(partid, bin, bin)
  ui.setOnClick(bin, 'suie.'..bin..'()')
end
setButton = function (bin, w, h)
  w = w or 100
  h = h or 100
  -- 添加事件函数
  ui.setButton(bin, bin, w, h)
end
newLayout = function (pid)
  pid = pid or parentUid
  ui.newLayout(pid, 720, -2)
end
newRow = function (pid)
  pid = pid or parentUid
  ui.newRow(pid, uuid())
end
addTab = function (pin, pid)
  pid = pid or parentUid
  ui.addTab(pid, pin, pin)
end
addTabView = function (cid)
  ui.addTabView(parentUid,cid)
end
addTextView = function (text, pid)
  pid = pid or parentUid
  ui.addTextView(pid,text,text)
end
addRadioGroup = function (id, data, pid)
  pid = pid or parentUid
  if type(data) ~= 'table' then data = {data} end
  ui.addRadioGroup(pid,id,data,0,-1,70,true)
end
addCheckBox = function (id, selection, pid, defaluValue)
  pid = pid or parentUid
  ui.addCheckBox(pid,id,selection, defaluValue)
end
addEditText = function (id, text, pid)
  pid = pid or parentUid
  ui.addEditText(pid,id,text)
end
saveProfile = function (path)
  ui.saveProfile(root_path..path)  
end
loadProfile = function (path)
  ui.loadProfile(root_path..path)
end
addSpinner = function (id, data, pid)
  pid = pid or parentUid
  data = data or {}
  ui.addSpinner(pid, id ,data)
end
setDisabled = function (id)
  ui.setEnable(id,false)
end
setEnable = function ()
  ui.setEnable(id,true)
end
dismiss = function (id) ui.dismiss(id) end
suie.取消 = exit
suie.启动 = function ()
  suie.开启前()
  if print_config_info then
    print(current_task)
    exit()
  end
  path.游戏开始()
end
suie.开启前 = function ()
  -- 保存配置
  saveProfile('config.txt')
  -- 读取所有文件数据
  current_task = uiConfigUnion(fileNames)
  ui_config_finish = true
  dismiss(parentUid)
end
suie.开始刷书签 = function ()
  suie.开启前()
  path.刷书签(sgetNumberConfig("refresh_book_tag_count", 0))
end
suie.使用说明 = function ()
  runIntent({
    ['action'] = 'android.intent.action.VIEW',
    ['uri'] = open_resource_doc
  })
  exit()
end
suie.刷图设置 = function ()
  sui.showNotMainUI(sui.showGrindSetting)
end
suie.刷新UI = function ()
  for i,v in pairs(fileNames) do sdelfile(v) end
  reScript()
end
suie.刷图配置取消 = function ()
  sui.hiddenNotMainUI(grindUid)
end
suie.刷图配置保存 = function ()
  saveProfile('fightConfig.txt')
  suie.刷图配置取消()
end
suie.清理背包 = function ()
  sui.showNotMainUI(sui.showBagSetting)
end
suie.背包配置取消 = function ()
  sui.hiddenNotMainUI(bagUid)
end
suie.背包配置保存 = function ()
  saveProfile('bagConfig.txt')
  suie.背包配置取消()
end
-- 主页
sui.show = function ()
  newLayout()
  newRow()
  -- 开源信息
  addTextView('此脚本软件完全免费开源\n'..
              '好用就给个star吧-_-, 这是给开发者最大的帮助\n'..
              'QQ群：206490280 \n'..
              'QQ频道号：24oyp5x92q \n'..
              '开源地址：https://gitee.com/boluokk/e7-helper \n'..
              '使用说明书：https://boluokk.gitee.io/e7-helper')
  newRow()
  -- 服务器
  addTextView('服务器: ')
  local servers = ui_option.服务器
  addRadioGroup('服务器', servers)
  newRow()
  -- 日常功能区
  local selections = ui_option.任务
  for i,v in pairs(selections) do
    addCheckBox(v, v)
    if i % 3 == 0 then newRow() end
  end

  -- 需要配置及其他功能区
  newRow()
  addTextView('竞技场:')
  addCheckBox('叶子买票', '叶子买票')
  addTextView('刷新交战次数:')
  addEditText('交战剩余次数', '30')
  newRow()
  addTextView('竞技场每周奖励: ')
  addRadioGroup('竞技场每周奖励', ui_option.竞技场每周奖励)
  -- newRow()
  -- local mission = {'圣域', '探险', '讨伐', '战争'}
  -- addTextView('派遣任务:')
  -- addRadioGroup('派遣任务', mission)
  newRow()
  addTextView('社团捐赠：')
  addRadioGroup('社团捐赠类型', ui_option.社团捐赠类型)
  newRow()
  local tag = ui_option.刷标签类型
  addTextView('刷书签: ')
  for i,v in pairs(tag) do 
    if i == 3 then
      addCheckBox(v, v, nil)
    else 
      addCheckBox(v, v, nil, true)
    end
  end
  newRow()
  addTextView('次数:')
  addEditText('更新次数', '333')
  addButton('开始刷书签')
  newRow()
  addButton('使用说明')
  addTextView('  |  ')
  addButton('启动')
  addButton('取消')
  newRow()
  addButton('刷新UI')
  addTextView('  |  ')
  addButton('刷图设置')
  addButton('定时(未做)')
  newRow()
  addButton('刷初始(未做)')
  addTextView('  |  ')
  addButton('清理背包')
  ui.show(parentUid, false)

  -- load config
  loadProfile('config.txt')
  wait(function ()
    if ui_config_finish then return true end
  end, .05, nil, true)
end
-- 战斗设置
sui.showGrindSetting = function ()
  newLayout(grindUid)
  -- addButton('刷图测试', grindUid)
  local passAll = ui_option.战斗类型
  for i,v in pairs(passAll) do
    -- if i == 1 or i == 3 then
      -- addCheckBox(v, v, grindUid)
    -- else
      addCheckBox(v, v, grindUid)
      -- 暂时禁用
      -- todo
      setDisabled(v)
    -- end
  end
  newRow(grindUid)
  addTextView('补充行动力:', grindUid)
  addRadioGroup('补充行动力类型', ui_option.补充行动力类型, grindUid)
  newRow(grindUid)
  addTextView('讨伐: ', grindUid)
  newRow(grindUid)
  addSpinner('讨伐类型', ui_option.讨伐关卡类型, grindUid)
  addSpinner('讨伐级别', ui_option.讨伐级别, grindUid)
  addTextView('级', grindUid)
  addEditText('讨伐次数', '100', grindUid)
  addTextView('次', grindUid)
  newRow(grindUid)
  addTextView('迷宫：', grindUid)
  newRow(grindUid)
  addTextView('精灵祭坛：', grindUid)
  newRow(grindUid)
  addSpinner('精灵祭坛类型', ui_option.精灵祭坛关卡类型, grindUid)
  addSpinner('精灵祭坛级别', ui_option.精灵祭坛级别, grindUid)
  addTextView('级', grindUid)
  addEditText('精灵祭坛次数', '100', grindUid)
  addTextView('次', grindUid)
  newRow(grindUid)
  addTextView('深渊：', grindUid)
  newRow(grindUid)
  addButton('刷图配置保存', grindUid)
  addButton('刷图配置取消', grindUid)
  ui.show(grindUid, false)
  loadProfile('fightConfig.txt')
end
sui.showNotMainUI = function (fun)
  dismiss(parentUid)
  fun()
end
sui.hiddenNotMainUI = function (hiddenID)
  dismiss(hiddenID)
  sui.show()
end
-- 背包清理
sui.showBagSetting = function ()
  newLayout(bagUid)
  newRow(bagUid)
  addTextView('宠物背包', bagUid)
  newRow(bagUid)
  for i,v in pairs(ui_option.宠物级别) do
    addCheckBox(v, v, bagUid)
  end
  newRow(bagUid)
  addTextView('装备背包', bagUid)
  newRow(bagUid)
  for i,v in pairs(ui_option.装备类型) do
    addCheckBox(v, v, bagUid)
  end
  newRow(bagUid)
  for i,v in pairs(ui_option.装备等级) do
    addCheckBox(v, v, bagUid)
    if i % 4 == 0 then
      newRow(bagUid)
    end
  end
  newRow(bagUid)
  for i,v in pairs(ui_option.装备强化等级) do
    addCheckBox(v, v, bagUid)
    if i % 4 == 0 then
      newRow(bagUid)
    end
  end
  newRow(bagUid)
  addTextView('神器背包', bagUid)
  newRow(bagUid)
  for i,v in pairs(ui_option.神器星级) do 
    addCheckBox(v, v, bagUid)
    if i % 7 == 0 then
      newRow(bagUid)
    end
  end
  newRow(bagUid)
  for i,v in pairs(ui_option.神器强化) do
    addCheckBox(v, v, bagUid)
    if i % 4 == 0 then
      newRow(bagUid)
    end
  end
  newRow(bagUid)
  addTextView('英雄等级', bagUid)
  newRow(bagUid)
  for i,v in pairs(ui_option.英雄等级) do 
    addCheckBox(v, v, bagUid)
    if i % 7 == 0 then
      newRow(bagUid)
    end
  end
  newRow(bagUid)
  addButton('背包配置保存', bagUid)
  addButton('背包配置取消', bagUid)
  ui.show(bagUid, false)
  loadProfile('bagConfig.txt')
end