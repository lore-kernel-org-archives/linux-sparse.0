From: Marko Kreen <markokr@gmail.com>
Subject: Re: Detect unused header files?
Date: Thu, 6 Aug 2009 14:14:04 +0300
Message-ID: <e51f66da0908060414n62a34b89n322f516878567141@mail.gmail.com>
References: <20090728181803.GA20845@merkur.ravnborg.org>
	 <70318cbf0907281336p47b68b5cg44a3e7206646cb80@mail.gmail.com>
	 <alpine.LFD.2.00.0907281634400.3974@localhost>
	 <70318cbf0907281349k72a71b8fyc10d80992e4b1db9@mail.gmail.com>
	 <20090728210404.GA21187@merkur.ravnborg.org>
	 <70318cbf0907281438i876e21fja037aed7169aa8bf@mail.gmail.com>
	 <70318cbf0907300355h5cb34671ha452433c4e0b5324@mail.gmail.com>
	 <20090730203633.GA28838@merkur.ravnborg.org>
	 <70318cbf0908041449u4ce5ab30w6700a7081aa4909c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.159]:29311 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751745AbZHFLOE (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 6 Aug 2009 07:14:04 -0400
Received: by fg-out-1718.google.com with SMTP id e12so1045745fga.17
        for <linux-sparse@vger.kernel.org>; Thu, 06 Aug 2009 04:14:04 -0700 (PDT)
In-Reply-To: <70318cbf0908041449u4ce5ab30w6700a7081aa4909c@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Sam Ravnborg <sam@ravnborg.org>, "Robert P. J. Day" <rpjday@crashcourse.ca>, sparse <linux-sparse@vger.kernel.org>

On 8/5/09, Christopher Li <sparse@chrisli.org> wrote:
> On Thu, Jul 30, 2009 at 1:36 PM, Sam Ravnborg<sam@ravnborg.org> wrote:
>  > Thanks for hacking this up!
>  >
>  > I will try it out during the weekend as work permits. Busy...
>
>
> Any updates?
>
>  It seems that top level header file including sub component
>  header file is very common practice, especially on big header
>  file. From the header file itself is not sufficient to determine
>  the included header file is a sub component or some thing
>  new.

Could we have a flag to track top-level headers only?  So that
anything declared in sub-headers will be registered also under
top header file?  This seems more useful scanning mode for regular
user-space code.

-- 
marko
