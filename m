From: Christopher Li <sparse@chrisli.org>
Subject: Re: Defect in linearization of short circuit &&
Date: Wed, 17 Feb 2010 12:22:12 -0800
Message-ID: <70318cbf1002171222p652692eerc3aa0f31f69dbe6b@mail.gmail.com>
References: <4B77FD0F.50401@googlemail.com> <4B78655D.2080007@googlemail.com>
	 <70318cbf1002141509u4ebc4ef5x51ec41f5f1452a7a@mail.gmail.com>
	 <4B799CA6.70807@googlemail.com>
	 <70318cbf1002151141p35e49f92l73510d09452f56ee@mail.gmail.com>
	 <4B79AC03.4010608@googlemail.com>
	 <70318cbf1002151311g103dbc27q3b89ae9804747684@mail.gmail.com>
	 <1266312482.3433.33.camel@thorin>
	 <70318cbf1002161102n63995222o914299dd358f594d@mail.gmail.com>
	 <1266407258.11294.194.camel@thorin>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qy0-f178.google.com ([209.85.221.178]:32817 "EHLO
	mail-qy0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754880Ab0BQUWO (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 17 Feb 2010 15:22:14 -0500
Received: by qyk8 with SMTP id 8so2211571qyk.24
        for <linux-sparse@vger.kernel.org>; Wed, 17 Feb 2010 12:22:13 -0800 (PST)
In-Reply-To: <1266407258.11294.194.camel@thorin>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Bernd Petrovitsch <bernd@petrovitsch.priv.at>
Cc: =?ISO-8859-2?Q?Jacek_=A6liwerski?= <sliwers@googlemail.com>, linux-sparse@vger.kernel.org

On Wed, Feb 17, 2010 at 3:47 AM, Bernd Petrovitsch
<bernd@petrovitsch.priv.at> wrote:
>>
>> But for this expression:
>>
>> a = st && st->foo && st->bar && i > 0;
>>
>> This optimization might be worth while.
> ACK. But this example has no side effect (assuming no preprocessor
> trickery, no "volatile" somewhere relevant, etc.) so it' not
> "dangerous".
> Above I was talking about the general case.
Then we are in agreement.

Sparse actually go the extra mile to make sure the expression is
safe. So whenever the expression has side effects or unsafe, it set the cost
of the expression prohibitively high.

E.g:
expand_dereference() return UNSAFE because the expression can segfault.
expand_call() return SIDE_EFFECT.

So if there is a bug cause the some unsafe optimization. We just just fix the
bug instead of disable the optimization.

It is harder to do this optimization in the linearized instructions because
the linearized instruction does not have the expression boundary any more.

Chris
