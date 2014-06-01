From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] Fix offsets in anonymous unions
Date: Sun, 1 Jun 2014 00:55:44 -0700
Message-ID: <CANeU7Qn067TkgFsfHJkd30Q3mEtCvgjwMUt=a3Yfo7Zfcq10fg@mail.gmail.com>
References: <f6d65cc35d3627885e7a1c89e70a48c3368d4f66.1400764815.git.john@keeping.me.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qg0-f41.google.com ([209.85.192.41]:44916 "EHLO
	mail-qg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750998AbaFAHzp (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 1 Jun 2014 03:55:45 -0400
Received: by mail-qg0-f41.google.com with SMTP id j5so8968536qga.28
        for <linux-sparse@vger.kernel.org>; Sun, 01 Jun 2014 00:55:44 -0700 (PDT)
In-Reply-To: <f6d65cc35d3627885e7a1c89e70a48c3368d4f66.1400764815.git.john@keeping.me.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Thu, May 22, 2014 at 6:22 AM, John Keeping <john@keeping.me.uk> wrote:
> Commit 38d1124 (Fix error at anoymous unions, 2014-04-03) says:
> @@ -2328,6 +2326,7 @@ static struct expression *check_designators(struct expression *e,
>                                 break;
>                         }
>                         e->field = e->ctype = ctype;
> +                       e->init_offset = offset;
>                         last = e;
>                         if (!e->ident_expression) {

OK, this is actually wrong. The member "init_offset" is only
valid for EXPR_POS type. The current e->type is EXPR_IDENTIFIER,
the e->init_offset member actually share the same memory location as
e->expr_ident. In order words, writing to init_offset will corrupt the
e->expr_ident. We did not use e->expr_ident afterwards though.


Chris
