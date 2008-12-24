From: Derek M Jones <derek@knosof.co.uk>
Subject: Re: [PATCH 7/16] Let void have sizeof 1
Date: Wed, 24 Dec 2008 00:26:40 +0000
Message-ID: <495181C0.7070803@knosof.co.uk>
References: <20081218181935.28136.60256.stgit@zaytsev.su>	 <20081218223216.23692.711.stgit@zaytsev.su>	 <70318cbf0812221951m4f9ee42bqac419b1f0b800bfa@mail.gmail.com>	 <f19298770812222037l6dbe5b35t4803138e20bab04d@mail.gmail.com>	 <f19298770812222129n556390ebwb1f2253dfc5f3086@mail.gmail.com>	 <4950A8A2.5090702@knosof.co.uk> <f19298770812230705o2bdd87e2j8446b292dda5f495@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mtaout02-winn.ispmail.ntl.com ([81.103.221.48]:54826 "EHLO
	mtaout02-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751241AbYLXA1F (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 23 Dec 2008 19:27:05 -0500
In-Reply-To: <f19298770812230705o2bdd87e2j8446b292dda5f495@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Alexey Zaytsev <alexey.zaytsev@gmail.com>
Cc: Christopher Li <sparse@chrisli.org>, Josh Triplett <josh@kernel.org>, Johannes Berg <johannes@sipsolutions.net>, linux-sparse@vger.kernel.org

Alexey,

I have been looking through the source to look at the contexts
in which arithmetic is performed on void pointers.

>>   1) Are the arguments really chars of one sort or another and
>> therefore the parameter ought to be declared as such?
> You mean, if address arithmetics is performed on a void * cast result,
> check that the casted type too has sizeof 1?

I was thinking more along the lines of pointer to a character type being
converted to void * for no obvious reason, or a value being converted to
void * having an arithmetic operation performed and then converted to
a pointer to character type.
For an example see line 156 of arch/x86/kernel/module_64.c

I would expect the void * to come from/go to a type that had a
size greater than 1.

>>   4) Other possible fault issues, people?

I have found an instance (arch/x86/kernel/kprobes.c:834) that
effectively does:

(void *)long_val + an_int_calculation

when it should have done:

(void *)(long_val + an_int_calculation)

hardly an earth shattering misuse.

-- 
Derek M. Jones                         tel: +44 (0) 1252 520 667
Knowledge Software Ltd                 mailto:derek@knosof.co.uk
Source code analysis                   http://www.knosof.co.uk
