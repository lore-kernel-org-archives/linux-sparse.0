From: David Given <dg@cowlark.com>
Subject: Re: `char * s = "abc";' causes compile to crash with a segfault
Date: Thu, 30 Apr 2009 11:13:34 +0100
Message-ID: <49F979CE.5080308@cowlark.com>
References: <op.us51m0w9ucb9g9@home-5db3af48a> <49F8C1EB.5010909@garzik.org>	 <49F8D803.6080000@cowlark.com> <70318cbf0904291641w30f19372ne95e98d1030964cf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from a.painless.aaisp.net.uk ([81.187.30.51]:45594 "EHLO
	a.painless.aaisp.net.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754591AbZD3KNs (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 30 Apr 2009 06:13:48 -0400
Received: from tiar.cowlark.co.uk ([81.187.191.218] helo=gate.cowlark.com)
	by a.painless.aaisp.net.uk with esmtp (Exim 4.69)
	(envelope-from <dg@cowlark.com>)
	id 1LzTGz-0003dX-N4
	for linux-sparse@vger.kernel.org; Thu, 30 Apr 2009 11:13:45 +0100
Received: from [172.22.67.145] (localhost [127.0.0.1])
	by gate.cowlark.com (Postfix) with ESMTP id EE5E8200A6
	for <linux-sparse@vger.kernel.org>; Thu, 30 Apr 2009 11:13:42 +0100 (BST)
In-Reply-To: <70318cbf0904291641w30f19372ne95e98d1030964cf@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

Christopher Li wrote:
[...]
> I think some of your patch already went into sparse. If there are some
> missing. Feel free to submit it again.

The bulk of it's the byte-size patch, which has already made it in, and 
the rest is Clue-specific tweaks (like keeping type information in 
pseudos, and so on).

[...]
> If every back end needs to do those "simplifications", that means sparse
> should be fixed to do it right.

Actually that stuff's in Clue rather than in the patch --- things like 
ultra-simple register allocation, flattening Sparse's parse tree to 
Clue's backend model, etc. None of this really makes sense for anything 
involving a real compiler (for example, Clue assumes you have an 
infinite number of registers available).

In fact, now I think of it, Clue also has a rather intrinsic assumption 
that sizeof(int) == sizeof(char) == 1, which means it wouldn't work with 
llvm out of the box. It may be productive to rip off some of the code, 
though.

-- 
David Given
dg@cowlark.com
