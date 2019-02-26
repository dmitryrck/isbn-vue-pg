class UpdatePgIsbnsToSetIsbnUsingPg < ActiveRecord::Migration[5.2]
  def up
    execute %[
create function public.set_digit() returns trigger
    language plpgsql
    as $$
  declare
    isbn int[];
    result int;
  begin
    isbn := regexp_split_to_array(new.isbn, '')::int[];

    for index in 1..12 loop
      if mod(index, 2) = 0 then
        isbn[index] = isbn[index] * 3;
      else
        isbn[index] = isbn[index] * 1;
      end if;
    end loop;

    result := (10 - mod(sum(numbers), 10)) from unnest(isbn) numbers;

    if result = 10 then
      new.digit = 0;
    else
      new.digit = result;
    end if;

    return new;
  end $$;

create
  trigger set_digit BEFORE insert
    on public.pg_isbns for each row execute procedure public.set_digit();
    ]
  end

  def down
    execute %[
      drop trigger set_digit on public.pg_isbns;
      drop function public.set_digit();
    ]
  end
end
