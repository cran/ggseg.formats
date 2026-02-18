## -----------------------------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## -----------------------------------------------------------------------------
library(ggseg.formats)

## -----------------------------------------------------------------------------
no_cc <- atlas_region_remove(dk(), "corpus callosum")
"corpus callosum" %in% atlas_regions(no_cc)

## -----------------------------------------------------------------------------
frontal <- atlas_region_keep(dk(), "frontal")
atlas_regions(frontal)

## -----------------------------------------------------------------------------
lh_only <- atlas_region_keep(dk(), "^lh_", match_on = "label")
head(atlas_labels(lh_only))

## -----------------------------------------------------------------------------
ctx <- atlas_region_contextual(aseg(), "ventricle")
"lateral ventricle" %in% atlas_regions(ctx)

## -----------------------------------------------------------------------------
renamed <- atlas_region_rename(
  dk(),
  "banks of superior temporal sulcus",
  "STS banks"
)
"STS banks" %in% atlas_regions(renamed)

## -----------------------------------------------------------------------------
upper <- atlas_region_rename(dk(), ".*", toupper)
head(atlas_regions(upper))

## -----------------------------------------------------------------------------
atlas_views(aseg())

## -----------------------------------------------------------------------------
sag <- atlas_view_keep(aseg(), "sagittal")
atlas_views(sag)

## -----------------------------------------------------------------------------
fewer <- atlas_view_remove(aseg(), c("axial_3", "coronal_2"))
atlas_views(fewer)

## -----------------------------------------------------------------------------
cleaned <- atlas_view_remove_small(aseg(), min_area = 50)

## -----------------------------------------------------------------------------
cleaned_sag <- atlas_view_remove_small(
  aseg(),
  min_area = 50,
  views = "sagittal"
)

## -----------------------------------------------------------------------------
no_stem_sf <- atlas_view_remove_region(
  aseg(),
  "brain stem",
  match_on = "region"
)

## -----------------------------------------------------------------------------
trimmed <- aseg() |>
  atlas_view_keep(c("sagittal", "coronal_3", "axial_3")) |>
  atlas_view_gather()
atlas_views(trimmed)

## -----------------------------------------------------------------------------
reordered <- aseg() |>
  atlas_view_keep(c("sagittal", "coronal_3", "axial_3")) |>
  atlas_view_reorder(c("axial_3", "sagittal", "coronal_3"))
atlas_views(reordered)

## -----------------------------------------------------------------------------
network_info <- data.frame(
  region = c(
    "superior frontal",
    "precuneus",
    "inferior parietal",
    "posterior cingulate"
  ),
  network = "default mode"
)
enriched <- atlas_core_add(dk(), network_info)
enriched$core[!is.na(enriched$core$network), c("region", "network")]

## -----------------------------------------------------------------------------
publication_aseg <- aseg() |>
  atlas_view_keep(c("sagittal", "coronal_3")) |>
  atlas_region_contextual("ventricle|choroid|white|cc") |>
  atlas_view_remove_small(min_area = 30) |>
  atlas_view_gather(gap = 0.1)

publication_aseg

