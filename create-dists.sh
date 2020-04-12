#!/usr/bin/env bash
PLATFORMS="$1"
TAG="$2"

mkdir -p dist
while IFS=','; read -ra PLATFORM_ARRAY; do
    for p in "${PLATFORM_ARRAY[@]}"; do
        p_noslash="$(echo ${p} | sed -e 's|linux/||' | tr -d '/')"
        docker pull --platform "${p}" "${TAG}"
        docker run -i --platform "${p}" "${TAG}" cat /kenlm.tar.gz > "dist/kenlm-20200308_${p_noslash}.tar.gz"
    done
done <<< "${PLATFORMS}"
