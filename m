From: Christopher Li <sparse@chrisli.org>
Subject: suggestion for Merging LLVM
Date: Mon, 21 Nov 2011 18:43:07 -0800
Message-ID: <CANeU7QkLTOaH7LNiyTEmUOrWb4Tb39+HKM0xPnowL5s0Qbbwyw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:58989 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753497Ab1KVCnH (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 21 Nov 2011 21:43:07 -0500
Received: by ywt32 with SMTP id 32so5420735ywt.19
        for <linux-sparse@vger.kernel.org>; Mon, 21 Nov 2011 18:43:07 -0800 (PST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Pekka Enberg <penberg@kernel.org>
Cc: Jeff Garzik <jgarzik@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, Linux-Sparse <linux-sparse@vger.kernel.org>

Hi Pekka,

I already tag the sparse 0.4.4 release in git. Just waiting
for getting the release directory setup on kernel.org and it
is ready to go.

Now I am looking at your LLVM repository and the llvm patches.
I don't have a good sense for the later patch without looking at the
earlier changes.

I haven't done big repository merge before, this is the first one.
So I am looking for suggestion what is the best practice here.

Do we care about clean up the history and import the changes
step by step as patches or just a plain git merge of the LLVM
repository?

Thanks

Chris
