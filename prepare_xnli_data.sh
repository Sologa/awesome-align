
XNLI_DIR=data/XNLI-MT-1.0/multinli
PARALLEL_DIR=$XNLI_DIR/parallel_data

for lang in en de zh fr hi; do
    sed '1d' $XNLI_DIR/multinli.train.$lang.tsv > $PARALLEL_DIR/multinli.train.$lang.tsv
    cut -d$'\t' -f1 $PARALLEL_DIR//multinli.train.$lang.tsv > $PARALLEL_DIR/train.$lang.1
    cut -d$'\t' -f2 $PARALLEL_DIR//multinli.train.$lang.tsv > $PARALLEL_DIR/train.$lang.2
    cat $PARALLEL_DIR/train.$lang.1 $PARALLEL_DIR/train.$lang.2 > $PARALLEL_DIR/train.$lang
    rm $PARALLEL_DIR/multinli.train.$lang.tsv
    rm $PARALLEL_DIR/train.$lang.1
    rm $PARALLEL_DIR/train.$lang.2
done

for lang in de zh fr hi; do
    paste $PARALLEL_DIR/train.en $PARALLEL_DIR/train.$lang | awk -F '\t' '{print $1 " ||| " $2}' > $PARALLEL_DIR/train.en-$lang
done