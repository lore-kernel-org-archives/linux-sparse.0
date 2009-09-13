From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] add warnings enum-to-int and int-to-enum
Date: Sun, 13 Sep 2009 12:55:32 -0700
Message-ID: <70318cbf0909131255pf2f9ccdob35ef9791dbfd48@mail.gmail.com>
References: <20090830153202.4dc5c58c@s6510>
	 <200909032054.01900.kdudka@redhat.com>
	 <70318cbf0909031302s255cc0a9ge7bdd2bc5b7f92b9@mail.gmail.com>
	 <200909132128.02515.kdudka@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pz0-f184.google.com ([209.85.222.184]:47291 "EHLO
	mail-pz0-f184.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752491AbZIMTza (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 13 Sep 2009 15:55:30 -0400
Received: by pzk14 with SMTP id 14so2117986pzk.1
        for <linux-sparse@vger.kernel.org>; Sun, 13 Sep 2009 12:55:32 -0700 (PDT)
In-Reply-To: <200909132128.02515.kdudka@redhat.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Kamil Dudka <kdudka@redhat.com>
Cc: Josh Triplett <josh@joshtriplett.org>, linux-sparse@vger.kernel.org

On Sun, Sep 13, 2009 at 12:28 PM, Kamil Dudka <kdudka@redhat.com> wrote:
>
> Any progress here? I wouldn't like this to become another downstream patch.

Guilty. Too busy this week. I am going to take a look at it again tonight.

> I work on a generic layer [1] for processing C sources (for now) supporting
> SPARSE and gcc 4.5 plug-in as sources. The gcc plug-in [2] now works fairly
> well and I am going to make the SPARSE client fully equivalent to the
> plug-in. This will probably need a few more tiny patches for SPARSE
> to implement what's missing.
>
> Is the upstream interested to make SPARSE more useful as a library?

Yes. I am interested in that. If it does not cause additional slow down
or memory blow. Sure yes.

If it does because it needs to preserve more information, e.g. space and
comments it would be nice to put it under some options or even compile time
config option. I care about people don't use those feature can still run
sparse fast.

Chris
