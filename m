From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 1/5] sparse: Show expected vs. actual output on test failure
Date: Tue, 23 Aug 2011 15:32:19 -0700
Message-ID: <CANeU7Q=oqi044rJYbZ1XnwJovEL-9WV8xW83-LDC23n-GVTxiQ@mail.gmail.com>
References: <1314021451-24808-1-git-send-email-penberg@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:41236 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753515Ab1HWWcU (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 23 Aug 2011 18:32:20 -0400
Received: by qyk34 with SMTP id 34so447021qyk.19
        for <linux-sparse@vger.kernel.org>; Tue, 23 Aug 2011 15:32:19 -0700 (PDT)
In-Reply-To: <1314021451-24808-1-git-send-email-penberg@kernel.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Pekka Enberg <penberg@kernel.org>
Cc: linux-sparse@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>

On Mon, Aug 22, 2011 at 6:57 AM, Pekka Enberg <penberg@kernel.org> wrote:
> This patch changes 'make check' output to show sparse output compared to
> expected results upon unexpected test failure. For example,
> static-forward-decl.c output would look like this if it would not be tagged as
> "known to fail":

I like that. Some minor suggestion:

There are two files to check for,  "output" and "error".
"$stream" is the loop variable. You only print the last one in the loop.
The "output" diff file does not show.

I think we might just give the same error message for
"known to fail" case as well. Yes, it is annoying to see them,
but that is the point, we want to fix them.

Chris
