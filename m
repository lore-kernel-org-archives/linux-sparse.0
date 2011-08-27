From: Pekka Enberg <penberg@kernel.org>
Subject: Re: [PATCH 1/5] sparse: Show expected vs. actual output on test
 failure
Date: Sat, 27 Aug 2011 11:20:04 +0300 (EEST)
Message-ID: <alpine.DEB.2.00.1108271114560.2570@localhost6.localdomain6>
References: <1314021451-24808-1-git-send-email-penberg@kernel.org> <CANeU7Q=oqi044rJYbZ1XnwJovEL-9WV8xW83-LDC23n-GVTxiQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:62635 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751023Ab1H0IUK (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 27 Aug 2011 04:20:10 -0400
Received: by bke11 with SMTP id 11so3055737bke.19
        for <linux-sparse@vger.kernel.org>; Sat, 27 Aug 2011 01:20:08 -0700 (PDT)
In-Reply-To: <CANeU7Q=oqi044rJYbZ1XnwJovEL-9WV8xW83-LDC23n-GVTxiQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: linux-sparse@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>

On Tue, 23 Aug 2011, Christopher Li wrote:
> I think we might just give the same error message for
> "known to fail" case as well. Yes, it is annoying to see them,
> but that is the point, we want to fix them.

No, people who did not break them should not need to see the errors! If 
you're going to have a "known to fail" flag, then it really should be 
silent *by default*. When I run make check, I want to know I didn't break 
anything. If someone flagged a test as "known to fail", I really don't 
need to care about it.

Alternatively, we could get rid of the "known to fail" tag completely and 
just make sure the tests pass all the time. I actually wanted to do that 
but didn't have the skills to fix the remaining issues ;-)

 			Pekka
