From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: Potential incorrect simplification
Date: Sun, 6 Aug 2017 16:00:36 +0200
Message-ID: <20170806140035.f2tqkmiufjytiwri@ltop.local>
References: <CACXZuxeRXsYWgwihs1nmmTYaLoyhw+PDAy6jEemkZJFpySdfQA@mail.gmail.com>
 <CAExDi1TtcpZtnEV6ctyA9MacJA_9h4njmhd-MSA3KgOq8oK_gA@mail.gmail.com>
 <CACXZuxfxNNh+ThcT=7Xr98tToL2GimFi7UOTSwgNq6mfLLGNfA@mail.gmail.com>
 <20170328141113.kbrwdva6ttsrokts@macpro.local>
 <CACXZuxen9UFGNp8=-OQHoqRQJ5F__rwQoCJJ6TdkAo6HEXWOQw@mail.gmail.com>
 <CA+55aFx6g3-+6tJ_6Uqu4K1pQoDnqcXrjSGYsryLjjksEtT06A@mail.gmail.com>
 <CANeU7Qk-4U2G_6CZ7KHbGZiqRe9=fpNOzE4eyfLjz3fnd_n3ww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:37905 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751256AbdHFOAk (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 6 Aug 2017 10:00:40 -0400
Received: by mail-wm0-f65.google.com with SMTP id y206so10891590wmd.5
        for <linux-sparse@vger.kernel.org>; Sun, 06 Aug 2017 07:00:39 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CANeU7Qk-4U2G_6CZ7KHbGZiqRe9=fpNOzE4eyfLjz3fnd_n3ww@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Sun, Aug 06, 2017 at 08:46:10AM -0400, Christopher Li wrote:
> On Tue, Mar 28, 2017 at 12:20 PM, Linus Torvalds
> > becomes
> >
> >         and.32      %r3 <- %r4, $-65
> >         or.32       %r4 <- %r3, $64
> 
> Sorry I wasn't able to participate this discussion earlier. I am catching
> up at the important sparse mailing list discussion. This is one of them.
> 
> This has puzzle me for a long time. From the looks it seems %4 was
> used before it was define. Is that legal SSA form?

What do you mean exactly by "legal SSA form"?

As I've already tried to explain you several times:
	it's a *symptom* that something have been wrong, either:
	- the initial code had some undefined variables
	- it's an internal bug.

In both cases you can't do anymore 'normal' processing on it.
In this sense it's "illegal".

The other way to see it is something like: "ok, this means that the
pseudo was not initialized" (and ignore the internal bug aspect) and
then process it as such (for example choose any value you like for it).
You can call this "a new/legal SSA form" if you like but it will only
confuse discussion and won't change it's nature.

-- Luc
