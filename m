From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: Multiple translation unit regression
Date: Wed, 08 Jul 2009 20:32:34 +0100
Message-ID: <4A54F452.8030601@ramsay1.demon.co.uk>
References: <4A5131F4.7070007@ramsay1.demon.co.uk>	 <70318cbf0907060232j7067f7fcra857b71ebdf62348@mail.gmail.com> <70318cbf0907062327u51a4253fub2c0f1b2f64c1a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lon1-post-1.mail.demon.net ([195.173.77.148]:44776 "EHLO
	lon1-post-1.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755152AbZGHTvJ (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 8 Jul 2009 15:51:09 -0400
In-Reply-To: <70318cbf0907062327u51a4253fub2c0f1b2f64c1a@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Junio C Hamano <gitster@pobox.com>, Andreas Ericsson <ae@op5.se>, Sparse Mailing-list <linux-sparse@vger.kernel.org>

Christopher Li wrote:
> Can you try the following patch? I move the extern inline function
> to file scope. Again, I still think it would be better let sparse
> check one file at a time.
> 

This solves the problem on cygwin. I almost didn't test it on Linux,
since it looked like this should work just fine...

Unfortunately, the problem persists on Linux and I don't have time
tonight to try and debug it; I will look into it further, hopefully
tomorrow evening.

ATB,
Ramsay Jones

