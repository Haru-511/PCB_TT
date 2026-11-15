JAR=~/.local/share/kicad/10.0/3rdparty/plugins/app_freerouting_kicad-plugin/jar/freerouting-2.5.0.jar
mkdir -p /tmp/fr_patch_all && cd /tmp/fr_patch_all
jar xf "$JAR" app/freerouting/gui/windows/routing/

python3 -c '
import glob, struct
old_val = struct.pack(">d", 9.9)
new_val = struct.pack(">d", 10000.0)
for path in glob.glob("app/freerouting/gui/windows/routing/WindowAutorouteParameter*.class"):
    data = open(path, "rb").read()
    if old_val in data:
        open(path, "wb").write(data.replace(old_val, new_val))
        print("Parcheado:", path)
'

jar uf "$JAR" app/freerouting/gui/windows/routing/WindowAutorouteParameter*.class
cd - && rm -rf /tmp/fr_patch_all

