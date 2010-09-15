From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] Fixup and cleanup of the modifier_string() function
Date: Wed, 15 Sep 2010 15:52:58 -0700
Message-ID: <AANLkTi==qDaoGs41HL_v0Mi59ubjux5EQeRMALcG582+@mail.gmail.com>
References: <1282300429.10440.230.camel@thorin>
	<AANLkTikugbBQ1gYVAdFRxWVmEX-odjq+Y5wA4mnN7Vnj@mail.gmail.com>
	<1282466539.5200.1.camel@thorin>
	<AANLkTinT5xhr+C4H71CWx3R9EqHy6ycp8gskjUqjts2Q@mail.gmail.com>
	<1282574577.5200.18.camel@thorin>
	<AANLkTikOGhqVu8+A_kT=95AX=10H_pxhwqLmQr+08zzm@mail.gmail.com>
	<1284475043.6699.152.camel@thorin>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:44071 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754475Ab0IOWxA (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 15 Sep 2010 18:53:00 -0400
Received: by bwz11 with SMTP id 11so1038013bwz.19
        for <linux-sparse@vger.kernel.org>; Wed, 15 Sep 2010 15:52:58 -0700 (PDT)
In-Reply-To: <1284475043.6699.152.camel@thorin>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Bernd Petrovitsch <bernd@sysprog.at>
Cc: linux-sparse@vger.kernel.org

On Tue, Sep 14, 2010 at 7:37 AM, Bernd Petrovitsch <bernd@sysprog.at> wrote:
> They were against git://git.kernel.org/pub/scm/devel/sparse/sparse.git
> which is listed on https://sparse.wiki.kernel.org/index.php/Main_Page.
> But your patch doesn't apply against it. And it doesn't apply against
> git://git.kernel.org/pub/scm/devel/sparse/chrisl/sparse.git - which
> looks at the first glance identical to the above.
>

I think there is some thing wrong in your git setup. May be you did not
checkout the right branch? You can always visit the web link to see
if that match your local "git log".

http://git.kernel.org/?p=devel/sparse/chrisl/sparse.git;a=summary

> I found http://marc.info/?l=linux-sparse&m=126634898432123 but there is
> no "chrisl" branch - at least not in the output of `git branch -a`.
> What I'm doing wrong?

Have your try to clone a clean repository in a new directory?

git clone git://git.kernel.org/pub/scm/devel/sparse/chrisl/sparse.git

That should give you a clean local copy of "chrisl" repository.

There is a better way to deal with remote branch in one git repository.
If you add those to your .git/config:

[remote "chrisl"]
        fetch = +refs/heads/*:refs/remotes/origin/*
        url = git://git.kernel.org/pub/scm/devel/sparse/chrisl/sparse.git
[branch "chrisl"]
        remote = chrisl
        merge = refs/heads/master

You should be able to do:

git fetch chrisl
git checkout chrisl

To get the chrisl branch.

> Signed-off-by: Bernd Petrovitsch <bernd@sysprog.at>

Thanks. The change is pushed.

Chris
