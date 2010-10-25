From: Christopher Li <sparse@chrisli.org>
Subject: Re: bad asm goto ?
Date: Mon, 25 Oct 2010 15:10:29 -0700
Message-ID: <AANLkTikVt5BJ+2W3P+wYUR3DLzhTatXhAW45wdc0eoOe@mail.gmail.com>
References: <20101025213145.GA1822@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:36941 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756836Ab0JYWKa (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 25 Oct 2010 18:10:30 -0400
Received: by iwn10 with SMTP id 10so1321167iwn.19
        for <linux-sparse@vger.kernel.org>; Mon, 25 Oct 2010 15:10:29 -0700 (PDT)
In-Reply-To: <20101025213145.GA1822@redhat.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dave Jones <davej@redhat.com>
Cc: linux-sparse@vger.kernel.org

On Mon, Oct 25, 2010 at 2:31 PM, Dave Jones <davej@redhat.com> wrote:
> I just ran sparse on a kernel tree for the first time in ages, and got
> hundreds of warnings, many of which related to the tracepoint macros
> in the kernel, which use the new asm goto feature.
>
> Looking at the git log of sparse, I see there was some support added
> for asm goto, but it seems to choke every time, printing ..
>
> include/trace/events/kmem.h:45:1: error: bad asm output
> include/trace/events/kmem.h:45:1: error: incompatible types in comparison expression (different address spaces)
>
>
> (this is with a sparse built from git head from a few minutes ago)

Do you have a smaller test case to reproduce the error?

Chris
