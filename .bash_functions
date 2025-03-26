#!/bin/sh

#Find string in files
fstr() {
    grep -Rnw "." -e "$1"
}
#----------------------------#

#Sudo last command
#sudo !!

#----------------------------#

#Sudo last command
s() { # do sudo, or sudo the last command if no argument given
    if [[ $# == 0 ]]; then
        sudo $(history -p '!!')
    else
        sudo "$@"
    fi
}

#----------------------------#


# Easy extract
function extract {
  if [ $# -eq 0 ]; then
    echo "Usage: extract <file1.ext> [file2.ext] ..."
    return 1
  fi

  for n in "$@"; do
    if [ ! -f "$n" ]; then
      echo "Error: '$n' - file does not exist"
      continue
    fi

    # Create an extraction directory
    outdir="${n%.*}"
    mkdir -p "$outdir"

    case "${n}" in
      *.tar.bz2|*.tar.gz|*.tar.xz|*.tbz2|*.tgz|*.txz|*.tar) tar --auto-compress -xvf "$n" -C "$outdir" ;;
      *.lzma) unlzma "$n" -C "$outdir" ;;
      *.bz2) bunzip2 "$n" -c > "$outdir/${n%.bz2}" ;;
      *.cbr|*.rar) unrar x "$n" "$outdir" ;;
      *.gz) gunzip -c "$n" > "$outdir/${n%.gz}" ;;
      *.cbz|*.epub|*.zip) unzip -d "$outdir" "$n" ;;
      *.z) uncompress -c "$n" > "$outdir/${n%.z}" ;;
      *.7z|*.apk|*.arj|*.cab|*.cb7|*.chm|*.deb|*.iso|*.lzh|*.msi|*.pkg|*.rpm|*.udf|*.wim|*.xar|*.vhd) 7z x "$n" -o"$outdir" ;;
      *.xz) unxz "$n" -C "$outdir" ;;
      *.exe) cabextract "$n" -d "$outdir" ;;
      *.cpio) cpio -id < "$n" -D "$outdir" ;;
      *.cba|*.ace) unace x "$n" -o"$outdir" ;;
      *.zpaq) zpaq x "$n" -to "$outdir" ;;
      *.arc) arc e "$n" -o"$outdir" ;;
      *.cso)
        if ciso 0 "$n" "$n.iso"; then
          extract "$n.iso" && rm -f "$n"
        else
          echo "Error: ciso failed for $n"
        fi
        ;;
      *.zlib)
        if zlib-flate -uncompress < "$n" > "$outdir/${n%.*zlib}"; then
          rm -f "$n"
        else
          echo "Error: zlib-flate failed for $n"
        fi
        ;;
      *.dmg)
        if command -v hdiutil >/dev/null; then
          hdiutil mount "$n" -mountpoint "$outdir"
        else
          echo "Error: hdiutil (macOS) not found"
        fi
        ;;
      *.tar.zst) tar --use-compress-program=zstd -xvf "$n" -C "$outdir" ;;
      *.zst) zstd -d "$n" -o "$outdir/${n%.zst}" ;;
      *.lz4) lz4 -d "$n" "$outdir/${n%.lz4}" ;;
      *.img.gz) gunzip -c "$n" > "$outdir/${n%.gz}" ;;
      *)
        echo "Error: '$n' - unknown archive format"
        ;;
    esac
  done
}


#----------------------------#

