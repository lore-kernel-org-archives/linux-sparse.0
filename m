From: Pekka Enberg <penberg@kernel.org>
Subject: Re: [PATCH 1/5] sparse: Show expected vs. actual output on test
 failure
Date: Sat, 27 Aug 2011 11:24:48 +0300 (EEST)
Message-ID: <alpine.DEB.2.00.1108271120160.2570@localhost6.localdomain6>
References: <1314021451-24808-1-git-send-email-penberg@kernel.org> <4E576300.2070609@kernel.org> <CANeU7QmRy+M92U-eTjrgtJRuR9M5fUZUgHofQDm8GjwMMbQong@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:61333 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751065Ab1H0IYw (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 27 Aug 2011 04:24:52 -0400
Received: by bke11 with SMTP id 11so3057128bke.19
        for <linux-sparse@vger.kernel.org>; Sat, 27 Aug 2011 01:24:51 -0700 (PDT)
In-Reply-To: <CANeU7QmRy+M92U-eTjrgtJRuR9M5fUZUgHofQDm8GjwMMbQong@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: linux-sparse@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>

On Fri, 26 Aug 2011, Christopher Li wrote:
>> Your patch now makes the runner verbose for "known to fail" tests
>> which is definitely not something we should do. If someone tagged
>> the test as "known to fail", we should treat it just like we treat
>> passed test cases.
>
> That is intentional. I haven't seen you reply on my comment so I take
> the liberty to change it. I do want to see the "known to fail" test
> case.

Sorry about that. I somehow missed the email.

>> The whole point of my patch was to make "make check" pinpoint
>> *unexpected* breakage so that anyone who bothers to do "make check"
>> on their patches can never cause regressions.
>
> How to you know your new patch did not break "known to fail" test
> case in a different way than originally? It could be regression as well.

I think that's irrelevant, really. I happen to think it's completely 
pointless to even run test cases that are "known to fail" because it 
creates confusion and adds little value.

And if we really care that a "known to fail" test case fails in a certain 
way, we can turn it into a "known _not_ to fail" and assert the exact 
failure case.

> You can diff the aggregate output of "make check" before and after
> the new patch to see if the new patch affect any test case at all.
> That is better than blindly skip the "known to fail" test case.

No, that doesn't scale at all if you run "make check" every few minutes 
like I do.

> Yes, I have a different usage case in mind. I want to look at what currently
> breaks. In the long run, hopefully we fix all the known issues so this
> wouldn't be any issue at all.

Agreed.

> You can submit a patch to add a config for it if you are so insist on
> the "I don't care about already broken test cases" usage case.
> To me, diff the "make check" output is straightly better.

OK, a flag would definitely work for me.

 			Pekka
