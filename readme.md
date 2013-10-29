### 6軸の加速度ジャイロの値からGoogle Earthに変換する
慣性計測装置からGoogle Earthに出力するためのスクリプト
機体座標と地平座標の変換を行なっている。
**matlab互換のoctaveで動作確認**

+ 計測値、クォータニオン、オイラー角、速度、位置のグラフ
+ 加速度ジャイロの計測値から擬似的なGPSデータを生成してGoogle Earthで読める形式で出力

### 使い方
octaveを開いて、6DoF2Mapのディレクトリで
```matlab
> main
```
とすると実行される。

###　設定
main.mファイルの中身で設定を行う。

SHOW_PLOT = 0;
OUTPUT_GPS = 1;
という部分が出力設定。
SHOW_PLOTはグラフ出力、OUTPUT_GPSはGoogle Earth用の.nmeaファイル出力。
0で出力しない、1で出力

### クォータニオン
Octaveでクォータニオンを使うときはpackageがあるのでそれを使うのが望ましい。
理解のためと他の言語で記述する必要があったために自分でクォータニオンの演算を実装している。

[Octave-Forge Quaternion Package](http://octave.sourceforge.net/quaternion/)

### 参考
[Wikipedia - Conversion between quaternions and Euler angles](http://en.wikipedia.org/wiki/Conversion_between_quaternions_and_Euler_angles)