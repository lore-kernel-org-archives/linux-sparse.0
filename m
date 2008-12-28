From: "Alexey Zaytsev" <alexey.zaytsev@gmail.com>
Subject: Re: [PATCH] Null ctype should have ptr_ctype as its base type.
Date: Mon, 29 Dec 2008 00:38:10 +0300
Message-ID: <f19298770812281338t698d10e6xf60b5d787896f04f@mail.gmail.com>
References: <20081225182817.26024.19045.stgit@zaytsev.su>
	 <20081228151134.6062.83633.stgit@zaytsev.su>
	 <70318cbf0812281252m70c70493h507295316e6621df@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-bw0-f21.google.com ([209.85.218.21]:47048 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756169AbYL1ViN (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 28 Dec 2008 16:38:13 -0500
Received: by bwz14 with SMTP id 14so15592741bwz.13
        for <linux-sparse@vger.kernel.org>; Sun, 28 Dec 2008 13:38:10 -0800 (PST)
In-Reply-To: <70318cbf0812281252m70c70493h507295316e6621df@mail.gmail.com>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: linux-sparse@vger.kernel.org, Tommy Thorn <tommy@numba-tu.com>

On Sun, Dec 28, 2008 at 23:52, Christopher Li <sparse@chrisli.org> wrote:
> On Sun, Dec 28, 2008 at 7:14 AM, Alexey Zaytsev
> <alexey.zaytsev@gmail.com> wrote:
>
>> So, we are getting a sizeof(NULL), or a sizeof((void *)0). It triggers here
>
> That is my fault. My test for void type should have been more careful.
>
>> because we are getting a null_ctype, and it's base_type points to
>> void_ctype. I'm not sure if this patch is correct, but it seems to do
>> the trick, all void warnings are gone. Christopher?
>
> No, that is not the right way to fix it. Now you declare NULL as pointer
> to a pointer type "(void**) 0".
>
> Thanks for finding it out. Does my patch work for you?

Yes, it works, thank you.
There is one problem left:

11091a11093,11130
> drivers/net/wireless/wavelan_cs.c:362:16: error: subtraction of different types can't work (different base types)
> drivers/net/wireless/wavelan_cs.c:379:17: error: subtraction of different types can't work (different base types)
> drivers/net/wireless/wavelan_cs.c:385:21: error: subtraction of different types can't work (different base types)
[...]

It looks like:

... mmroff(0, mmr_fee_status) ..

#define mmroff(p,f)     (unsigned short)((void *)(&((mmr_t *)((void
*)0 + (p)))->f) - (void *)0)

mmr_fee_status being an element in struct mmr.
Here we end up substracting null from non-null void * pointer.
Looks quite pointless, but I think sparse should be able to
cope with this?
