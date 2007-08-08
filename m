From: "Christopher Li" <sparse@chrisli.org>
Subject: Re: sparse ctags
Date: Wed, 8 Aug 2007 02:30:30 -0700
Message-ID: <70318cbf0708080230j5278e787j8684aa7ae0aa400b@mail.gmail.com>
References: <cc723f590706260145q708c4390kf5b6ccbaf84000ef@mail.gmail.com>
	 <1186426987.3089.27.camel@josh-work.beaverton.ibm.com>
	 <46B7E932.2060804@freedesktop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.189]:48249 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762530AbXHHJab (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 8 Aug 2007 05:30:31 -0400
Received: by rv-out-0910.google.com with SMTP id k20so92569rvb
        for <linux-sparse@vger.kernel.org>; Wed, 08 Aug 2007 02:30:31 -0700 (PDT)
In-Reply-To: <46B7E932.2060804@freedesktop.org>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@freedesktop.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On 8/6/07, Josh Triplett <josh@freedesktop.org> wrote:
>
> Looks like some enums grew new values and ctags didn't stay up to date.  I
> think this patch fixes that particular problem:
>
> diff --git a/ctags.c b/ctags.c
> index f5b8fc7..63f59a5 100644
> --- a/ctags.c
> +++ b/ctags.c
> @@ -111,6 +111,8 @@ static void examine_symbol(struct symbol *sym)
>                 return;
>         if (sym->ident && sym->ident->reserved)
>                 return;
> +       if (sym->type == SYM_KEYWORD)
> +               return;
>
>         add_tag(sym);
>         base = sym->ctype.base_type;
> @@ -158,6 +160,8 @@ static void examine_namespace(struct symbol *sym)
>                 return;
>
>         switch(sym->namespace) {
> +       case NS_KEYWORD:
> +               return;
>         case NS_LABEL:
>                 sym->kind = 'l';
>                 break;
>

That looks good to me.

> After some further investigation, I think ctags really shouldn't look at
> SYM_PREPROCESSOR or NS_PREPROCESSOR either.  I came up with the attached
> patch, which I will apply soon unless someone shouts.  Chris?

I think SYM_PREPROCESSOR is also used by macros with NS_MACRO.
You just need to strip out the NS_PREPROCESSOR. I guess you try to
skip the symbol with NS_SYMBOL: and SYM_PREPROCESSOR at the same
time.

I am not sure about the test for "sym->type == SYM_KEYWORD",
do you see some case trigger that?

Sorry, I just find out that I get drop out from the sparse mail list
for a while and miss
a lot of interesting discussions. Blame my mail server.

>
> This still doesn't fix running ctags on multiple files; ctags seems to get
> confused in much the same way sparse does when run on multiple files: it spews
> a pile of redefinition errors.

Should make sparse able to clean up itself. I will see what I can do.

Chris
