From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH v5] sparse: add support for _Static_assert
Date: Sun, 7 May 2017 05:51:26 +0200
Message-ID: <CAMHZB6E3z2mzA_PM_fQZ9o=gBPFb8i17G=PpdfNAOvicE_c9_A@mail.gmail.com>
References: <20170504160038.5328-1-lrichard@redhat.com> <CANeU7Q=YnmjjRx5DQqg75o+rXYuyTR7L1tBOzjrBK5XOp3UuJw@mail.gmail.com>
 <20170506231128.h65gxchj3dbaxfmp@desk.local> <CANeU7QnoXnsY-dMC+Rcm4YmgfzjP9F4OoKfJ7FGnbmSctmLR5w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qk0-f174.google.com ([209.85.220.174]:35009 "EHLO
        mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751412AbdEGWPZ (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 7 May 2017 18:15:25 -0400
Received: by mail-qk0-f174.google.com with SMTP id a72so23033468qkj.2
        for <linux-sparse@vger.kernel.org>; Sun, 07 May 2017 15:15:24 -0700 (PDT)
In-Reply-To: <CANeU7QnoXnsY-dMC+Rcm4YmgfzjP9F4OoKfJ7FGnbmSctmLR5w@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Lance Richardson <lrichard@redhat.com>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Sun, May 7, 2017 at 2:24 AM, Christopher Li <sparse@chrisli.org> wrote:
> On Sat, May 6, 2017 at 7:11 PM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
>>
>>> @@ -2093,6 +2107,40 @@ static struct token *parse_asm_declarator(struct=
 token *token, struct decl_state
>>> +
>>> +static struct token *parse_static_assert(struct token *token, struct s=
ymbol_list **unused)
>>> +{
>>> +     struct expression *cond =3D NULL, *fail_string =3D NULL;
>>> +     int val;
>>> +
>>> +     token =3D expect(token->next, '(', "after _Static_assert");
>>> +     token =3D constant_expression(token, &cond);
>>> +     if (!cond)
>>> +             sparse_error(token->pos, "expect expression before '%s' t=
oken", show_token(token));
>>
>> I would prefer to put this validation after the parsing
>> rather than in the middle but it's a detail.
>
> It can be done but there will be more bookkeeping of the token->pos.
> We need to remember which token is the one the error happening.

Ah yes, indeed.
Better to left it there then.

>>     - you will have a warning 'Expected ; at the end of type declaration=
'
>>       for something that nobody will consider to be a declaration
>>       (well ok, nobody but the ones that read such details in the
>>       C grammar).
> If it is only the "type" declaration you are complain about.
> We should be able to make it emit "static assert" declaration.
> I will see if I can make it better.

No, it's not with "type" that I have a problem but with "declaration".
As I tried to say above: "how many developers will consider the
static assertions as a declaration?"

> I think static assert *should not* consider as statements.
> It is wrong in may levels.
>
> It is clear that the stander consider static assert as declaration:
>     declaration:
>         <declaration-specifiers> <init-declarator-list>[opt] ;
>         <static_assert-declaration>

I don't think this is relevant here.
Yes, in the grammar of the C11 standard static assert is a kind of
declaration. And then?

> I think it is bad mixing the static assert inside statements.
> <statement>
> _Static_assert();
> <statement>
>
> It give the impression the static assert look like a function call.
How is that relevant?
Will this make it look less like a function call:
    int a;
    static_assert(..., ...);
    some_function_call();

> I see nothing wrong complain about this because stander clearly
> state static assert as declaration, for a reason.

The standard has its reasons that don't always match ours.
It's sparse's "raison d'=C3=AAtre" to make different choices than the stand=
ard.

And for the standard, the whole point is moot anyway since
it allows to freely mix declarations and statements.

Thus the only points that matter are:
- will people want to use static assertions in the middle of statements
  and still would receive a warning when true declarations are mixed
  with statements?
- does code already exists where static assertions are in the middle
  of statements while true declarations are not welcomed there?
- how hard i sit really to add an option to allow one or the other behaviou=
r?

-- Luc
