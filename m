From: Derek M Jones <derek@knosof.co.uk>
Subject: Re: [PATCH 7/16] Let void have sizeof 1
Date: Thu, 25 Dec 2008 00:14:50 +0000
Message-ID: <4952D07A.6090900@knosof.co.uk>
References: <20081218181935.28136.60256.stgit@zaytsev.su>	 <20081218223216.23692.711.stgit@zaytsev.su>	 <70318cbf0812221951m4f9ee42bqac419b1f0b800bfa@mail.gmail.com>	 <f19298770812222037l6dbe5b35t4803138e20bab04d@mail.gmail.com>	 <f19298770812222129n556390ebwb1f2253dfc5f3086@mail.gmail.com>	 <4950A8A2.5090702@knosof.co.uk>	 <f19298770812230705o2bdd87e2j8446b292dda5f495@mail.gmail.com>	 <495181C0.7070803@knosof.co.uk>	 <f19298770812231839n1aaaf84fla96dda04b11e0944@mail.gmail.com>	 <4952B0AD.7040007@cowlark.com> <70318cbf0812241510o2318f701w938840b9123fb9e4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mtaout01-winn.ispmail.ntl.com ([81.103.221.47]:61283 "EHLO
	mtaout01-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751440AbYLYAPT (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 24 Dec 2008 19:15:19 -0500
In-Reply-To: <70318cbf0812241510o2318f701w938840b9123fb9e4@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: David Given <dg@cowlark.com>, linux-sparse@vger.kernel.org

Christopher,

> I don't see the kernel directly use sizeof(void). Most of the place is

In some places it uses sizeof(*void_ptr) and I don't think we want to
prohibit a usage that is consistent with how void_ptr can be
manipulated.

> using (void*) pointer + offset. It is not portable. But it is probably not
> worthy while to fix. Convert the void* to char*, add offset, convert it back
> to void* is pretty annoying as well. If we really want to make it clean, maybe
> we can use a macro or inline functions. Again, probably not worth the effort.

I agree.  However, we need to recognise that this hole that has been
put into the type system needs to be carefully monitored to make
sure that unintended consequences do not occur.  Hence my suggestion
that sparse check for suspicious usage, but the only one I have come
up with so far is a sequence of conversions that is equivalent to:
(char*)((void *)ch_ptr + offset)

-- 
Derek M. Jones                         tel: +44 (0) 1252 520 667
Knowledge Software Ltd                 mailto:derek@knosof.co.uk
Source code analysis                   http://www.knosof.co.uk
