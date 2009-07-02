From: Christopher Li <sparse@chrisli.org>
Subject: Re: RFC: Move sparse.git inside linux-kernel-2.6.git?
Date: Thu, 2 Jul 2009 16:46:22 -0700
Message-ID: <70318cbf0907021646y3b4a3ef7ieaaea51fa8d3bd51@mail.gmail.com>
References: <20090618192058.GB14086@uranus.ravnborg.org>
	 <20090702232109.GJ19009@feather>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.169]:27644 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751731AbZGBXqT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 2 Jul 2009 19:46:19 -0400
Received: by wf-out-1314.google.com with SMTP id 26so792596wfd.4
        for <linux-sparse@vger.kernel.org>; Thu, 02 Jul 2009 16:46:23 -0700 (PDT)
In-Reply-To: <20090702232109.GJ19009@feather>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@freedesktop.org>
Cc: Sam Ravnborg <sam@ravnborg.org>, linux-sparse@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>

On Thu, Jul 2, 2009 at 4:21 PM, Josh Triplett<josh@freedesktop.org> wro=
te:

> Fortunately, Git offers a good solution to this problem: submodules.
> linux-2.6 could have Sparse as a submodule under the tools/sparse
> directory. =A0Anyone who checked out linux-2.6 via git could then
> near-automatically get a copy of Sparse via git, and release tarballs=
 of
> Linux could fairly easily include Sparse.

That sounds great. That is actually what I am looking for, clean histor=
y
and easy to use in kernel. I describe the similar idea without knowing =
the
git submodules. Now it can even sync nicely with the kernel.

Chris
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
