From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 28/36] build: use a dot file name instead of local.mk: .sparse.mk
Date: Fri, 10 Nov 2017 03:29:14 +0800
Message-ID: <CANeU7Qn+HstBto1Q7rZsPo-vFxirMMYrW1vrsorQ7PZ9bxG4pg@mail.gmail.com>
References: <20171105162448.72907-1-luc.vanoostenryck@gmail.com>
 <20171105162544.72960-28-luc.vanoostenryck@gmail.com> <57a86c63-05ff-fcfc-41c0-e0a7b1ccc0cf@kleine-koenig.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f180.google.com ([209.85.161.180]:57108 "EHLO
        mail-yw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752622AbdKIT3Q (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 9 Nov 2017 14:29:16 -0500
Received: by mail-yw0-f180.google.com with SMTP id l32so6240644ywh.13
        for <linux-sparse@vger.kernel.org>; Thu, 09 Nov 2017 11:29:15 -0800 (PST)
In-Reply-To: <57a86c63-05ff-fcfc-41c0-e0a7b1ccc0cf@kleine-koenig.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <uwe@kleine-koenig.org>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Mon, Nov 6, 2017 at 4:57 PM, Uwe Kleine-K=C3=B6nig <uwe@kleine-koenig.or=
g> wrote:
>
> Having said that I question if it is a good idea at all to provide a way
> to change the build without dirtying the working copy.
>

I think I am the one that introduce the local.mk. I can explain some of
my usage of it.

I think there are two kind of people.
1) people don't use local.mk. People like to keep the tree clean with
git etc. They don't have local.mk. This does not concern them.

2) People like me using the local.mk.
I mostly use local.mk for the rules that is
1) local. e.g. how many jobs to invoke when start building
2) rules that I need which is local and I need it for every git branch.
   e.g. my rules for the stress test. I want to be able to run stress test
          on each branch as needed. Those stress test has external referenc=
e
          point to the Linux kernel compile results. It is not
suitable to check in
          into git.

Chris
