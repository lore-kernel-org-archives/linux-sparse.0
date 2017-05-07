From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH v5] sparse: add support for _Static_assert
Date: Sat, 6 May 2017 20:24:42 -0400
Message-ID: <CANeU7QnoXnsY-dMC+Rcm4YmgfzjP9F4OoKfJ7FGnbmSctmLR5w@mail.gmail.com>
References: <20170504160038.5328-1-lrichard@redhat.com> <CANeU7Q=YnmjjRx5DQqg75o+rXYuyTR7L1tBOzjrBK5XOp3UuJw@mail.gmail.com>
 <20170506231128.h65gxchj3dbaxfmp@desk.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f45.google.com ([209.85.214.45]:36412 "EHLO
        mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757253AbdEGWVy (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 7 May 2017 18:21:54 -0400
Received: by mail-it0-f45.google.com with SMTP id o5so56529557ith.1
        for <linux-sparse@vger.kernel.org>; Sun, 07 May 2017 15:21:53 -0700 (PDT)
In-Reply-To: <20170506231128.h65gxchj3dbaxfmp@desk.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Lance Richardson <lrichard@redhat.com>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Sat, May 6, 2017 at 7:11 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>
>> @@ -2093,6 +2107,40 @@ static struct token *parse_asm_declarator(struct token *token, struct decl_state
>> +
>> +static struct token *parse_static_assert(struct token *token, struct symbol_list **unused)
>> +{
>> +     struct expression *cond = NULL, *fail_string = NULL;
>> +     int val;
>> +
>> +     token = expect(token->next, '(', "after _Static_assert");
>> +     token = constant_expression(token, &cond);
>> +     if (!cond)
>> +             sparse_error(token->pos, "expect expression before '%s' token", show_token(token));
>
> I would prefer to put this validation after the parsing
> rather than in the middle but it's a detail.

It can be done but there will be more bookkeeping of the token->pos.
We need to remember which token is the one the error happening.

That is why I do earlier. I could make cond_token vs string_token
to save the place. It is a bit annoying when the expression is not there
the token will point the next thing.


>> +     token = expect(token, ')', "after second argument of _Static_assert");
>> +
>> +     expect(token, ';', "after _Static_assert()");
>> +
>> +     if (!cond || !fail_string)
>> +             return token;
>
> This test no become unneeded.
> Well, I mean that it would be better to move the tests above here
> in place of this one.

The test is still required. The previous code only complain but did not
change the execution flow. If the code move here the test can be merged.
Let me try the token_arg thing then.

>
>> +
>> +     val = const_expression_value(cond);
>> +
>> +     if (fail_string->type != EXPR_STRING) {
>> +             sparse_error(fail_string->pos, "bad string literal");
>> +             return token;
>> +     }
>
> Same, better to put all these validation together.

Let me try it then.

> Well, yes but it's a very strange 'declaration'. I had also
> looked if both could be merged and concluded that they should
> not for two reasons:
> 1) the grammar of a declaration and the static-assert has one
>    difference in the way the final ';' is handled.
>    It's included in the spec of static-assert while it's left
>    out for declaration (but included in declaration-list)


>    With your change here, sparse will complain twice when a
>    trailing ';' is missing, and if you remove the "expect(';')"
>    in parse_static_assert then:

Good point about complain twice on the missing ';'.
I am leaning towards remove the expect(';') then.

>     - you will have a warning 'Expected ; at the end of type declaration'
>       for something that nobody will consider to be a declaration
>       (well ok, nobody but the ones that read such details in the
>       C grammar).
If it is only the "type" declaration you are complain about.
We should be able to make it emit "static assert" declaration.
I will see if I can make it better.

>     - is there situations where a 'declaration' need not to be
>       terminated by a ';' ?

It depends, declartion_list() is only use in two places.
Structure and K&R arguments. Both case are terminating with ';'.

Normal external_declare(), I can't think of a case yet.
The stander specify the declaration need to end with ';'.

> 2) I think that _Static_assert() should not be considered as a
>    declaration but as a statement regarding -Wdeclaration-after-statement.
>    Lance's version did this but yours doesn't anymore.

I think the V5 consider static assert not statement nor declaration.

>    Of course in the standard they can mix the two in the spec
>    since it's OK for the standard to mix decls and statements.
>    But that's not true anymore with -Wdeclaration-after-statement
>    I certainly want to use the following code without a warning
>    'mixing declarations and code' but I want to have this warning
>    when a 'true' declaration is mixed with statements.

I think static assert *should not* consider as statements.
It is wrong in may levels.

It is clear that the stander consider static assert as declaration:
    declaration:
        <declaration-specifiers> <init-declarator-list>[opt] ;
        <static_assert-declaration>

I think it is bad mixing the static assert inside statements.
<statement>
_Static_assert();
<statement>

It give the impression the static assert look like a function call.
I see nothing wrong complain about this because stander clearly
state static assert as declaration, for a reason.

Making static assert not a statement nor declaration will further
complicate things.

> Also, that's just tow points I saw when seeing you have merged the
> two, maybe there is others points that need consideration.

That is why we have the review process. I will see if I can come
up with a version without the double ';' error complain.

Thanks for the review. I will see if I can come up with V7 address
your feed back.

Chris
