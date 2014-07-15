From: Christopher Li <sparse@chrisli.org>
Subject: Re: [sparse PATCH RFC] Revert "Revert "sparse: Bump up sizeof(_Bool)
 to 8 bits""
Date: Tue, 15 Jul 2014 12:51:02 -0700
Message-ID: <CANeU7QnRHvOQHHE2EEWNSUEwFRv66gmHfNXmgZxN+_J7=iPbHg@mail.gmail.com>
References: <1405439200-27515-1-git-send-email-jlayton@primarydata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:39041 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933003AbaGOTvE (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 15 Jul 2014 15:51:04 -0400
Received: by mail-qc0-f174.google.com with SMTP id o8so2568140qcw.33
        for <linux-sparse@vger.kernel.org>; Tue, 15 Jul 2014 12:51:02 -0700 (PDT)
In-Reply-To: <1405439200-27515-1-git-send-email-jlayton@primarydata.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Jeff Layton <jlayton@primarydata.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Pekka Enberg <penberg@kernel.org>

On Tue, Jul 15, 2014 at 8:46 AM, Jeff Layton <jlayton@primarydata.com> wrote:
>
>
> The problem here is that, at least with GCC on x86_64, a _Bool always
> seems to be end up being 8 bits (which makes sense -- how would you get
> a pointer to it otherwise?). If you declare and initialize an array like
> this:
>
>     static _Bool boolarray[3] = {
>             [0] = 1,
>             [1] = 1,
>     };
>
> ...you get warnings like this (which are bogus):
>
>     ./test.c:2:10: warning: Initializer entry defined twice
>     ./test.c:3:10:   also defined here


Right.  The bug is in bits_to_bytes(). It round down instead of
round up. "bits_in_bool" is only a default value. It can be
reset to other value by the sparse application (sparse as
library). So the rest of the code still need to coupe with
it.

 How about fix bits_to_bytes() to round up:

diff --git a/target.h b/target.h
index 1030c7c..140df3c 100644
--- a/target.h
+++ b/target.h
@@ -49,7 +49,7 @@ extern int enum_alignment;

 static inline int bits_to_bytes(int bits)
 {
-       return bits >= 0 ? bits / bits_in_char : -1;
+       return bits >= 0 ? (bits + bits_in_char - 1) / bits_in_char : -1;
 }

>
> integer division, and that causes the above bogus warning.
>
> Reset it back to 8 bits, and add a validation test that creates the
> above array to ensure that we don't end up breaking it again.

The rest of the change looks good. Thanks for the test case.

My patch is not tested. If you are OK with it, submit a V2
or I can fix the change for you.

Thanks

Chris
