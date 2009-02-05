From: Christopher Li <sparse@chrisli.org>
Subject: Re: fun with declarations and definitions
Date: Thu, 5 Feb 2009 14:41:00 -0800
Message-ID: <70318cbf0902051441m3b015affvc33003ac6a733f18@mail.gmail.com>
References: <20090202073018.GB28946@ZenIV.linux.org.uk>
	 <70318cbf0902021907w634ffc6dm693022b23a0eabfc@mail.gmail.com>
	 <20090203041317.GH28946@ZenIV.linux.org.uk>
	 <70318cbf0902051040m7506a365s784a591667358f1f@mail.gmail.com>
	 <498B3435.8010506@knosof.co.uk>
	 <20090205202811.GO28946@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.229]:41057 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750945AbZBEWlB (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 5 Feb 2009 17:41:01 -0500
Received: by rv-out-0506.google.com with SMTP id k40so472458rvb.1
        for <linux-sparse@vger.kernel.org>; Thu, 05 Feb 2009 14:41:00 -0800 (PST)
In-Reply-To: <20090205202811.GO28946@ZenIV.linux.org.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Derek M Jones <derek@knosof.co.uk>, linux-sparse@vger.kernel.org

On Thu, Feb 5, 2009 at 12:28 PM, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> Of course it does need that (and it's not C0X news, obviously).  We still
> have the type handling messed up in a lot of areas, so the plan is to
> sort out the declaration parsing, then get rid of the warts in type
> representation and handling, then deal with composites.


>
> IMO the right way to look at that crap is:
>        * any declaration gives a new struct symbol, with type being the
> composite of that given by declaration and that of previously seen one
> (which, in turn, has gathered all earlier stuff)
>        * type nodes should be treated as expressions, with on-demand
> evaluation and referential transparency (i.e. any rewrite replaces with
> equal).  We are not that far from such state.

Can you elaborate the referential transparency? I currently have a vague
idea of what you are trying to do. Where should I start if I am going
to turn the idea into code. Should we delay the detail of type
information until evaluate stage?


Chris
