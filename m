From: Kamil Dudka <kdudka@redhat.com>
Subject: Re: [PATCH] add warnings enum-to-int and int-to-enum
Date: Sun, 13 Sep 2009 21:28:02 +0200
Message-ID: <200909132128.02515.kdudka@redhat.com>
References: <20090830153202.4dc5c58c@s6510> <200909032054.01900.kdudka@redhat.com> <70318cbf0909031302s255cc0a9ge7bdd2bc5b7f92b9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:11775 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752331AbZIMT3H (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Sun, 13 Sep 2009 15:29:07 -0400
In-Reply-To: <70318cbf0909031302s255cc0a9ge7bdd2bc5b7f92b9@mail.gmail.com>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Josh Triplett <josh@joshtriplett.org>, linux-sparse@vger.kernel.org

On Thursday 03 of September 2009 22:02:06 Christopher Li wrote:
> On Thu, Sep 3, 2009 at 11:54 AM, Kamil Dudka<kdudka@redhat.com> wrote:
> > Two personalities are still not so many ... have you ever looked to the
> > gcc code? :-)
>
> That is why I don't want to start a trend.
>
> > I didn't say hard, but actually not useful from my point of view. If it's
> > easy for you to split my patch to the two pieces, you are welcome to have
> > a go at that. We can still wait for opinion of the original authors.
> > Perhaps they can bring some light to this problem.
>
> Fair enough .I need to spend more time to digest this patch.

Any progress here? I wouldn't like this to become another downstream patch.

I work on a generic layer [1] for processing C sources (for now) supporting 
SPARSE and gcc 4.5 plug-in as sources. The gcc plug-in [2] now works fairly 
well and I am going to make the SPARSE client fully equivalent to the 
plug-in. This will probably need a few more tiny patches for SPARSE
to implement what's missing.

Is the upstream interested to make SPARSE more useful as a library?

Kamil

[1]http://dudka.no-ip.org/cgi-bin/gitweb.cgi?p=tools;a=blob_plain;f=sl/code_listener.h
[2]http://dudka.no-ip.org/cgi-bin/gitweb.cgi?p=tools;a=blob_plain;f=sl/slplug.c
