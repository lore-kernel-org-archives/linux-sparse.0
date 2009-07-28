From: Christopher Li <sparse@chrisli.org>
Subject: Re: Detect unused header files?
Date: Tue, 28 Jul 2009 14:38:06 -0700
Message-ID: <70318cbf0907281438i876e21fja037aed7169aa8bf@mail.gmail.com>
References: <20090728181803.GA20845@merkur.ravnborg.org>
	 <70318cbf0907281336p47b68b5cg44a3e7206646cb80@mail.gmail.com>
	 <alpine.LFD.2.00.0907281634400.3974@localhost>
	 <70318cbf0907281349k72a71b8fyc10d80992e4b1db9@mail.gmail.com>
	 <20090728210404.GA21187@merkur.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qy0-f179.google.com ([209.85.221.179]:34785 "EHLO
	mail-qy0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753453AbZG1ViH (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 28 Jul 2009 17:38:07 -0400
Received: by qyk9 with SMTP id 9so290470qyk.33
        for <linux-sparse@vger.kernel.org>; Tue, 28 Jul 2009 14:38:06 -0700 (PDT)
In-Reply-To: <20090728210404.GA21187@merkur.ravnborg.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Sam Ravnborg <sam@ravnborg.org>
Cc: "Robert P. J. Day" <rpjday@crashcourse.ca>, sparse <linux-sparse@vger.kernel.org>

On Tue, Jul 28, 2009 at 2:04 PM, Sam Ravnborg<sam@ravnborg.org> wrote:
>
> Agreed on this one.
>
> So we should add some intelligence when we 'fix' these warnings.
> This is sometimes causing us troubles.
>
> I need to see the results before I can judge if this will
> be a big issue.

I don't know. It is not trivial change and lookup_symbol is at the hot path.
Most of the header file does not include unused headers. So I guess amount
the warnings, over 50% will be false positives. We will see.

> The first challenge will anyway to make all the header files self contained.

It is much easier than find out what is not needed.

Can you make a list of all the header files. Then using gcc -c to compile it?
Not self contained header file will failed on compile. Assume you give the right
kernel flags and header file include path.

Chris
