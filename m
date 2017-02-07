From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 2/5] simplify '(x / 1)' to 'x'
Date: Tue, 7 Feb 2017 10:53:16 +0800
Message-ID: <CANeU7QmSHZf9p+0riTgtMFtSuopkHgmcwG_t1izjwg5sDa1B6g@mail.gmail.com>
References: <20161207154655.98109-1-luc.vanoostenryck@gmail.com> <20161207154655.98109-3-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-io0-f193.google.com ([209.85.223.193]:36764 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752172AbdBGCxS (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 6 Feb 2017 21:53:18 -0500
Received: by mail-io0-f193.google.com with SMTP id q20so11573542ioi.3
        for <linux-sparse@vger.kernel.org>; Mon, 06 Feb 2017 18:53:17 -0800 (PST)
In-Reply-To: <20161207154655.98109-3-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Wed, Dec 7, 2016 at 11:46 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> Currently we simplify multiplication by 1 but nothing
> for the similar divide by 1.
>
> --- a/simplify.c
> +++ b/simplify.c
> @@ -320,6 +320,10 @@ static int simplify_mul_div(struct instruction *insn, long long value)
>         case OP_MULU:
>                 if (value == 0)
>                         return replace_with_pseudo(insn, insn->src2);
> +       /* Fall through */
> +       case OP_DIVS:
> +       case OP_DIVU:
> +               break;

This patch has already applied to sparse-next. Just one minor comment that
if the fall through is just a break. It is better just break there. If
the later code
need to use the fall though, just add the fall through part with the later code.

I think the later patch change this code any way.


Chris
