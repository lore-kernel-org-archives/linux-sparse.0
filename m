From: Jeff Garzik <jeff@garzik.org>
Subject: Re: suggestion for Merging LLVM
Date: Tue, 22 Nov 2011 23:11:25 -0500
Message-ID: <4ECC726D.8060406@garzik.org>
References: <CANeU7QkLTOaH7LNiyTEmUOrWb4Tb39+HKM0xPnowL5s0Qbbwyw@mail.gmail.com> <4ECB38B1.8020803@garzik.org> <1321941674.1428.124.camel@jaguar> <4ECC06F7.8040006@garzik.org> <CAOJsxLGqsH9vbE9AQO2chV28Wx=iw5hA9dJzR3X1Cvrd5Sv6Eg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:45392 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756042Ab1KWEL2 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 22 Nov 2011 23:11:28 -0500
Received: by vbbfc26 with SMTP id fc26so56651vbb.19
        for <linux-sparse@vger.kernel.org>; Tue, 22 Nov 2011 20:11:27 -0800 (PST)
In-Reply-To: <CAOJsxLGqsH9vbE9AQO2chV28Wx=iw5hA9dJzR3X1Cvrd5Sv6Eg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Pekka Enberg <penberg@kernel.org>
Cc: Christopher Li <sparse@chrisli.org>, Linus Torvalds <torvalds@linux-foundation.org>, Linux-Sparse <linux-sparse@vger.kernel.org>

On 11/22/2011 03:38 PM, Pekka Enberg wrote:
> So pasting the above test program tohttp://llvm.org/demo/  and
> switching to "LLVM C++ API code" target seems to suggest you're
> interested in the LLVMReplaceAllUsesWith() API for forward references.

Cute trick, outputting C++ API code.  I think LLVMReplaceAllUsesWith() 
may indeed be precisely what I needed.

Thanks,

	Jeff


