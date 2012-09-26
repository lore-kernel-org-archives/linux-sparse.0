From: Daniel Santos <danielfsantos@att.net>
Subject: Re: [PATCH v5 0/25] Generic Red-Black Trees (still WIP)
Date: Tue, 25 Sep 2012 20:02:46 -0500
Message-ID: <50625436.1020501@att.net>
References: <1348615467-9850-1-git-send-email-daniel.santos@pobox.com> <1348618742.22822.39.camel@gandalf.local.home>
Reply-To: Daniel Santos <daniel.santos@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1348618742.22822.39.camel@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-doc@vger.kernel.org, linux-sparse@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-sparse@vger.kernel.org


>> Q&A
>> ===
>> Q: Why did you add BUILD_BUG_ON_NON_CONST() and
>>    BUILD_BUG_ON_NON_CONST42()?
> A: Because BUILD_BUG_ON_NON_CONST42() will crash if it does not result
> in the answer to life, the universe and everything!

By the way, I have a theory before time, God was writing code on some
cosmic computer (beyond our understanding, of course) when he
accidentally tried to divide by zero, resulting in a core dump that we
now know as the universe we live in.  So thus, we are just the excrement
of some celestial computer after it failed to properly execute its code.

Daniel
