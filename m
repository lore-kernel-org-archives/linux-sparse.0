From: "Alexey Zaytsev" <alexey.zaytsev@gmail.com>
Subject: Re: [PATCH] Null ctype should have ptr_ctype as its base type.
Date: Mon, 29 Dec 2008 12:03:07 +0300
Message-ID: <f19298770812290103w4e42a49cy196b3b5e6b21c309@mail.gmail.com>
References: <20081225182817.26024.19045.stgit@zaytsev.su>
	 <20081228151134.6062.83633.stgit@zaytsev.su>
	 <70318cbf0812281252m70c70493h507295316e6621df@mail.gmail.com>
	 <f19298770812281338t698d10e6xf60b5d787896f04f@mail.gmail.com>
	 <70318cbf0812282332m1188f0bbm1097ced77583dc42@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-bw0-f21.google.com ([209.85.218.21]:57206 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752514AbYL2JDL (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 29 Dec 2008 04:03:11 -0500
Received: by bwz14 with SMTP id 14so15920537bwz.13
        for <linux-sparse@vger.kernel.org>; Mon, 29 Dec 2008 01:03:08 -0800 (PST)
In-Reply-To: <70318cbf0812282332m1188f0bbm1097ced77583dc42@mail.gmail.com>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: linux-sparse@vger.kernel.org

On Mon, Dec 29, 2008 at 10:32, Christopher Li <sparse@chrisli.org> wrote:
> On Sun, Dec 28, 2008 at 1:38 PM, Alexey Zaytsev
> <alexey.zaytsev@gmail.com> wrote:
>> 11091a11093,11130
>>> drivers/net/wireless/wavelan_cs.c:362:16: error: subtraction of different types can't work (different base types)
>>> drivers/net/wireless/wavelan_cs.c:379:17: error: subtraction of different types can't work (different base types)
>>> drivers/net/wireless/wavelan_cs.c:385:21: error: subtraction of different types can't work (different base types)
>> [...]
>>
>> It looks like:
>>
>> ... mmroff(0, mmr_fee_status) ..
>>
>> #define mmroff(p,f)     (unsigned short)((void *)(&((mmr_t *)((void
>> *)0 + (p)))->f) - (void *)0)
>
> That is one piece of ugly code.
>
>>
>> mmr_fee_status being an element in struct mmr.
>> Here we end up substracting null from non-null void * pointer.
>> Looks quite pointless, but I think sparse should be able to
>> cope with this?
>
> Do you have minimal code to duplicate this bug?

Sorry, my bad. Ran it with a wrong sparse version.
