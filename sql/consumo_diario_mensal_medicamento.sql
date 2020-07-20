select
  ITMVTO_ESTOQUE.CD_PRODUTO,
  PRODUTO.DS_PRODUTO,
  ROUND(SUM(ITMVTO_ESTOQUE.QT_MOVIMENTACAO * UNI_PRO.VL_FATOR)/EXTRACT(day from SYSDATE), 2) AS CONSUMO_DIARIO,
  EXTRACT(day from SYSDATE) AS CNT_DIAS,
  EXTRACT(month from MVTO_ESTOQUE.DT_MVTO_ESTOQUE) as MES,
  EXTRACT(year from MVTO_ESTOQUE.DT_MVTO_ESTOQUE) as ANO
from
  ITMVTO_ESTOQUE
  join UNI_PRO on (
    ITMVTO_ESTOQUE.CD_PRODUTO = UNI_PRO.CD_PRODUTO AND
    ITMVTO_ESTOQUE.CD_UNI_PRO = UNI_PRO.CD_UNI_PRO
  )
  join MVTO_ESTOQUE on (
    ITMVTO_ESTOQUE.CD_MVTO_ESTOQUE = MVTO_ESTOQUE.CD_MVTO_ESTOQUE AND
    MVTO_ESTOQUE.TP_MVTO_ESTOQUE IN ('P', 'S')
  )
  join PRODUTO on (
    ITMVTO_ESTOQUE.CD_PRODUTO = PRODUTO.CD_PRODUTO
  )
where
  ITMVTO_ESTOQUE.CD_PRODUTO in (
    SELECT
      CD_PRODUTO
    FROM
      DBAMV.PRODUTO
    WHERE DBAMV.PRODUTO.CD_PRODUTO in (
        6501780, 1670049, 9460087, 9070017,
        1480231, 1480100, 9380512, 9380105,
        9670260, 9010340, 9010308, 9320048,
        9470181, 9480350, 9490016, 1470031,
        9540056, 9230065, 9230030, 9230057,
        9480193, 9460118, 1460010, 9460117,
        9480207, 9320064, 9150087, 9480266,
        1480320, 9480321, 1480061, 9480053,
        9060011, 9610097, 9610070, 9460176,
        9460095, 9460079, 9460054, 1460052,
        9600016, 9030074, 9060046, 9590225,
        9460036, 9480348, 1480142, 9480347,
        9460192, 9610062, 9480290, 9480150,
        9480151, 9680107, 9610054, 9470090,
        9110001, 9110009, 9060062, 9120073,
        9120081, 9120057, 1460010, 9320056,
        9230004, 1480061, 9380350, 9320153,
        9610071, 9230073, 9030074, 6502560,
        1480142, 9610062, 9610054, 9470155,
        6502604, 6502603, 6502471, 6502572,
        6502514
        )
  )
  AND MVTO_ESTOQUE.DT_MVTO_ESTOQUE > to_date('2020-03-16', 'yyyy-mm-dd')
  AND EXTRACT(month from MVTO_ESTOQUE.DT_MVTO_ESTOQUE) = EXTRACT(month from SYSDATE)
  GROUP BY ITMVTO_ESTOQUE.CD_PRODUTO, PRODUTO.DS_PRODUTO, EXTRACT(month from MVTO_ESTOQUE.DT_MVTO_ESTOQUE), EXTRACT(year from MVTO_ESTOQUE.DT_MVTO_ESTOQUE)
  UNION
  select
  ITMVTO_ESTOQUE.CD_PRODUTO,
  PRODUTO.DS_PRODUTO,
  ROUND(SUM(ITMVTO_ESTOQUE.QT_MOVIMENTACAO * UNI_PRO.VL_FATOR)/EXTRACT(day from LAST_DAY(DT_MVTO_ESTOQUE)), 2) AS CONSUMO_DIARIO,
  EXTRACT(day from LAST_DAY(DT_MVTO_ESTOQUE)) AS CNT_DIAS,
  EXTRACT(month from MVTO_ESTOQUE.DT_MVTO_ESTOQUE) as MES,
  EXTRACT(year from MVTO_ESTOQUE.DT_MVTO_ESTOQUE) as ANO
from
  ITMVTO_ESTOQUE
  join UNI_PRO on (
    ITMVTO_ESTOQUE.CD_PRODUTO = UNI_PRO.CD_PRODUTO AND
    ITMVTO_ESTOQUE.CD_UNI_PRO = UNI_PRO.CD_UNI_PRO
  )
  join MVTO_ESTOQUE on (
    ITMVTO_ESTOQUE.CD_MVTO_ESTOQUE = MVTO_ESTOQUE.CD_MVTO_ESTOQUE AND
    MVTO_ESTOQUE.TP_MVTO_ESTOQUE IN ('P', 'S')
  )
  join PRODUTO on (
    ITMVTO_ESTOQUE.CD_PRODUTO = PRODUTO.CD_PRODUTO
  )
where
  ITMVTO_ESTOQUE.CD_PRODUTO in (
    SELECT
      CD_PRODUTO
    FROM
      DBAMV.PRODUTO
    WHERE DBAMV.PRODUTO.CD_PRODUTO in (
        6501780, 1670049, 9460087, 9070017,
        1480231, 1480100, 9380512, 9380105,
        9670260, 9010340, 9010308, 9320048,
        9470181, 9480350, 9490016, 1470031,
        9540056, 9230065, 9230030, 9230057,
        9480193, 9460118, 1460010, 9460117,
        9480207, 9320064, 9150087, 9480266,
        1480320, 9480321, 1480061, 9480053,
        9060011, 9610097, 9610070, 9460176,
        9460095, 9460079, 9460054, 1460052,
        9600016, 9030074, 9060046, 9590225,
        9460036, 9480348, 1480142, 9480347,
        9460192, 9610062, 9480290, 9480150,
        9480151, 9680107, 9610054, 9470090,
        9110001, 9110009, 9060062, 9120073,
        9120081, 9120057, 1460010, 9320056,
        9230004, 1480061, 9380350, 9320153,
        9610071, 9230073, 9030074, 6502560,
        1480142, 9610062, 9610054, 9470155,
        6502604, 6502603, 6502471, 6502572,
        6502514
        )
  )
  AND MVTO_ESTOQUE.DT_MVTO_ESTOQUE > to_date('2020-03-16', 'yyyy-mm-dd')
  AND EXTRACT(month from MVTO_ESTOQUE.DT_MVTO_ESTOQUE) != EXTRACT(month from SYSDATE)
GROUP BY ITMVTO_ESTOQUE.CD_PRODUTO, PRODUTO.DS_PRODUTO, EXTRACT(month from MVTO_ESTOQUE.DT_MVTO_ESTOQUE), EXTRACT(year from MVTO_ESTOQUE.DT_MVTO_ESTOQUE), EXTRACT(day from LAST_DAY(DT_MVTO_ESTOQUE))