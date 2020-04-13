From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH 15/17] scope: give a scope for labels & gotos
Date: Tue, 14 Apr 2020 01:39:00 +0200
Message-ID: <20200413233900.t7fczyyqrees5gwr@ltop.local>
References: <20200413161605.95900-1-luc.vanoostenryck@gmail.com>
 <20200413161605.95900-16-luc.vanoostenryck@gmail.com>
 <CAHk-=wiy-BFXMpmm9-GNT_WtDKVLeR0ki4OTj83xPk=npuNSHA@mail.gmail.com>
 <20200413185452.pgj75pj5g7a42kik@ltop.local>
 <CAHk-=wjMSeVVQHZ23=HJ3V-yYPooeuHNHmZtexUVRKg_e5VMXA@mail.gmail.com>
 <CAHk-=whNLSTtSsmMD5a6D3s_LtjEYwZPWOSvUdz4mCd5kFO26Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727804AbgDMXjD (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 13 Apr 2020 19:39:03 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38EAAC0A3BDC
        for <linux-sparse@vger.kernel.org>; Mon, 13 Apr 2020 16:39:03 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id a201so11580311wme.1
        for <linux-sparse@vger.kernel.org>; Mon, 13 Apr 2020 16:39:03 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAHk-=whNLSTtSsmMD5a6D3s_LtjEYwZPWOSvUdz4mCd5kFO26Q@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>

On Mon, Apr 13, 2020 at 03:40:55PM -0700, Linus Torvalds wrote:
> On Mon, Apr 13, 2020 at 12:32 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > I _feel_ like the fix to that should be that the only thing that
> > creates the actual symbol is the label definition, and that the goto
> > should only ever use the 'ident' and we'd tie the two together later.
> 
> Actually, how about something like this?
> 
> I've not signed off on these patches, and the commit logs are
> questionable, but part of that is that the two first ones are just
> quick-and-dirty versions of your rename cleanups.
> 
> The third patch is the serious one, which shows what I think might be
> the solution to the odd scoping rules for labels.
> 
> Basically, we always scope labels - but if a label is _used_ but not
> defined in an inner label, when we close the label scope, we move it
> out to the next level.
> 
> But a defined label is never moved out, and when we define it, we
> require that any previous use was in the same scope (where "same
> scope" might have been an inner scope that was moved out).
> 
> I think it gets the semantics right, and it's actually fairly simple.
> 
> But it has very little testing, so this is more of a "how about
> something like this" than a serious submission.
> 
> If you test it, and fix up the warnings and error cases (like the
> other patches in your series did), you are more than welcome to take
> credit and authorship for this.
> 
> I just felt that the best way to describe (and do _some_ testing) my
> idea was to have a quick implementation to show what I mean.
> 
> And by "_some_ testing" I literally mean "almost no testing at all". I
> didn't even run this on the kernel tree. I just used one stipid small
> test-case for this, and when it gave the warning I wanted, I said
> "good enough" and sent this email out ;)

I like the idea. I just gave it a very quick test with sparse's
"make check" (it covers a lot of simple but corner/dirty cases that
the kernel may/should not have). It seemed to pass all the tests but
the ones using __label__. For exemple, things like this complain:
	{
		__label__ l;

	l:
		goto l;
	}

I'll look more at it tommorow as it's a bit late here. I just fear
that __label__ will spoil things here or at least complicate them.

-- Luc
