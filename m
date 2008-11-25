From: "Alexey Zaytsev" <alexey.zaytsev@gmail.com>
Subject: Re: unable to open limits.h
Date: Tue, 25 Nov 2008 16:03:24 +0300
Message-ID: <f19298770811250503w3692ebf6nb3026ba551da4523@mail.gmail.com>
References: <20081125110703.GA23049@infradead.org>
	 <f19298770811250418p154bad86qf926c464d16aef02@mail.gmail.com>
	 <20081125122732.GA2035@uranus.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.174]:29871 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751304AbYKYNDZ (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 25 Nov 2008 08:03:25 -0500
Received: by wf-out-1314.google.com with SMTP id 27so2767400wfd.4
        for <linux-sparse@vger.kernel.org>; Tue, 25 Nov 2008 05:03:25 -0800 (PST)
In-Reply-To: <20081125122732.GA2035@uranus.ravnborg.org>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Christoph Hellwig <hch@infradead.org>, linux-sparse@vger.kernel.org, Josh Triplett <josh@kernel.org>

On Tue, Nov 25, 2008 at 15:27, Sam Ravnborg <sam@ravnborg.org> wrote:
> On Tue, Nov 25, 2008 at 03:18:58PM +0300, Alexey Zaytsev wrote:
>> On Tue, Nov 25, 2008 at 14:07, Christoph Hellwig <hch@infradead.org> wrote:
>> > On Ubuntu 8.10 (glibc 2.8.90) I get the following warnings when
>> > compiling any program using limits.h:
>> >
>> > /usr/include/limits.h:125:17: error: unable to open 'limits.h'
>>
>> This is probably fixed by
>> http://git.zaytsev.su/git?p=sparse.git;a=commitdiff;h=6f089b22a222dd086d14c985c5a67f8b3afd2177
>
> Is this the right fix?
> We should not rely on that sparse is built with the same gcc as currently installed.
>
> The fix should be that we automagically uses the right path which
> is available on the system.
>
I see no magic way to find the right path, except specifying which gcc version
sparse would have to follow. Probably cgcc could pass it to sparse, but anyway,
this would probably be an other patch. Mine does not change the way
sparse works,
only adds the new include dir, which should not harm the

>>
>> Josh, please pull the gsoc2008-up branch from git://zaytsev.su/git/sparse.git
> For a pull request itis prefarable that you always include:
> - diffstat
> - shortlog
> - short intor what is contained

The branch contains cleanups and other straight-forward changes gained as as a
side-effect of my sparse linker work this summer. Josh has already agreed on the
patches, but was too busy and pobably forgot to pull. Anyway, there is
the shortlog:

Alexey Zaytsev (9):
      Make show_symbol newline-consistent
      Looks more evident this way.
      Handle a terminal -o option properly.
      Mark handle_switch as static and don't export it from lib.h
      Handle missing argument to -D.
      Gdb macros to get a better look at some sparse data structures.
      A slightly edited irc discussion with Josh Triplett.
      Add $GCC_BASE/include-fixed to the include list.
      Warning should be enough for an unhandled transparent union

The patches seem to be too trivial to discuss. For the non-trivial
patches from the
gsoc2008-linker branch I got constructive feedback and will probably
rework the idea.
