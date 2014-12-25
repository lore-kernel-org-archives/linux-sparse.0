From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] sparse: Use memmove in sort.c
Date: Fri, 26 Dec 2014 00:19:30 +0800
Message-ID: <CANeU7QmRbDacRp00JHr8Eofs03snJtqye_qKwOCDTos-Zm=8XA@mail.gmail.com>
References: <1419341933-17244-1-git-send-email-rv@rasmusvillemoes.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qc0-f170.google.com ([209.85.216.170]:64591 "EHLO
	mail-qc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752391AbaLYQTb (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 25 Dec 2014 11:19:31 -0500
Received: by mail-qc0-f170.google.com with SMTP id x3so6835762qcv.29
        for <linux-sparse@vger.kernel.org>; Thu, 25 Dec 2014 08:19:30 -0800 (PST)
In-Reply-To: <1419341933-17244-1-git-send-email-rv@rasmusvillemoes.dk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Rasmus Villemoes <rv@rasmusvillemoes.dk>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Tue, Dec 23, 2014 at 9:38 PM, Rasmus Villemoes <rv@rasmusvillemoes.dk> wrote:
> Using valgrind on the example ctags program I get
>
> ==16863== Source and destination overlap in memcpy(0x7ff000100, 0x7ff000108, 192)
> ==16863==    at 0x4C2A690: memcpy (mc_replace_strmem.c:838)
> ==16863==    by 0x412D86: merge_block_seqs (sort.c:207)
> ==16863==    by 0x41303C: sort_list (sort.c:275)
> ==16863==    by 0x401225: main (ctags.c:224)
>
> Fix it by using memmove instead of memcpy.

This bug has been fixed in the chrisl repository as commit:
6c2d743d2f130a8bf9014410f928bae3647e3108

The first memcpy is fine, one of the buffer is in the stack, the ptr
pointer is allocated using mmap. So they will never overlap.

The second memcpy is a real bug. It has been reported by Hans Verkuil.
It took me a while to fix the real cause. Because the corrupted
ptr list still contain valid ptr pointers. The symptoms has very odd
duplicate entries. It took me a while to find out the real cause.

If you send this patch earlier, it would have save me a lot of time.

Chris
