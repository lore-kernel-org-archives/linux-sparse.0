From: Christopher Li <sparse@chrisli.org>
Subject: Re: fun with declarations and definitions
Date: Mon, 2 Feb 2009 14:25:00 -0800
Message-ID: <70318cbf0902021425n3550d961na1ab14bd0d684953@mail.gmail.com>
References: <20090202073018.GB28946@ZenIV.linux.org.uk>
	 <70318cbf0902021217r634f94a0y46fe572091a78634@mail.gmail.com>
	 <20090202205814.GF28946@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.229]:16813 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751502AbZBBWZB (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 2 Feb 2009 17:25:01 -0500
Received: by rv-out-0506.google.com with SMTP id k40so1689763rvb.1
        for <linux-sparse@vger.kernel.org>; Mon, 02 Feb 2009 14:25:00 -0800 (PST)
In-Reply-To: <20090202205814.GF28946@ZenIV.linux.org.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-sparse@vger.kernel.org

On Mon, Feb 2, 2009 at 12:58 PM, Al Viro <viro@zeniv.linux.org.uk> wrote:
> Modifier bits are going to get easier - I have a patch series that
> takes a bunch out (basically, to hell with everything in MOD_SPECIFIER -
> the only hard part is on the parser side and I've got a saner way to
> deal with that).

That sounds like an interesting patch. Cared to shared it? Even it is not
quite ready, I would like to take a look and maybe I can learn some thing.

I want to store more than a few bits attribute information. So I was hacking a
patch to make an separate structure for extended attributes.
Only the symbol that use those extended attribute will have it.
The address space and context will move to the extend attributes
as well. Most of the symbol don't have special attribute, so it will save up
some space overall. Does it sound like some thing sane to do?

Any way, I haven't able to get it to work. The big messy part is when sparse
propagate those attributes, some times it need to keep a separate copy of
the extended attributes, because this extended attribute is option for symbols.
Maybe I should try it again.

Chris
