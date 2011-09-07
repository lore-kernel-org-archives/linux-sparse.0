From: Pekka Enberg <penberg@gmail.com>
Subject: [sparse-llvm] LLVM and alignment
Date: Wed, 7 Sep 2011 08:40:24 +0300
Message-ID: <CAOJsxLGMtC1sV7-OvW_+uRQHm4=HiWtC-Bfk3RYsy-GmCuhPfg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:38139 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753695Ab1IGFrg (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 7 Sep 2011 01:47:36 -0400
Received: by ywf7 with SMTP id 7so4650076ywf.19
        for <linux-sparse@vger.kernel.org>; Tue, 06 Sep 2011 22:47:36 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, Linus Torvalds <torvalds@linux-foundation.org>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>, Christopher Li <sparse@chrisli.org>, Pekka Enberg <penberg@cs.helsinki.fi>

Hi,

I looked at adding struct support yesterday and it seems rather
straight-forward. I'll hopefully have a working patch today. I noticed
one issue with alignment, though.

The LLVMStructType() function wants to know if a structure is packed
or not. Initially I thought we can just make all structures non-packed
since sparse takes care of that and sets up alignment to 1 byte.
Unfortunately I then noticed that LLVM doesn't actually seem to allow
you to change _type alignment_ but only _value alignment_. The latter
is done with the LLVMSetAlignment() function and seems to be limited
to global variables.

Jeff, any ideas?

                        Pekka
