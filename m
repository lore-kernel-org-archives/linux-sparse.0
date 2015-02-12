From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] Teach sparse about the __COUNTER__ predefined macro
Date: Thu, 12 Feb 2015 12:16:55 -0800
Message-ID: <CANeU7Q=DevAJH5UAXGi+jzMbdn2M6XFqCioTRxYjqZyGXAtDhA@mail.gmail.com>
References: <54C15E0E.4000008@de.ibm.com>
	<CANeU7QmVQyRFHJ+YSDPkfDfXsNSLL4rJ-jA4v3UQH0tNqjEPOw@mail.gmail.com>
	<20150123222332.GB42179@macpro.local>
	<20150123223856.GB1489@cloud>
	<20150123235934.GA42931@macpro.local>
	<CANeU7Qn9ORJ=uH6szkW2FpTT8hFhdNETjxndBYa8347Z1iON0Q@mail.gmail.com>
	<20150204023816.GA7731@macpro.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qg0-f43.google.com ([209.85.192.43]:48609 "EHLO
	mail-qg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751099AbbBLUQ4 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 12 Feb 2015 15:16:56 -0500
Received: by mail-qg0-f43.google.com with SMTP id i50so9985369qgf.2
        for <linux-sparse@vger.kernel.org>; Thu, 12 Feb 2015 12:16:56 -0800 (PST)
In-Reply-To: <20150204023816.GA7731@macpro.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Josh Triplett <josh@joshtriplett.org>, Christian Borntraeger <borntraeger@de.ibm.com>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, Linux-Sparse <linux-sparse@vger.kernel.org>, Sam Ravnborg <sam@ravnborg.org>

On Tue, Feb 3, 2015 at 6:38 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>
> Fine for me but Josh had a remark about the third test file (validation/preprocessor/counter3.c)
> abusing a bit the test framework and I shared his feeling.
>
> Here is a patch serie fixing this abuse by extending the test framework.
>

I check in a version with very minor fix for the counter3.c hack.
Counter3.c does a few things unclean, top of which is, it does not invoke
counter3.c at all. It is invoking counter1.c and counter2.c.

I modify coutner3.c to include the couter2.c, that will solve the problem that
counter3.c not using its own source code.

Any way, the change is pushed.

Thanks

Chris
