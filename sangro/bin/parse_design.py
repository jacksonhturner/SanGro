#!/usr/bin/env python3
import pandas as pd
import sys


def check_columns(df):
    '''
    make sure only expected columns present
    '''
    expected_cols = ['id', 'gene']
    for i in df.columns:
        assert i in expected_cols

df = pd.read_csv(sys.argv[1])
check_columns(df)

df_gene = df[df['gene'].notna()]
df_gene = df_gene[['id', 'gene']]
df_gene.to_csv('gene.csv', index=False)
