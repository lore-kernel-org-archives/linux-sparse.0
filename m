From: Derek M Jones <derek@knosof.co.uk>
Subject: Re: [PATCH 7/16] Let void have sizeof 1
Date: Tue, 23 Dec 2008 09:00:18 +0000
Message-ID: <4950A8A2.5090702@knosof.co.uk>
References: <20081218181935.28136.60256.stgit@zaytsev.su>	 <20081218223216.23692.711.stgit@zaytsev.su>	 <70318cbf0812221951m4f9ee42bqac419b1f0b800bfa@mail.gmail.com>	 <f19298770812222037l6dbe5b35t4803138e20bab04d@mail.gmail.com> <f19298770812222129n556390ebwb1f2253dfc5f3086@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mtaout01-winn.ispmail.ntl.com ([81.103.221.47]:9904 "EHLO
	mtaout01-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751432AbYLWJAf (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 23 Dec 2008 04:00:35 -0500
In-Reply-To: <f19298770812222129n556390ebwb1f2253dfc5f3086@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Alexey Zaytsev <alexey.zaytsev@gmail.com>
Cc: Christopher Li <sparse@chrisli.org>, Josh Triplett <josh@kernel.org>, Johannes Berg <johannes@sipsolutions.net>, linux-sparse@vger.kernel.org

Alexey,

>> In the Linux kernel, we've got lots of void * address arithmetics:
>> linux/linux-2.6$ make -j 8 CC='gcc -Wpointer-arith' 2>&1 | grep
>> 'warning: pointer of type \'void \*\' used in arithmetic' | uniq | wc
>> -l
>> 45095
> I screwed up, it should be | sort -u | uniq | wc -l
> But it's still 14488.

This is a sufficiently large number that we ought to consider adding
checks for the usage, for instance:

    1) Are the arguments really chars of one sort or another and
therefore the parameter ought to be declared as such?

    2) The arguments have various structure and/or array types and
the storage is being walked over in the called function.  Can the
minimum size ever passed be worked out and this information used in
the size_void (my proposed name for a pointer that has either sizeof,
++ or -- performed on it) function to check for overruns.

    3) Are there any restrictions on passing a void pointer to a
size_void function or vice versa?  I cannot think of any obvious
ones, but then I don't know the various kinds of circumstances
in which this happens.

    4) Other possible fault issues, people?

-- 
Derek M. Jones                         tel: +44 (0) 1252 520 667
Knowledge Software Ltd                 mailto:derek@knosof.co.uk
Source code analysis                   http://www.knosof.co.uk
