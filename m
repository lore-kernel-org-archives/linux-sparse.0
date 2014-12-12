From: Christopher Li <sparse@chrisli.org>
Subject: Re: Bogus 'Initializer entry defined twice' warnings
Date: Fri, 12 Dec 2014 12:32:47 +0800
Message-ID: <CANeU7Qko4VY_hZbuuNVLbRjaiEeFAyb8VLDmew0zSz1SYrPA9w@mail.gmail.com>
References: <5400357A.5050705@xs4all.nl>
	<CANeU7Q=q7AL=nh2BGfHyAYqjHbMu9cu3NbR7Jkfw4wd+SPRWUA@mail.gmail.com>
	<5481B580.3080100@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qc0-f172.google.com ([209.85.216.172]:50116 "EHLO
	mail-qc0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965322AbaLLEcs (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 11 Dec 2014 23:32:48 -0500
Received: by mail-qc0-f172.google.com with SMTP id m20so5110400qcx.3
        for <linux-sparse@vger.kernel.org>; Thu, 11 Dec 2014 20:32:47 -0800 (PST)
In-Reply-To: <5481B580.3080100@xs4all.nl>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Hans Verkuil <hverkuil@xs4all.nl>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>

On Fri, Dec 5, 2014 at 9:39 PM, Hans Verkuil <hverkuil@xs4all.nl> wrote:
>> Still need more work to fix it.
>
> Any updates on this?
>

The search is over.

    Ptr list sorting should use memmove instead of memcpy

    The target buffer is overlapped with source buffer.
    This cause the duplicate entry warning reported by Hans.

    Reported-by: Hans Verkuil <hverkuil@xs4all.nl>
    Signed-off-by: Christopher Li <sparse@chrisli.org>

diff --git a/sort.c b/sort.c
index afd7184..430ba44 100644
--- a/sort.c
+++ b/sort.c
@@ -99,7 +99,7 @@ static void verify_seq_sorted (struct ptr_list *l, int n,
        assert (nbuf >= nr);                                    \
        memcpy ((b)->list, buffer, nr * sizeof (void *));       \
        nbuf -= nr;                                             \
-       memcpy (buffer, buffer + nr, nbuf * sizeof (void *));   \
+       memmove (buffer, buffer + nr, nbuf * sizeof (void *));  \
   } while (0)


Chris
