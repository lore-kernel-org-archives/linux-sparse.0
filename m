From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH v2 0/8] fix uses of killed instructions
Date: Wed, 8 Feb 2017 23:28:05 +0100
Message-ID: <20170208222805.c77ilwchxpg2vnx4@macpro.local>
References: <20170129104808.2500-1-luc.vanoostenryck@gmail.com>
 <CAExDi1RJ8rPE7n7eGmBRnSe3FudW28HF7DkVErmVmniZrwSQJQ@mail.gmail.com>
 <20170208165055.ibu47j2axwi2j53f@macpro.local>
 <CANeU7Qkc1qShbgresJbRZbORuzzcMR28vPvv38kwFxHiE15ZLQ@mail.gmail.com>
 <20170208213544.ahkbsgvikwdb7nsu@macpro.local>
 <CANeU7Qn9CqWmQ-VUY928xm2fogqMGpfEbaBw+LrtfDbOrLTNfQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:34345 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752099AbdBHW2J (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 8 Feb 2017 17:28:09 -0500
Received: by mail-wr0-f196.google.com with SMTP id 89so10087729wrr.1
        for <linux-sparse@vger.kernel.org>; Wed, 08 Feb 2017 14:28:08 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CANeU7Qn9CqWmQ-VUY928xm2fogqMGpfEbaBw+LrtfDbOrLTNfQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Thu, Feb 09, 2017 at 06:13:46AM +0800, Christopher Li wrote:
> On Thu, Feb 9, 2017 at 5:35 AM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> >> Strange. That is the only patch I found in my series.
> >
> > Well, it was the rigth patch in the sense that it had the right
> > log message and stuff but the resulting diff was only correct
> > within a 1 line context. With a 3 lines context 'git am' or
> > a pure 'patch < ...' should have given a conflict as one of
> > the patch that was initialy just after it
> > (1856b3461 "fix killing OP_CAST & friends") made also some
> > changes in the same lines and these two patch have now been
> > exchanged.
> 
> I see. So what happen is that the git am rejects it while
> the patch program has not problem apply the patch. So I take
> the patched version, which was wrong in terms of conflict resolution.
> 
> I go through my logs, similar things happen in the following two commit.
> 
> 684710647 testsuite: check patterns presence or absence in output
> 49118f27e2 testsuite: check the nbr of times a pattern should be present
> 
> "git am" initial rejects it but the patch program accepts it.
> 
> Can you double check this two changes sounds correct to you?
> I did take a second look, seems normal to me.

I just checked, two chunks of the second of these patches are in
another place than what I have here in my original tree but
it's equivalent regarding functionality.

Luc
