import { defineConfig } from 'vite'
import vue from '@vitejs/plugin-vue'

//按需引入element
import AutoImport from 'unplugin-auto-import/vite'
import Components from 'unplugin-vue-components/vite'
import { ElementPlusResolver } from 'unplugin-vue-components/resolvers'


export default defineConfig({
  plugins: [
    vue(),

    //按需引入element
    AutoImport({
      resolvers: [ElementPlusResolver()],
    }),
    Components({
      resolvers: [ElementPlusResolver()],
    }),
  ],

  //网络服务
  server: {
    host: '0.0.0.0'
  },
})