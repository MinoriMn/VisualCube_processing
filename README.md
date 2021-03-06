# VisualCube
この作品はProcessingにて起動することができます。

## 目標

今回は、Processing の機能でもPShader とPGraphics およびフラグメントシェーダを利用した高速レンダリングに興味があったため、それらの機能を利用した簡単なメディアアート的アニメーション表示に挑戦した。

## プログラムの内容

プログラムを起動すると、単にテクスチャマッピングした立方体が表示される。その6 面とも同じテクスチャで構成されている。テクスチャは画面上のマウスの位置(mouseX, mouseY) と実行の時間によって変化を起こす。
テクスチャは具体的に、UEC のロゴ(正方形画像) に波紋を描き加えたものになっている。波紋はマウスの位置より相対的に割り出したテクスチャ(QUADS) の位置を中心とし、テクスチャ上を同心円状に広がって行く。また、波紋の色は一定時間ごとに変わる。
　操作として、左クリックを押しながらマウスを動かすことで立体図形を回転させることが出来る。

## 実装について

実行ファイルはVisualLastwork.pde とRipple.frag で構成されている。VisualLastwork.pde はメインとして立体図形描画の管理を行い、Ripple.frag は面のシェーダとして使われている。
　前者に関しては、特にPShader とPGraphics 以外は今までの授業で学んだことを利用している。特に後者ではPGraphics をそのままフラグメントシェーダのスクリーンとし、生成された情報をテクスチャとして利用できることを学んだ。これにより、複雑な描画処理をGPGPU に依頼する方法を理解出来た。
　また、前者から後者へと情報を譲渡する手筈、PShader.set を用いてuniform 変数に値を設定をし、処理を実装することができた。この波紋ではPGraphics の各ピクセルにおいて、

- 基準点(マウス) からの距離dis
- dis による減衰率extinction
- dis とextinction による波紋の算出wave

といった計算資源を要する処理を実装しているが、それは全てGPGPU で行なっている。結果、複雑な描画命令に構わず安定的で高速な処理を実現している。
## 感想
比較的重い描画処理を組んでみたつもりであるが、GPU は効果的に使うと高速で安定的な描画を実現出来ることを改めて理解できた。今回のインタラクティブ要素としてはマウスのみであるが、調べてみるとカメラやマイクであったり、前出力を入力とした新たな出力(ex. ライフゲーム) が可能であったりと、色々なメディアアートを作成することが可能なようだ。この授業後もProcessingShader は積極的に勉強していきたいと思う。
