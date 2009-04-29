From: Christopher Li <sparse@chrisli.org>
Subject: Re: `char * s = "abc";' causes compile to crash with a segfault
Date: Wed, 29 Apr 2009 16:41:05 -0700
Message-ID: <70318cbf0904291641w30f19372ne95e98d1030964cf@mail.gmail.com>
References: <op.us51m0w9ucb9g9@home-5db3af48a> <49F8C1EB.5010909@garzik.org>
	 <49F8D803.6080000@cowlark.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.249]:45181 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751104AbZD2XlI (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 29 Apr 2009 19:41:08 -0400
Received: by an-out-0708.google.com with SMTP id d40so1118381and.1
        for <linux-sparse@vger.kernel.org>; Wed, 29 Apr 2009 16:41:08 -0700 (PDT)
In-Reply-To: <49F8D803.6080000@cowlark.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: David Given <dg@cowlark.com>
Cc: linux-sparse@vger.kernel.org

On Wed, Apr 29, 2009 at 3:43 PM, David Given <dg@cowlark.com> wrote:
>
> In addition, I found a number of places where minor tweaks to what data
> Sparse keeps around can make a compiler writer's life much easier; for
> example, keeping more type data makes finding the type of a pseudo much
> easier. There's a combined patch shipped with Clue that fixes and
> enhances a bunch of this stuff:
>
> http://cluecc.svn.sourceforge.net/viewvc/cluecc/clue/sparse.patch?revision=34&view=markup

I think some of your patch already went into sparse. If there are some
missing. Feel free to submit it again.

> (In fact, if you're generating llvm assembly directly, you may find it
> easier just to add a backend to Clue rather than write your own, er,
> middle-end --- a lot of the simplifications Clue does for languages like
> Javascript also apply to llvm bitcode.)

If every back end needs to do those "simplifications", that means sparse
should be fixed to do it right.

> <plug> Did I mention that Clue is now converting C into Java source that
> runs at 40% of compiled C? </plug>

Oh really, Java?

Chris
