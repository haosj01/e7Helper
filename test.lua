
test = function ()
  current_task = uiConfigUnion(fileNames)
  -- path.游戏开始()
  -- path.成就领取()
  -- path.免费领养宠物()
  -- path.宠物礼盒()
  -- path.收取邮件()
  -- path.刷书签()
  -- path.竞技场()
  -- path.圣域()
  -- path.圣域指挥总部()
  -- sui.show()
  -- path.圣域指挥总部()
  -- path.游戏开始()
  -- log(findOne('ocr_国服战斗开始'))
  -- log(findOne('ocr_国服战斗开始', {keyword = '战斗开始'}))
  -- path.通用刷图模式1('mul_国服双足飞龙', '1', 2)
  -- log(findOne({'mul_国服神秘商店神秘奖牌', 'mul_国服神秘商店誓约书签', 'mul_国服神秘商店友情书签'}, {rg = {538,50,677,720}}))
  -- print(current_task)
  -- log(findOne('cmp_国服邮件领取确认蓝底'))
  -- log(findOne('cmp_国服背包装备自动选择'))
  -- path.清理英雄背包()
  -- path.清理装备背包()
  -- path.清理神器背包()
  local key = {'英雄', '装备', '神器'}
  log(findOne('ocr_国服右下角'))
  exitScript()
end
if not disable_test then test() end