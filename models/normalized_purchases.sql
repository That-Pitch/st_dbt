

select p.id,
       p.created,
       p.amount,
       p.user        as user_id,
       u.name        as buyer_name,
       b.basketitems as basket_items
from {{source('raw_synchtank','purchases')}} as p
         left join {{source('raw_synchtank','users')}} as u on p.user = u.id
         left join {{source('raw_synchtank','baskets')}} as b on b.purchase = p.id
order by p.created desc

