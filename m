From: Christopher Li <sparse@chrisli.org>
Subject: Re: Detect unused header files?
Date: Thu, 6 Aug 2009 10:39:23 -0700
Message-ID: <70318cbf0908061039r72dfef6kceed5ba879562d0b@mail.gmail.com>
References: <20090728181803.GA20845@merkur.ravnborg.org>
	 <70318cbf0907281336p47b68b5cg44a3e7206646cb80@mail.gmail.com>
	 <alpine.LFD.2.00.0907281634400.3974@localhost>
	 <70318cbf0907281349k72a71b8fyc10d80992e4b1db9@mail.gmail.com>
	 <20090728210404.GA21187@merkur.ravnborg.org>
	 <70318cbf0907281438i876e21fja037aed7169aa8bf@mail.gmail.com>
	 <70318cbf0907300355h5cb34671ha452433c4e0b5324@mail.gmail.com>
	 <20090730203633.GA28838@merkur.ravnborg.org>
	 <70318cbf0908041449u4ce5ab30w6700a7081aa4909c@mail.gmail.com>
	 <e51f66da0908060414n62a34b89n322f516878567141@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-vw0-f183.google.com ([209.85.212.183]:54490 "EHLO
	mail-vw0-f183.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755923AbZHFRjY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 6 Aug 2009 13:39:24 -0400
Received: by vws13 with SMTP id 13so956067vws.22
        for <linux-sparse@vger.kernel.org>; Thu, 06 Aug 2009 10:39:23 -0700 (PDT)
In-Reply-To: <e51f66da0908060414n62a34b89n322f516878567141@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Marko Kreen <markokr@gmail.com>
Cc: Sam Ravnborg <sam@ravnborg.org>, "Robert P. J. Day" <rpjday@crashcourse.ca>, sparse <linux-sparse@vger.kernel.org>

On Thu, Aug 6, 2009 at 4:14 AM, Marko Kreen<markokr@gmail.com> wrote:
> Could we have a flag to track top-level headers only? =A0So that
> anything declared in sub-headers will be registered also under
> top header file? =A0This seems more useful scanning mode for regular
> user-space code.

Yes, we can. It might not help Sam much though because he is
interested to find out unused header file in system header files.

One way to do it is just let stream keep track of its parent and
is_toplevel.

Just add another pass inside show_unused_streams(). Mark all used
stream's parents as used.

Should be straight forward enough to implement base on branch
"unused-include-files". Any brave sparse hackers want to
give it a try?


Chris
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
