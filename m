From: Kamil Dudka <kdudka@redhat.com>
Subject: Re: including sparse headers in C++ code
Date: Sun, 10 Oct 2010 13:52:10 +0200
Message-ID: <201010101352.10864.kdudka@redhat.com>
References: <AANLkTinGSRQYqR2h+V0nAB+vn4xWCGxgbmGHuMm-xHyB@mail.gmail.com> <AANLkTinaDZZmyeaK+rAvLCdZ-90n17WhABRsZGUBBcSH@mail.gmail.com> <1286710919.24953.2.camel@thorin>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:41409 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756176Ab0JJLy3 (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Sun, 10 Oct 2010 07:54:29 -0400
In-Reply-To: <1286710919.24953.2.camel@thorin>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Bernd Petrovitsch <bernd@petrovitsch.priv.at>
Cc: Christopher Li <sparse@chrisli.org>, Josh Triplett <josh@joshtriplett.org>, Tomas Klacko <tomas.klacko@gmail.com>, linux-sparse@vger.kernel.org

On Sunday 10 October 2010 13:41:59 Bernd Petrovitsch wrote:
> On Sam, 2010-10-09 at 14:46 -0700, Christopher Li wrote:
> > On Sat, Oct 9, 2010 at 1:59 PM, Josh Triplett <josh@joshtriplett.org> 
wrote:
> > > It seems reasonable to avoid the use of C++ keywords in Sparse
> > > *headers* (though unnecessary in *source*).  Looks like this will
> > > primarily cause pain due to "enum namespace" and the various places
> > > using it.  Seems easy enough to change those all to "ns".  "new" mostly
> > > seems to get used as a parameter name or local variable name; for the
> > > former we could omit it, and for the latter we could trivially call it
> > > something more specific like "newlist" or "newptr".
> > >
> > > So, I'd tend to guess "patches welcome" (again, for headers only, plus
> > > minimal corresponding source changes when required).  I wouldn't
> > > anticipate other Sparse developers objecting strongly, but if they do
> > > your mail seems like the right way to find out.  The various reasons
> > > given for *not* making the Linux kernel headers compatible don't seem
> > > to apply here, though.
> >
> > Well said. I don't expect sparse to compile in the C++ mode. Making
> > sparse header usable in C++ seems reasonable to me.
>
> Well, sparse uses C99.
> If one #include's <stdbool.h> at some day (as I did;-), than "true" and
> "false" don't work any longer that good as variable names.

The clash of sparse headers with <stdbool.h> should be already fixed:

http://git.kernel.org/?p=devel/sparse/sparse.git;a=commitdiff;h=0be55c9

Kamil
