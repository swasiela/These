# Compresses a pdf file named "filename.pdf" to a given number of dpi, optionnaly removing the annotations
# $1 : filename (as relative or absolute path with extension)
# $2 : dpi (optional, 300 dpi by default)
# $3 : keep annotations (optional, true by default)
pdf_compress() {
    if [ "$#" -lt 1 ] || [ "$#" -gt 3 ]; then
        echo "Illegal number of parameters ($#)."
        echo "Filename is mandatory, others are optional."
        echo "Usage: pdf_compress <filename.pdf> <[dpi]> <[keep_annotations]>"
    else
        if [ ! -f $1 ] || [ ! "${1: -4}" == ".pdf" ]; then
            echo "File does not exist or name was not provided with \".pdf\" extension."
        else
            filename=${1%.pdf}
            dpi=${2:-300}
            removeannotations=${3:-"true"}
            echo "Compressing $1 to $filename-compress.pdf using ghostscript."
            echo "Images compressed to: $dpi dpi."
            echo "Annotations kept: $removeannotations"
            ghostscript -sDEVICE=pdfwrite -dShowAnnots=$removeannotations -dBATCH -dMaxSubsetPct=100 -dDownsampleColorImages=true -dDownsampleGrayImages=true -dDownsampleMonoImages=true -dColorImageDownsampleThreshold=1 -dGrayImageDownsampleThreshold=1 -dMonoImageDownsampleThreshold=1 -dColorImageDownsampleType=/Bicubic -dGrayImageDownsampleType=/Bicubic -dColorImageResolution=$dpi -dGrayImageResolution=$dpi -dMonoImageResolution=$((4 * dpi)) -dAutoRotatePages=/PageByPage -sOutputFile="$filename-compress.pdf" -dNOPAUSE -dPrinted=false -c 100000000 setvmthreshold -f $1
        fi
    fi
}

pdf_compress_norot() {
    if [ "$#" -lt 1 ] || [ "$#" -gt 3 ]; then
        echo "Illegal number of parameters ($#)."
        echo "Filename is mandatory, others are optional."
        echo "Usage: pdf_compress <filename.pdf> <[dpi]> <[keep_annotations]>"
    else
        if [ ! -f $1 ] || [ ! "${1: -4}" == ".pdf" ]; then
            echo "File does not exist or name was not provided with \".pdf\" extension."
        else
            filename=${1%.pdf}
            dpi=${2:-300}
            removeannotations=${3:-"true"}
            echo "Compressing $1 to $filename-compress.pdf using ghostscript."
            echo "Images compressed to: $dpi dpi."
            echo "Annotations kept: $removeannotations"
            ghostscript -sDEVICE=pdfwrite -dShowAnnots=$removeannotations -dBATCH -dMaxSubsetPct=100 -dDownsampleColorImages=true -dDownsampleGrayImages=true -dDownsampleMonoImages=true -dColorImageDownsampleThreshold=1 -dGrayImageDownsampleThreshold=1 -dMonoImageDownsampleThreshold=1 -dColorImageDownsampleType=/Bicubic -dGrayImageDownsampleType=/Bicubic -dColorImageResolution=$dpi -dGrayImageResolution=$dpi -dMonoImageResolution=$((4 * dpi)) -dAutoRotatePages=/None -sOutputFile="$filename-compress.pdf" -dNOPAUSE -dPrinted=false -c 100000000 setvmthreshold -f $1
        fi
    fi
}

# Converts a PDF to a PNG, set dpi as param
pdf_to_png() {
    if [ "$#" -lt 1 ]; then
        echo "Illegal number of parameters ($#)."
        echo "Usage: pdf_to_png <filename> <[dpi]> <[keep_annotations]>"
    else
        if [ ! -f $1 ] || [ ! "${1: -4}" == ".pdf" ]; then
            echo "File does not exist or name was not provided with \".pdf\" extension."
        else
            filename=${1%.pdf}
            dpi=${2:-300}
            removeannotations=${3:-"true"}
            echo "Converting $1 to $filename-%d.pdf using ghostscript."
            echo "Target : $dpi dpi."
            echo "Annotations kept: $removeannotations"
            ghostscript -dNOPAUSE -dBATCH -dShowAnnots=$removeannotations -dNumRenderingThreads=6 -sDEVICE=png16m -r$dpi -dTextAlphaBits=4 -dGraphicsAlphaBits=4 -sOutputFile=$filename-%02d.png -c 100000000 setvmthreshold -f $filename.pdf 
        fi
    fi
}
