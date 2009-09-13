From: Kamil Dudka <kdudka@redhat.com>
Subject: Re: [PATCH] add warnings enum-to-int and int-to-enum
Date: Sun, 13 Sep 2009 22:09:23 +0200
Message-ID: <200909132209.23393.kdudka@redhat.com>
References: <20090830153202.4dc5c58c@s6510> <200909132128.02515.kdudka@redhat.com> <70318cbf0909131255pf2f9ccdob35ef9791dbfd48@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:22544 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751111AbZIMUKY (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Sun, 13 Sep 2009 16:10:24 -0400
In-Reply-To: <70318cbf0909131255pf2f9ccdob35ef9791dbfd48@mail.gmail.com>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Josh Triplett <josh@joshtriplett.org>, linux-sparse@vger.kernel.org

On Sunday 13 of September 2009 21:55:32 Christopher Li wrote:
> On Sun, Sep 13, 2009 at 12:28 PM, Kamil Dudka <kdudka@redhat.com> wrote:
> > Any progress here? I wouldn't like this to become another downstream
> > patch.
>
> Guilty. Too busy this week. I am going to take a look at it again tonight.

Thanks for quick reply! It doesn't hurry actually. I am only trying to keep 
this thread alive :-)

> > I work on a generic layer [1] for processing C sources (for now)
> > supporting SPARSE and gcc 4.5 plug-in as sources. The gcc plug-in [2] now
> > works fairly well and I am going to make the SPARSE client fully
> > equivalent to the plug-in. This will probably need a few more tiny
> > patches for SPARSE to implement what's missing.
> >
> > Is the upstream interested to make SPARSE more useful as a library?
>
> Yes. I am interested in that. If it does not cause additional slow down
> or memory blow. Sure yes.
>
> If it does because it needs to preserve more information, e.g. space and
> comments it would be nice to put it under some options or even compile time
> config option. I care about people don't use those feature can still run
> sparse fast.

I think we'll need to add some extra items to the public SPARSE headers, not 
sure if it's good idea to #ifdef it even there. But I need to analyse what 
exactly is missing first. Now I am only asking whether the idea itself is 
welcome (before starting work on it).

Kamil
