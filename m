From: Jeff Garzik <jeff@garzik.org>
Subject: Re: suggestion for Merging LLVM
Date: Tue, 22 Nov 2011 00:52:49 -0500
Message-ID: <4ECB38B1.8020803@garzik.org>
References: <CANeU7QkLTOaH7LNiyTEmUOrWb4Tb39+HKM0xPnowL5s0Qbbwyw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:40665 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753074Ab1KVFwx (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 22 Nov 2011 00:52:53 -0500
Received: by vcbfk1 with SMTP id fk1so6409685vcb.19
        for <linux-sparse@vger.kernel.org>; Mon, 21 Nov 2011 21:52:52 -0800 (PST)
In-Reply-To: <CANeU7QkLTOaH7LNiyTEmUOrWb4Tb39+HKM0xPnowL5s0Qbbwyw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Pekka Enberg <penberg@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Linux-Sparse <linux-sparse@vger.kernel.org>

On 11/21/2011 09:43 PM, Christopher Li wrote:
> Hi Pekka,
>
> I already tag the sparse 0.4.4 release in git. Just waiting
> for getting the release directory setup on kernel.org and it
> is ready to go.
>
> Now I am looking at your LLVM repository and the llvm patches.
> I don't have a good sense for the later patch without looking at the
> earlier changes.
>
> I haven't done big repository merge before, this is the first one.
> So I am looking for suggestion what is the best practice here.
>
> Do we care about clean up the history and import the changes
> step by step as patches or just a plain git merge of the LLVM
> repository?

I don't see any reason to import step-by-step as patches.

Either merge it as a single "add incomplete LLVM backend" commit, 
dropping all pre-upstream history, or git merge.

FWIW I am sorta stuck; cannot figure out how to make 'phi' operation in 
LLVM work the way we need it to.  That is a crucial hurdle needed for 
loops.  LLVM fundamentally should be able to do it, but I'm not sure 
this works within the C API.  I was thinking my next step would be to 
whine on the llvm list.

A workaround is to resuscitate unssa() call, and all that entails.

	Jeff





