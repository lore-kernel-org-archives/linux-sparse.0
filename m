From: Christopher Li <sparse@chrisli.org>
Subject: Re: Using c2xml on kernel sources
Date: Wed, 23 May 2012 11:30:31 -0700
Message-ID: <CANeU7Q=QCY4mWRhCJ14MyRh_nr3hyP4Yw9M0nYDs8cw2UaxHCA@mail.gmail.com>
References: <CABG-yt06Kw2uFnmrshcHYjgf_cMgzKVdMPe6BXOP2nryhRjBpg@mail.gmail.com>
	<20120320103702.GN3163@mwanda>
	<CABG-yt2bs8wGUgTH9=dPgtD22vER8qd5JFZGXgPj9f+NS-OHmQ@mail.gmail.com>
	<20120320154048.GA7848@mwanda>
	<CABG-yt2rCSESURVA4NOJe6Cwyxj0saTN1oJcMYE3kAgsNtULQA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:38273 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757259Ab2EWSac (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 23 May 2012 14:30:32 -0400
Received: by yhmm54 with SMTP id m54so6892868yhm.19
        for <linux-sparse@vger.kernel.org>; Wed, 23 May 2012 11:30:31 -0700 (PDT)
In-Reply-To: <CABG-yt2rCSESURVA4NOJe6Cwyxj0saTN1oJcMYE3kAgsNtULQA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Shakthi Kannan <shakthimaan@gmail.com>
Cc: linux-sparse@vger.kernel.org

On Wed, May 23, 2012 at 2:59 AM, Shakthi Kannan <shakthimaan@gmail.com> wrote:
>
> MAKEFLAGS+="--dry-run" make C=2 CHECK="c2xml > foo.xml"
> net/ethernet/eth.o > output.txt
>
> eval `tail -2 output.txt | head -1`
>

That is a great tip.

Thanks.

Chris
