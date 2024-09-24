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

       -- 50個の花を配置
       for i = 1, 5000 do
           -- ランダムな方向と距離を指定して目標位置を決定
           local offset = {
               x = math.random(-30, 30),
               y = math.random(-3, 5),
               z = math.random(-30, 30)
           }
           local flower_pos = vector.add(target_pos, offset)
	   local flower_floor = vector.add(flower_pos, {x = 0, y = -1, z = 0 })
	   minetest.log(minetest.get_node(flower_floor).name)

           -- 目標位置の床が空気ではなく、かつ目標位置が空気の場合、花を設置する。
           if minetest.get_node(flower_floor).name ~= "air" then
	      if minetest.get_node(flower_pos).name == "air" then
		 -- 薔薇を設置
		 minetest.set_node(flower_pos, {name = "flowers:flower_rose"})
	      end
	   end
       end

       return true, "done!!"
    end
})
