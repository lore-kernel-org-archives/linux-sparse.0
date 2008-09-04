From: "Christopher Li" <sparse@chrisli.org>
Subject: [0/2] RFC: sparse bytecode writer
Date: Wed, 3 Sep 2008 22:34:21 -0700
Message-ID: <70318cbf0809032234i6b57d5b9i3bb4be11e824898e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.154]:29631 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751604AbYIDFeX (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 4 Sep 2008 01:34:23 -0400
Received: by fg-out-1718.google.com with SMTP id 19so337535fgg.17
        for <linux-sparse@vger.kernel.org>; Wed, 03 Sep 2008 22:34:21 -0700 (PDT)
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>, Alexey Zaytsev <alexey.zaytsev@gmail.com>, Josh Triplett <josh@freedesktop.org>

Hi,

I have been hacking on the sparse code dumper for a while.
Recently there seems some interested in this, so I resurrect
my patches.

The dumper works on the native C structure. It convert the pointer
inside the struct into index numbers. Hopefully on loading, the
same pointer traverse can convert the index back to object
pointer.

Currently there is no attempt to compress the C structure it
writes. So the result is huge, about 50x compare to the stripped
.o file on i386.  But it give a very good idea how much memory.

It needs to load such an object file though.

the reader is not ready yet.

Chris
