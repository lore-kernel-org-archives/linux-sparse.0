From: Christopher Li <sparse@chrisli.org>
Subject: Re: Detect unused header files?
Date: Tue, 4 Aug 2009 14:49:27 -0700
Message-ID: <70318cbf0908041449u4ce5ab30w6700a7081aa4909c@mail.gmail.com>
References: <20090728181803.GA20845@merkur.ravnborg.org>
	 <70318cbf0907281336p47b68b5cg44a3e7206646cb80@mail.gmail.com>
	 <alpine.LFD.2.00.0907281634400.3974@localhost>
	 <70318cbf0907281349k72a71b8fyc10d80992e4b1db9@mail.gmail.com>
	 <20090728210404.GA21187@merkur.ravnborg.org>
	 <70318cbf0907281438i876e21fja037aed7169aa8bf@mail.gmail.com>
	 <70318cbf0907300355h5cb34671ha452433c4e0b5324@mail.gmail.com>
	 <20090730203633.GA28838@merkur.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-vw0-f172.google.com ([209.85.212.172]:36782 "EHLO
	mail-vw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933085AbZHDVt1 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 4 Aug 2009 17:49:27 -0400
Received: by vws2 with SMTP id 2so1626746vws.4
        for <linux-sparse@vger.kernel.org>; Tue, 04 Aug 2009 14:49:27 -0700 (PDT)
In-Reply-To: <20090730203633.GA28838@merkur.ravnborg.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Sam Ravnborg <sam@ravnborg.org>
Cc: "Robert P. J. Day" <rpjday@crashcourse.ca>, sparse <linux-sparse@vger.kernel.org>

On Thu, Jul 30, 2009 at 1:36 PM, Sam Ravnborg<sam@ravnborg.org> wrote:
> Thanks for hacking this up!
>
> I will try it out during the weekend as work permits. Busy...

Any updates?

It seems that top level header file including sub component
header file is very common practice, especially on big header
file. From the header file itself is not sufficient to determine
the included header file is a sub component or some thing
new.

Chris
