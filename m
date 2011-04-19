From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 0/2] Fix 'already_tokenized()' performance problem
Date: Tue, 19 Apr 2011 15:09:17 -0700
Message-ID: <BANLkTi=UCwafS-qUccpQ=AGBbe=TPqZ3kA@mail.gmail.com>
References: <alpine.LFD.2.02.1104191108330.21972@i5.linux-foundation.org> <BANLkTi=5mCuOWYZ_7Cav2jbLZ1DVUyyjag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:50999 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752349Ab1DSWKK (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 19 Apr 2011 18:10:10 -0400
Received: from mail-gy0-f174.google.com (mail-gy0-f174.google.com [209.85.160.174])
	(authenticated bits=0)
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id p3JM9be0031741
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=FAIL)
	for <linux-sparse@vger.kernel.org>; Tue, 19 Apr 2011 15:09:38 -0700
Received: by gyd10 with SMTP id 10so48142gyd.19
        for <linux-sparse@vger.kernel.org>; Tue, 19 Apr 2011 15:09:37 -0700 (PDT)
In-Reply-To: <BANLkTi=5mCuOWYZ_7Cav2jbLZ1DVUyyjag@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: linux-sparse@vger.kernel.org

On Tue, Apr 19, 2011 at 2:52 PM, Christopher Li <sparse@chrisli.org> wrote:
>
> I am suppressed that you can get 3-4% from just comparing the stream names.

I was too. But the kernel sources have gotten more complicated, and
"input_stream_number" can get very high. Having 200 streams is common,
and 400 streams is not unusual for some more complex kernel files that
include a lot of files.

So what happened was that a single '#include" at the end of such a
situation would compare the pathname against hundreds of longish
strings. So it ends up O(n**2) in number of #includes - each strcmp is
cheap, but there's a _lot_ of them.

I don't remember these kinds of numbers from years ago when I did more
profiling, but I suspect the kernel tree has gotten way more
include-happy too.

                     Linus
