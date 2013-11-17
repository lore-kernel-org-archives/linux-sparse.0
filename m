From: Richard Weinberger <richard.weinberger@gmail.com>
Subject: Re: [PATCH] jffs2: fix sparse errors: directive in argument list
Date: Sun, 17 Nov 2013 23:53:16 +0100
Message-ID: <CAFLxGvx=uOr0Oh-FiB-NG8ytZE6a3c3POVm6a_czrc_7LoL0xg@mail.gmail.com>
References: <1384719513-27386-1-git-send-email-nunes.erico@gmail.com>
	<1384724403.2727.22.camel@joe-AO722>
	<CAK4VdL2nKEE+xb=HtMGNsMGNR_ivUn_WnLi7X-rrXT0fpGbSTw@mail.gmail.com>
	<1384728305.14335.4.camel@joe-AO722>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-vb0-f41.google.com ([209.85.212.41]:38798 "EHLO
	mail-vb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751374Ab3KQWxR (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 17 Nov 2013 17:53:17 -0500
In-Reply-To: <1384728305.14335.4.camel@joe-AO722>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: Erico Nunes <nunes.erico@gmail.com>, linux-mtd <linux-mtd@lists.infradead.org>, linux-sparse@vger.kernel.org, dwmw2 <dwmw2@infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>

On Sun, Nov 17, 2013 at 11:45 PM, Joe Perches <joe@perches.com> wrote:
> On Sun, 2013-11-17 at 20:34 -0200, Erico Nunes wrote:
>> Do you mean it as an error in the sparse tool?
>
> Yes.  I think it's a defect in how sparse
> treats string concatenation.
>
> That style:
>
>         printk("%s\n",
> #ifdef FOO
>         "foo"
> #endif
> #ifdef BAR
>         "bar"
> #endif
>         "string");
>
> is pretty common in the kernel sources.
>
> The patch itself is otherwise fine, but
> perhaps unnecessary.

I agree with Joe, the patch fixes a non-issue.

-- 
Thanks,
//richard
