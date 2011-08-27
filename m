From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 1/5] sparse: Show expected vs. actual output on test failure
Date: Fri, 26 Aug 2011 18:58:30 -0700
Message-ID: <CANeU7QmRy+M92U-eTjrgtJRuR9M5fUZUgHofQDm8GjwMMbQong@mail.gmail.com>
References: <1314021451-24808-1-git-send-email-penberg@kernel.org>
	<4E576300.2070609@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:59234 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750919Ab1H0B6b (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 26 Aug 2011 21:58:31 -0400
Received: by qwk3 with SMTP id 3so2375954qwk.19
        for <linux-sparse@vger.kernel.org>; Fri, 26 Aug 2011 18:58:31 -0700 (PDT)
In-Reply-To: <4E576300.2070609@kernel.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Pekka Enberg <penberg@kernel.org>
Cc: linux-sparse@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>

On Fri, Aug 26, 2011 at 2:10 AM, Pekka Enberg <penberg@kernel.org> wrote:
> Chris, the patch you committed is different from mine:
>
> http://git.kernel.org/?p=devel/sparse/chrisl/sparse.git;a=commitdiff;h=a7a00d5108c36b8baaf54814aa1f42583dabc754
>
> Your patch now makes the runner verbose for "known to fail" tests
> which is definitely not something we should do. If someone tagged
> the test as "known to fail", we should treat it just like we treat
> passed test cases.

That is intentional. I haven't seen you reply on my comment so I take
the liberty to change it. I do want to see the "known to fail" test
case.

>
> The whole point of my patch was to make "make check" pinpoint
> *unexpected* breakage so that anyone who bothers to do "make check"
> on their patches can never cause regressions.

How to you know your new patch did not break "known to fail" test
case in a different way than originally? It could be regression as well.

You can diff the aggregate output of "make check" before and after
the new patch to see if the new patch affect any test case at all.
That is better than blindly skip the "known to fail" test case.

Yes, I have a different usage case in mind. I want to look at what currently
breaks. In the long run, hopefully we fix all the known issues so this
wouldn't be any issue at all.

You can submit a patch to add a config for it if you are so insist on
the "I don't care about already broken test cases" usage case.
To me, diff the "make check" output is straightly better.

Chris
