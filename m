From: "Christopher Li" <sparse@chrisli.org>
Subject: Re: [PATCH] Null ctype should have ptr_ctype as its base type.
Date: Sun, 28 Dec 2008 23:32:24 -0800
Message-ID: <70318cbf0812282332m1188f0bbm1097ced77583dc42@mail.gmail.com>
References: <20081225182817.26024.19045.stgit@zaytsev.su>
	 <20081228151134.6062.83633.stgit@zaytsev.su>
	 <70318cbf0812281252m70c70493h507295316e6621df@mail.gmail.com>
	 <f19298770812281338t698d10e6xf60b5d787896f04f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.156]:49388 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752010AbYL2Hc0 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 29 Dec 2008 02:32:26 -0500
Received: by fg-out-1718.google.com with SMTP id 19so1679763fgg.17
        for <linux-sparse@vger.kernel.org>; Sun, 28 Dec 2008 23:32:24 -0800 (PST)
In-Reply-To: <f19298770812281338t698d10e6xf60b5d787896f04f@mail.gmail.com>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Alexey Zaytsev <alexey.zaytsev@gmail.com>
Cc: linux-sparse@vger.kernel.org

On Sun, Dec 28, 2008 at 1:38 PM, Alexey Zaytsev
<alexey.zaytsev@gmail.com> wrote:
> 11091a11093,11130
>> drivers/net/wireless/wavelan_cs.c:362:16: error: subtraction of different types can't work (different base types)
>> drivers/net/wireless/wavelan_cs.c:379:17: error: subtraction of different types can't work (different base types)
>> drivers/net/wireless/wavelan_cs.c:385:21: error: subtraction of different types can't work (different base types)
> [...]
>
> It looks like:
>
> ... mmroff(0, mmr_fee_status) ..
>
> #define mmroff(p,f)     (unsigned short)((void *)(&((mmr_t *)((void
> *)0 + (p)))->f) - (void *)0)

That is one piece of ugly code.

>
> mmr_fee_status being an element in struct mmr.
> Here we end up substracting null from non-null void * pointer.
> Looks quite pointless, but I think sparse should be able to
> cope with this?

Do you have minimal code to duplicate this bug?

I try with the following testing code without much luck.

Chris

typedef struct mmr_t	mmr_t;

struct mmr_t {
	int a;
	int mmr_fee_status;
};

#define mmroff(p,f)     (unsigned short)((void *)(&((mmr_t *)((void
*)0 + (p)))->f) - (void *)0)
int b;

int foo(void)
{
	return mmroff(0,mmr_fee_status);
}
