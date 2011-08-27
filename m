From: Pekka Enberg <penberg@kernel.org>
Subject: Re: [PATCH] sparse: Reduce 'test-suite' run output
Date: Sat, 27 Aug 2011 11:13:17 +0300 (EEST)
Message-ID: <alpine.DEB.2.00.1108271112110.2570@localhost6.localdomain6>
References: <1314366621-29361-1-git-send-email-penberg@kernel.org> <CANeU7Q=xTrKKCkuB4_RcA7L=99=psZAWQiawqSLMMyOUK6E-jQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463808768-2065544413-1314432799=:2570"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:58505 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750960Ab1H0INW (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 27 Aug 2011 04:13:22 -0400
Received: by bke11 with SMTP id 11so3053653bke.19
        for <linux-sparse@vger.kernel.org>; Sat, 27 Aug 2011 01:13:21 -0700 (PDT)
In-Reply-To: <CANeU7Q=xTrKKCkuB4_RcA7L=99=psZAWQiawqSLMMyOUK6E-jQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: linux-sparse@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463808768-2065544413-1314432799=:2570
Content-Type: TEXT/PLAIN; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT

On Fri, 26 Aug 2011, Christopher Li wrote:

> On Fri, Aug 26, 2011 at 6:50 AM, Pekka Enberg <penberg@kernel.org> wrote:
>> There's more than 100 tests in the validation test suite. That makes it
>> cumbersome to notice test breakage in because the results don't fit on single
>> page.
>
> Looks good in a terminal. But if the output is piped to a file, it will be hard
> to read that file. We shouldn't do it for a non-terminal output.

Right. How can I check if we're outputting to non-terminal?

>> +                       echo ""
>
> Why not just "echo" instead. Without any argument, echo will just output "\n".

No reason, I'm just really bad at writing shell scripts. :-)

I'll fix that up!
---1463808768-2065544413-1314432799=:2570--
