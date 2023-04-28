select p.id, p.created, p.amount, p.user as user_id, u.name as buyer_name,
       b.basketitems as basket_items,


from purchases as p
         left join users as u on p.user = u.id
         left join baskets as b on b.purchase = p.id
order by created desc