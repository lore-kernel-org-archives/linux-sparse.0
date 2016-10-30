From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH v3] sparse: add support for static assert
Date: Sun, 30 Oct 2016 09:43:32 -0700
Message-ID: <CANeU7QkM7zqRta828_eRkTYr6SpG5J_2NHjpUpnK=pZejSXA1Q@mail.gmail.com>
References: <1454989031-12240-1-git-send-email-lrichard@redhat.com>
 <20160315225203.GC2679@macpro.local> <481469876.53571906.1465915752753.JavaMail.zimbra@redhat.com>
 <20161028203812.GA2221@macbook.local> <CANeU7QnWXt67zyfz2Nqk89gz45wPdNoM8N8wG96p-9L23hM+qA@mail.gmail.com>
 <20161030092029.GA5364@macbook.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f68.google.com ([209.85.214.68]:34835 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932589AbcJ3Qnd (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 30 Oct 2016 12:43:33 -0400
Received: by mail-it0-f68.google.com with SMTP id f129so3967211itc.2
        for <linux-sparse@vger.kernel.org>; Sun, 30 Oct 2016 09:43:33 -0700 (PDT)
In-Reply-To: <20161030092029.GA5364@macbook.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Lance Richardson <lrichard@redhat.com>, Linux-Sparse <linux-sparse@vger.kernel.org>

>+static struct symbol_op static_assert_op = {
>+       .type = KW_ST_ASSERT,
>+       .declarator = static_assert_declarator,
>+       .statement = parse_static_assert_statement,
>+       .toplevel = toplevel_static_assert,
>+};
>+

There is no need to introduce the KW_ST_ASSERT. Will explain
it later.

static assert is not a declarator. It will introduce other
issue if you treat it as one. For example, it allow the
following illegal syntax: "_Static_assert(1, "") foo;"

I think with ".statement" and ".toplevel" call back, it is sufficient
to remove the ".declarator". Do I break any thing if I remove it?


>+
>+               if (token_type(token) == TOKEN_IDENT) {
>+                       keyword = lookup_keyword(token->ident, NS_KEYWORD);
>+                       if (keyword && keyword->op->type == KW_ST_ASSERT)
>+                               token = keyword->op->declarator(token, NULL);
>+               }

There is much simpler way to do it. Please take a look at id-list.h.

if (token_type(token) == TOKEN_IDENT && token->ident == &_Static_assert_ident)
...

That is why there is no need for the KW_ST_ASSERT.

>+static struct token *parse_static_assert(struct token *token, int expect_semi)

I don't see which syntax can allow _Static_assert() not following the
semi column.
Do you have an example?

I can see const_expression_value will expand the expression as needed.
I am still wondering if there is any thing else need to process at
a later stage like expanding.

The test example is pretty good. We can use a little bit more test on
the path that trigger the assert.

Thanks for the patch and sorry for the late replay.

Chris

On Sun, Oct 30, 2016 at 2:20 AM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> On Sun, Oct 30, 2016 at 08:04:34AM +0800, Christopher Li wrote:
>> On Sat, Oct 29, 2016 at 4:38 AM, Luc Van Oostenryck
>> <luc.vanoostenryck@gmail.com> wrote:
>> > Chris, is is possible to have some feedback on this serie, please?
>> >
>> I did go though your V3 static assert patch.
> Thanks.
>
>> It has some minor issue.
>>
>> Over all pretty good.
>>
>> > Is there anything more I can do to help?
>>
>> Let me send you the feed back first.
> Sure.
>
>> Chris
>> --
