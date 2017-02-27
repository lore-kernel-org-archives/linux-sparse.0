From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH 4/5] add a method to external_declaration()
Date: Mon, 27 Feb 2017 22:34:43 +0100
Message-ID: <CAExDi1Td-ygRZNqRi=1NOhD43QA1pTQGB9Bo4K3aRKvKgEOOaQ@mail.gmail.com>
References: <20170218203048.22276-1-luc.vanoostenryck@gmail.com>
 <20170218203048.22276-5-luc.vanoostenryck@gmail.com> <CANeU7Q=X66U4F1nGTdNH1q+mNF=JU9s8z=we0Gbpep4F6X-vgA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qk0-f171.google.com ([209.85.220.171]:36016 "EHLO
        mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751778AbdB0Vez (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 27 Feb 2017 16:34:55 -0500
Received: by mail-qk0-f171.google.com with SMTP id n186so42461653qkb.3
        for <linux-sparse@vger.kernel.org>; Mon, 27 Feb 2017 13:34:49 -0800 (PST)
In-Reply-To: <CANeU7Q=X66U4F1nGTdNH1q+mNF=JU9s8z=we0Gbpep4F6X-vgA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Mon, Feb 27, 2017 at 4:37 PM, Christopher Li <sparse@chrisli.org> wrote:
> On Sun, Feb 19, 2017 at 4:30 AM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
>> After parsing and validation, the symbols in the declaration
>> are added to the list given in argument, *if* they are not extern
>> symbols. The symbols that are extern are them not added to the list.
>>
>> This is what is needed for usual declarations but ignoring extern
>> symbols make it impossible to emit a diagnostic in less usual
>> situation.
>
> I have other situation want to use this as well.
>
>> --- a/parse.h
>> +++ b/parse.h
>> @@ -129,7 +129,8 @@ extern int show_statement(struct statement *);
>>  extern void show_statement_list(struct statement_list *, const char *);
>>  extern int show_expression(struct expression *);
>>
>> -extern struct token *external_declaration(struct token *token, struct symbol_list **list);
>> +typedef void (*add_decl_t)(struct symbol_list **list, struct symbol *decl);
>> +extern struct token *external_declaration(struct token *token, add_decl_t add_decl, struct symbol_list **list);
>>
>
> I think the logic should be, "external_declaration" accept token as input.
> For each newly declared symbol, it call to the callbacks function
> to receive the symbol. The receive behavior is depend on the callback
> function. The default function can be adding the symbol to a list.
>
> So the struct symbol_list **list should turn into transparent argument as
> context for the call back.

Yes, it can certainly be more general.

By 'transparent' you mean a void pointer?

For the two case currently concerned the callback argument can be a
statement pointer
because the two symbol list belong to a statement and I fact I
hesitated to use it or the list.
I choose the smallest change.

If for the other situation you talked here above, we can also use a
statement pointer,
I would prefrer to do so instead than using a void pointer but well it
doesn't matter much
anyway.


>> --- a/lib.c
>> +++ b/lib.c
>> @@ -1080,7 +1080,7 @@ static struct symbol_list *sparse_tokenstream(struct token *token)
>>
>>         // Parse the resulting C code
>>         while (!eof_token(token))
>> -               token = external_declaration(token, &translation_unit_used_list);
>> +               token = external_declaration(token, NULL, &translation_unit_used_list);
>
> I prefer here just provide the default call back which is
> add_stmt_decl in your case.

Sure, I can do this.


Luc
