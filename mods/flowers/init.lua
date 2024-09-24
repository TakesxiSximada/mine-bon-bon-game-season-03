minetest.register_node("flowers:flower_rose", {
   description = "rose",
   drawtype = "plantlike",
   waving = 1,
   tiles = {"flowers_rose.png"},
   inventory_image = "flowers_rose.png",
   wield_image = "flowers_rose.png",
   sunlight_propagates = true,
   paramtype = "light",
   walkable = false,
   buildable_to = true,
   groups = {
      attached_node = 1,
      color_red = 1,
      flammable = 1,
      flora = 1,
      flower = 1,
      snappy = 3
   },
   selection_box = {
       type = "fixed",
       fixed = {
          -2 / 16,
          -0.5,
          -2 / 16,
          2 / 16,
          5 / 16,
          2 / 16
       }
   }
})

minetest.register_chatcommand("flower", {
    func = function(name, param)
       minetest.log("flower")
       local player = minetest.get_player_by_name(name)
       if not player then
	  return false, "Player not found."
       end

       local pos = player:get_pos()  -- プレイヤーの座標を取得
       local dir = player:get_look_dir() -- プレイヤーの見ている方向を取得
       local target_pos = vector.add(pos, vector.round(dir))  -- プレイヤーの正面1ブロックの座標を特定

       -- 目標位置が空気か確認
       if minetest.get_node(target_pos).name ~= "air" then
           return false, "The specified location is not air."
       end

       -- 薔薇を設置
       minetest.set_node(target_pos, {name = "flowers:flower_rose"})
       return true, "Okay"
    end
})
