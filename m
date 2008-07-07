From: "Christopher Li" <sparse@chrisli.org>
Subject: Re: Odd sparse behaviour
Date: Mon, 7 Jul 2008 12:42:17 -0700
Message-ID: <70318cbf0807071242k445297d0s79d3481eaa5a8899@mail.gmail.com>
References: <48713A18.7050103@cowlark.com>
	 <1215452912.3003.27.camel@josh-work.beaverton.ibm.com>
	 <f19298770807071109s529f2215sc4b7d7f1f7011208@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.189]:3672 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754920AbYGGTmV (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 7 Jul 2008 15:42:21 -0400
Received: by ti-out-0910.google.com with SMTP id b6so591652tic.23
        for <linux-sparse@vger.kernel.org>; Mon, 07 Jul 2008 12:42:18 -0700 (PDT)
In-Reply-To: <f19298770807071109s529f2215sc4b7d7f1f7011208@mail.gmail.com>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Alexey Zaytsev <alexey.zaytsev@gmail.com>
Cc: Josh Triplett <josht@linux.vnet.ibm.com>, David Given <dg@cowlark.com>, linux-sparse@vger.kernel.org

On Mon, Jul 7, 2008 at 11:09 AM, Alexey Zaytsev
<alexey.zaytsev@gmail.com> wrote:

>
>        /* Parse declaration-specifiers, if any */
>        token = declaration_specifiers(token, &ctype, 0);
>        decl = alloc_symbol(token->pos, SYM_NODE);
>        decl->ctype = ctype;
>        token = declarator(token, decl, &ident);
>        apply_modifiers(token->pos, &decl->ctype);
>
> I think that after calling declaration_specifiers(), we should
> check if token_type(token) == TOKEN_IDENT and lookup
> the symbol in the relevant namespaces. If it is found, we shoud
> check if the types and produce soe warnings. And reuse the
> symbol, if the types match.

This is a old bug of sparse and unfortunately very nasty to fix.

I have considered some thing similar to your approach before.
Yours is too simple, it can't handle node is a pointer for example.
But even if we change direct_declarator, there is other problem
with this approach. The type  evaluate happens _after_ the
parsing stage. So at the parsing state it is very hard to answer
the question "if the types match". No to mention "reuse the symbol"
does break a lot of the assumption of the parsing code which
assume symbol node is new. It just blindly assign ctype members
rather than merging it.

On the other hand, breaking that assumption might be a good thing
for other reasons. One of the thing I really want to do is make the
ctype have some optional attribute fields. e.g. no return functions.
We are running out of bits in the ctype attribute. Keep on adding
member to ctype does not scale because it is used every where.

Another approach to this problem is let parsing code create a new node.
Let check_duplicates merge the symbol if the type matches.
Then evaluate_symbol needs to return the merged result symbol
as well. The caller need to either place the current one with
the new symbol or delete the original one from the list.
Replacing the original symbol part seems ugly. On the bright side
there is not too many place needs it. It will have a smaller patch
than the first approach.

I like to heard if any one else have better suggestion as well.

Chris
